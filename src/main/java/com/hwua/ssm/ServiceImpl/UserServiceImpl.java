package com.hwua.ssm.ServiceImpl;


import com.hwua.ssm.Dao.UserDao;
import com.hwua.ssm.Service.UserService;
import com.hwua.ssm.entity.User;

import com.hwua.ssm.util.Md5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service("userService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao dao;

    @Override
     @Cacheable(value = "my",key = "'user'+#name")
    public User queryUserByName(String name) {
        return dao.queryUserByName(name);
    }

    @Cacheable(value = "All", key = "'All'+1")
    public List<User> queryAll() {
        return dao.queryAll();
    }

    @Override
    public int updatePwd(String username, String oldpwd, String newpwd) {
        oldpwd = Md5Util.getMd5(oldpwd);
        newpwd = Md5Util.getMd5(newpwd);
        User user = dao.queryUserByNameAndPwd(username, oldpwd);
        if (user == null) {
            //原始密码错误
            return 2;
        } else {
            int a = dao.updatePwd(username, newpwd);
            return a;
        }
    }

    @Override
    public List<Map<String, Object>> queryUser(User user) {
        return dao.queryUser(user);
    }

    @Override
    public int saveOrUpdateUser(User user) {
        int result = 0;
        //判断是更新还是插入，按照有无主键来判断
        if (user.getId() == null) {
            //插入
            //判断角色名是否重复,判断方式就是拿着名字去数据库里查找，找到了就属于重复
            User rr = dao.queryUserByName11(user.getUsername());
            if (rr == null) {
                //名字不重复
                result = dao.addUser(user);
            } else {
                result = 2;
            }

        } else {
            //更新
            //判断角色名是否重复,判断方式就是拿着名字去数据库里查找，找到了就属于重复
            User rr = dao.queryUserByName11(user.getUsername());
            if (rr == null) {
                //名字不重复
                result = dao.updateUser(user);
            } else if (rr.getId().intValue() == user.getId().intValue()) {
                //是自己，可以更新
                result = dao.updateUser(user);
            } else {
                result = 2;
            }
        }
        return result;
    }
    @Override
    public int saveUserAndRole(int userid,List<Map<String, Object>> params) {
        int a=dao.deleteRoleByUserId(userid);
        int b=dao.saveUserAndRole(params);
        return a+b;
    }

    @Override
    public List<Map<String, Object>> queryMenuByUserId(int userid) {
        List<Map<String,Object>> menus=dao.queryMenuByUserId(userid);
        Map<String,Object> father=null;
        Map<String,Object> son=null;
        List<Map<String,Object>> children=null;
        for(int i=0; i<menus.size(); i++){
            father=menus.get(i);
            children=new ArrayList<Map<String,Object>>();
            for(int j=0; j<menus.size(); j++){
                son=menus.get(j);
                if(son.get("pid").toString().equals(father.get("id").toString())){
                    children.add(son);
                }
            }
            father.put("children",children);
        }
        List<Map<String,Object>> result=new ArrayList<Map<String,Object>>();
        result.add(menus.get(0));
        return result;
    }

    @Override
    public List<Map<String, Object>> queryA() {
        List<Map<String,Object>> AAuths=dao.queryA();
        Map<String,Object> father=null;
        Map<String,Object> son=null;
        List<Map<String,Object>> children=null;
        for(int i=0; i<AAuths.size(); i++){
            father=AAuths.get(i);
            children=new ArrayList<Map<String,Object>>();
            //第二层循环，去集合中寻找儿子
            for(int j=0; j<AAuths.size(); j++){
                son=AAuths.get(j);
                if(son.get("pid").toString().equals(father.get("id").toString())){
                    //儿子的pid是父亲的id，就算是对应起来
                    //把儿子们放到集合中
                    children.add(son);
                }
            }
            //在内循环呢完成之后，把收集好的儿子们加入到自己的属性中
            father.put("children",children);
        }
        List<Map<String,Object>> result=new ArrayList<Map<String,Object>>();
        result.add(AAuths.get(0));
        return result;
    }
    @Override
    public List<String> queryUrlByUserId(int userid) {
        return dao.queryUrlByUserId(userid);
    }

    @Override
    public List<String> queryCodeByUserId(int userid) {
        return dao.queryCodeByUserId(userid);
    }
}
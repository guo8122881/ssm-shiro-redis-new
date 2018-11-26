package com.hwua.ssm.Service;


import com.hwua.ssm.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    public User queryUserByName(String name);
    public List<User> queryAll();
    public int updatePwd(String username, String oldpwd, String newpwd);
    public List<Map<String,Object>> queryUser(User user);
    public int saveOrUpdateUser(User user);
    public int saveUserAndRole(int userid, List<Map<String, Object>> params);

    public List<Map<String,Object>> queryMenuByUserId(int userid);
    public List<Map<String,Object>> queryA();
    public List<String> queryUrlByUserId(int userid);

    public List<String> queryCodeByUserId(int userid);

}

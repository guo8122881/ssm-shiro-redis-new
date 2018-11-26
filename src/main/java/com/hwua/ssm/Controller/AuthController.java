package com.hwua.ssm.Controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hwua.ssm.Service.AuthService;
import com.hwua.ssm.entity.Auth;
import com.hwua.ssm.util.UpdateResult;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private AuthService authService;


    @RequestMapping("index")
    @RequiresPermissions(value = "auth")
    public String index(){
        return "auth/auth";
    }

    @RequiresPermissions(value = "auth_query")
    @RequestMapping(value = "queryAllAuth",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String queryAllAuth(){
        List<Map<String ,Object>> auths=authService.queryAllAuth();
        JSONObject result=new JSONObject();
        JSONArray array=(JSONArray) JSONArray.toJSON(auths);
        result.put("total",auths.size());
        result.put("rows",array);
        return result.toJSONString();
    }

    @RequiresPermissions(value = "auth_edit")
    @RequestMapping(value = "/saveOrUpdateAuth",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String saveOrUpdateAuth(Auth auth){
        int a=authService.saveOrUpdateAuth(auth);
        UpdateResult ur=null;
        if(a==1){
            ur=new UpdateResult(true,"操作成功！");
        }else if(a==2){
            ur=new UpdateResult(false,"权限名称重复！");
        }else{
            ur=new UpdateResult(false,"操作失败！");
        }

        return ur.toJSONString();
    }

    @RequestMapping(value = "/deleteAuth",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteAuth(int id){
        int a=authService.deleteAuth(id);
        UpdateResult ur=null;
            if(a==1){
                ur=new UpdateResult(true,"操作成功！");
            }else {
                ur=new UpdateResult(false,"操作失败！");
            }
        return ur.toJSONString();
    }

}

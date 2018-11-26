package com.hwua.ssm.Service;

import com.hwua.ssm.entity.Auth;

import java.util.List;
import java.util.Map;

public interface AuthService {
    public List<Map<String,Object>> queryAllAuth();
    public int saveOrUpdateAuth(Auth auth);
    public int deleteAuth(int id);

}

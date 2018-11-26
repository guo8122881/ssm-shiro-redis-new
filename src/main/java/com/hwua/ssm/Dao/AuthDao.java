package com.hwua.ssm.Dao;

import com.hwua.ssm.entity.Auth;

import java.util.List;
import java.util.Map;

public interface AuthDao {
    public List<Map<String,Object>> queryAllAuth();
    public int addAuth(Auth auth);
    public int updateAuth(Auth auth);
    public Auth queryAuthByName(String name);
    public int deleteAuth(int id);
}

package com.hwua.ssm.util;

import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.util.ByteSource;
import org.junit.Test;

public class test22 {
    @Test
    public void test1(){
        String str3=new Md5Hash("123456","qwerty",64).toString();
        System.out.println("经过MD5加密,加盐之后的值"+str3);
    }
}

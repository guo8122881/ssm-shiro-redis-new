package com.hwua.ssm.entity;

import java.io.Serializable;

public class User implements Serializable {
    //凡是基本数据类型，8中，byte，short,char,int,float,long,double ,boolean
    //我们有时候提一个概念叫简单数据类型=8种基本数据类型+String
    //在实体类中凡是对应的基本数据类型，都试用期封装类型
    private Integer id;
    private String username;
    private String realname;
    private String password;
    private String phone;
    private String email;
    private Integer status;

    public User() {
    }

    public User(Integer id, String username, String realname, String password, String phone, String email, Integer status) {
        this.id = id;
        this.username = username;
        this.realname = realname;
        this.password = password;
        this.phone = phone;
        this.email = email;
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", realname='" + realname + '\'' +
                ", password='" + password + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", status=" + status +
                '}';
    }
}

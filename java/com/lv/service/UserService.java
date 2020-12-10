package com.lv.service;

import com.lv.pojo.PageResult;
import com.lv.pojo.User;

public interface UserService {

    //查询用户
    User findUser(String username, String password);

    //保存用户
    void saveUser(User user);

    //根据用户名称查询用户是否存在
    User findUniqueUsername(String username);

    //分页查询
    PageResult getUserForPage(Integer pageNum);

    //分页查询
    PageResult getUserForPage(Integer pageNum, String uName);

    //根据用户主键查询用户
    User getUserById(Integer uId);

    //更新
    void updateUser(User user);

    //插入
    void insertUser(User user);
}

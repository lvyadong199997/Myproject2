package com.lv.dao;

import com.lv.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {

    //根据名称查询用户
    public User findUser(@Param("username") String username, @Param("password") String password);

    //保存用户
    public void saveUser(User user);

    //根据名称查询用户
    public User findUniqueUsername(String username);

    //获取用户进行分页
    public List<User> getUserForPage(@Param("startIndex") Integer startIndex);

    //根据用户主键查询用户
    public User getUserById(Integer uId);

    //根据用户名称查询用户并进行分页
    public List<User> getUserByName(@Param("uName") String uName, @Param("startIndex") Integer startIndex);

    //插入
    void insertUser(User user);

    //跟新
    void updateUser(User user);
}

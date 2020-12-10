package com.lv.service.impl;

import com.lv.dao.UserDao;
import com.lv.pojo.PageResult;
import com.lv.pojo.User;
import com.lv.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;


    @Override
    public User findUser(String username, String password) {
        User user = userDao.findUser(username, password);
        return user;
    }

    @Override
    public void saveUser(User user) {
        userDao.saveUser(user);
    }

    @Override
    public User findUniqueUsername(String username) {
        User user = userDao.findUniqueUsername(username);
        return user;
    }

    @Override
    public PageResult getUserForPage(Integer pageNum) {
        PageResult<User> pageResult = new PageResult<User>();
        Integer startIndex = pageNum.equals(1) ? 0 : (pageNum - 1) * 10;
        //用户集合
        List<User> userList = userDao.getUserForPage(startIndex);
        //总数量
        Integer totalCount = userDao.getUserForPage(null).size();
        //总页数
        Integer totalPage = totalCount % 10 > 0 ? totalCount / 10 + 1 : totalCount / 10;
        pageResult.setDataList(userList);
        pageResult.setTotal(totalCount);
        pageResult.setTotalPage(totalPage);
        //当前页
        pageResult.setCurrPage(pageNum);
        return pageResult;

    }

    @Override
    public PageResult getUserForPage(Integer pageNum, String uName) {
        PageResult<User> pageResult = new PageResult<User>();
        Integer startIndex = pageNum.equals(1) ? 0 : (pageNum - 1) * 10;
        List<User> userList = userDao.getUserByName(uName, startIndex);
        Integer totalCount = userDao.getUserByName(uName, null).size();
        Integer totalPage = totalCount % 10 > 0 ? totalCount / 10 + 1 : totalCount / 10;
        //封装数据
        pageResult.setDataList(userList);
        pageResult.setTotal(totalCount);
        pageResult.setTotalPage(totalPage);
        pageResult.setCurrPage(pageNum);
        return pageResult;
    }

    @Override
    public User getUserById(Integer uId) {

        User user = userDao.getUserById(uId);

        return user;
    }

    @Override
    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    @Override
    public void insertUser(User user) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
        String time = sdf.format(new Date());
        user.setRegisterTime(time);
        userDao.insertUser(user);
    }
}

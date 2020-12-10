package com.lv.service;

import com.lv.pojo.Lbt;

import java.util.List;

public interface BannerService {

    //查询所有轮播图
    List<Lbt> getAllBanner();

    //根据主键查询轮播图
    Lbt getBannerById(Integer LId);

    //插入一个轮播图
    void insertOneBanner(Lbt lbt);

    //修改
    void updateOneBanner(Lbt lbt);
}

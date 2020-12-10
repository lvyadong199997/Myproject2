package com.lv.dao;

import com.lv.pojo.Lbt;

import java.util.List;

public interface BannerDao {
    //查询所有轮播图
    List<Lbt> findAllBanner();
    //根据主键查询轮播图
    Lbt findBannerById(Integer L_id);
    //插入一个轮播图
    void insertOneBanner(Lbt lbt);
    //修改
    void updateOneBanner(Lbt lbt);
}

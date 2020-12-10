package com.lv.service.impl;

import com.lv.dao.BannerDao;
import com.lv.pojo.Lbt;
import com.lv.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BannerServiceImpl implements BannerService {

    @Autowired
    BannerDao bannerDao;

    @Override
    public List<Lbt> getAllBanner() {
        return bannerDao.findAllBanner();
    }

    @Override
    public Lbt getBannerById(Integer LId) {

        return bannerDao.findBannerById(LId);
    }

    @Override
    public void insertOneBanner(Lbt lbt) {
        bannerDao.insertOneBanner(lbt);
    }

    @Override
    public void updateOneBanner(Lbt lbt) {
        bannerDao.updateOneBanner(lbt);
    }
}

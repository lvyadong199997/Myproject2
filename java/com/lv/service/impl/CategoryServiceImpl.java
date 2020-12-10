package com.lv.service.impl;

import com.lv.dao.CategoryDao;
import com.lv.pojo.Category;
import com.lv.pojo.PageResult;
import com.lv.pojo.User;
import com.lv.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {


    @Autowired
    CategoryDao categoryDao;

    @Override
    public PageResult findCategoryForPage(Integer pageNum) {
        PageResult pageResult = new PageResult();
//        Integer startIndex = pageNum.equals(1) ? 0 : (pageNum - 1) * 10;
        //分类集合 不进行分页了
        List<Category> categoryList = categoryDao.getCategoryForPage(null);
        //总数量
        Integer totalCount = categoryDao.getCategoryForPage(null).size();
        //总页数
        Integer totalPage = totalCount % 10 > 0 ? totalCount / 10 + 1 : totalCount / 10;
        pageResult.setCategoriesList(categoryList);
        pageResult.setTotal(totalCount);
        pageResult.setTotalPage(totalPage);
        //当前页
        pageResult.setCurrPage(pageNum);
        return pageResult;
    }

    @Override
    public PageResult getCategoryForPage(Integer pageNum, String cName) {
        PageResult pageResult = new PageResult();
//        Integer startIndex = pageNum.equals(1) ? 0 : (pageNum - 1) * 10;
        List<Category> categoryList = categoryDao.getCategoryByName(cName, null);
        Integer totalCount = categoryDao.getCategoryByName(cName, null).size();
        Integer totalPage = totalCount % 10 > 0 ? totalCount / 10 + 1 : totalCount / 10;
        //封装数据
        pageResult.setCategoriesList(categoryList);
        pageResult.setTotal(totalCount);
        pageResult.setTotalPage(totalPage);
        pageResult.setCurrPage(pageNum);
        return pageResult;
    }

    @Override
    public Category findCategoryById(Integer cId) {
        return categoryDao.getCategoryById(cId);
    }

    @Override
    public void insertOneCategory(Category c) {
        categoryDao.insertOneCategory(c);
    }

    @Override
    public void updateOneCategory(Category c) {
        categoryDao.updateOneCategory(c);
    }

    public List<Category> findAllCategory() {
        return categoryDao.getAllCategory();
    }
}

package com.lv.service;

import com.lv.pojo.Category;
import com.lv.pojo.PageResult;

import java.util.List;

public interface CategoryService {

    //获取所有分类
    public List<Category> findAllCategory();

    //获取所有分类(分页)
    PageResult findCategoryForPage(Integer pageNum);

    //分页查询
    PageResult getCategoryForPage(Integer pageNum, String cName);

    //根据主键查询分类
    Category findCategoryById(Integer cId);

    //插入
    void insertOneCategory(Category c);

    //更新
    void updateOneCategory(Category c);
}

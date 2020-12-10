package com.lv.dao;

import com.lv.pojo.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryDao {

    //获取所有分类
    public List<Category> getAllCategory();

    //获取所有分类(分页)
    public List<Category> getCategoryForPage(@Param("startIndex") Integer startIndex);

    //根据分类名称查询分类
    public List<Category> getCategoryByName(@Param("cName") String cName, @Param("startIndex") Integer startIndex);
    //根据主键查询分类
    Category getCategoryById(Integer cId);
    //插入
    void insertOneCategory(Category c);
    //更新
    void updateOneCategory(Category c);

}

package com.lv.service;

import com.lv.pojo.PageResult;
import com.lv.pojo.Product;

import java.util.List;

public interface ProductService {
    //    cName 分类名称
    public List<Product> getEightProduct(String cName);

    //根据主键查询商品
    Product findProductById(Integer pId);

    //获取跟多 更多页
    PageResult getMore(Integer cId, Integer pageNum, String orderBy);

    //搜索功能
    PageResult getList(String keyword, Integer cId, Integer pageNum, String orderBy);

    //分页查询 默认10页 写死了 pageNum 当前页
    PageResult getProductForPage(Integer pageNum);

    //根据商品名称查询商品
    PageResult getProductByName(String pName, Integer pageNum);

    //插入一个商品
    void insertOneProduct(Product product);

    //更新商品数据
    void updateOneProduct(Product product);
}

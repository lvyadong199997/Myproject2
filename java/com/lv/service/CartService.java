package com.lv.service;

public interface CartService {
    //加入商品到购物车
    void addProduct(Integer pId, Integer count, Integer colorIndex, Integer speciIndex);

    //删除购物车中的商品
    void delProduct(Integer pId, String color, String speci);
}

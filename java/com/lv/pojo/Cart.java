package com.lv.pojo;

import java.util.List;

public class Cart {

    //购物车的总价格
    private Float totalPrice;
    //购物车中商品的总数量
    private Integer totalCount;
    //购物车中的商品项集合
    private List<CartItem> cartItemList;

    @Override
    public String toString() {
        return "Cart{" +
                "totalPrice=" + totalPrice +
                ", totalCount=" + totalCount +
                ", cartItemList=" + cartItemList +
                '}';
    }

    public Float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public List<CartItem> getCartItemList() {
        return cartItemList;
    }

    public void setCartItemList(List<CartItem> cartItemList) {
        this.cartItemList = cartItemList;
    }
}


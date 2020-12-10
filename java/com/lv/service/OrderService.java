package com.lv.service;

import com.lv.pojo.Order;
import com.lv.pojo.OrderSearchMap;
import com.lv.pojo.PageResult;
import com.lv.pojo.User;

import java.util.Map;

public interface OrderService {
    //保存订单
    void save(User user, String address, String payMethod);

    //分页查询订单
    PageResult<Order> getAllOrderForPage(Integer pageNum);

    //获取订单下的所有订单项
    Map<String, Object> getAllOrderItemByOId(Integer oId);

    //跟新
    void updateOneOrder(Order order);

    //条件查询
    PageResult getOrderBySearchMap(OrderSearchMap searchMap, Integer pageNum);
}

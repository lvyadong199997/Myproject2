package com.lv.dao;

import com.lv.pojo.Order;
import com.lv.pojo.OrderItem;
import com.lv.pojo.OrderSearchMap;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderDao {

    //实现了主键回显 order.getO_id
    void insertOneOrder(Order order);

    //分页查询所有的订单
    List<Order> getAllOrderForPage(@Param("startIndex") Integer startIndex);

    //根据订单主键查询订单项
    List<OrderItem> getOrderItemByOid(@Param("oId") Integer oId);

    //根据订单主键查询订单
    Order getOrderById(@Param("oId") Integer oId);

    //根据主键关系订单数据
    void updateOneOrder(Order order);

    //根据查询对象查询订单
    List<Order> getOrderBySearchMap(OrderSearchMap searchMap);
}

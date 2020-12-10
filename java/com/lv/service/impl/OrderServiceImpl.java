package com.lv.service.impl;

import com.lv.dao.OrderDao;
import com.lv.dao.OrderItemDao;
import com.lv.dao.ProductDao;
import com.lv.dao.UserDao;
import com.lv.pojo.*;
import com.lv.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired(required = false)
    HttpSession session;

    @Autowired
    UserDao userDao;

    @Autowired
    OrderDao orderDao;

    @Autowired
    OrderItemDao orderItemDao;

    @Autowired
    ProductDao productDao;

    /**
     * 存储订单
     * 1 查询 user 对象 获取uId
     * 2 先创建一个Order对象
     * 3 再创建OrderItem对象
     */
    @Override
    public void save(User user, String address, String payMethod) {
        //邮箱
        String email = user.getEmail();
        //用户名
        String username = user.getUsername();
        //电话
        String phoneNum = user.getPhoneNum();
        //订单状态 0表示为代付款 1已经付款
        String oStatus = "0";
        //订单创建时间
        String createTime = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss").format(new Date());
//        1 查询 user 对象 获取uId
        User use = userDao.findUniqueUsername(username);
        //用户主键
        Integer uId = use.getU_id();


        //从购物车中获取购物项 遍历存储到数据库中
        Cart cart = (Cart) session.getAttribute("cart");
        List<CartItem> itemList = cart.getCartItemList();

//        2 先创建一个Order对象
        Order order = new Order();
        order.setAddress(address);
        order.setCreateTime(createTime);
        order.setoStatus(oStatus);
        order.setPayMethod(Short.parseShort(payMethod));
        order.setPhone(phoneNum);
        order.setU_id(uId);
        //todo 注意这个地方我直接把购物车中的总价钱存到了order对象中 这个地方其实是有安全隐患的 最好还是出现算一遍
        order.setMoney(cart.getTotalPrice().toString());

        orderDao.insertOneOrder(order);
        //获取订单主键 主键回显
        Integer oId = order.getO_id();
        System.out.println(oId);

//        3 再创建OrderItem对象
        for (CartItem item : itemList) {
            //todo 遍历购物车中的数据 把每一个购物项都换成订单项存到数据库中 这里的价格我写的String类型的 注意
            OrderItem orderItem = new OrderItem();
            orderItem.setP_id(item.getpId());
            orderItem.setU_id(uId);
            orderItem.setCount(item.getCount());
            orderItem.setO_id(oId);
            orderItem.setTotal_fee(item.getTotal().toString());
            orderItem.setColor(item.getColor());
            orderItem.setSpeci(item.getSpeci());
            orderItemDao.insertOneOrderItem(orderItem);
        }

    }

    @Override
    public PageResult<Order> getAllOrderForPage(Integer pageNum) {
        PageResult<Order> pageResult = new PageResult<Order>();
        Integer startIndex = pageNum.equals(1) ? 0 : (pageNum - 1) * 10;
        List<Order> orderList = orderDao.getAllOrderForPage(startIndex);
        for (Order order : orderList) {
            //查询订单对应的用户
            User user = userDao.getUserById(order.getU_id());
            order.setUsername(user.getUsername());
        }
        Integer totalCount = orderDao.getAllOrderForPage(null).size();
        //一页十条数据
        Integer totalPage = totalCount % 10 > 0 ? totalCount / 10 + 1 : totalCount / 10;
        //封装数据
        pageResult.setDataList(orderList);
        pageResult.setTotalPage(totalPage);
        pageResult.setTotal(totalCount);
        pageResult.setCurrPage(pageNum);
        return pageResult;
    }

    /**
     * oId 订单主键
     */
    @Override
    public Map<String, Object> getAllOrderItemByOId(Integer oId) {
        //封装结果
        Map<String, Object> map = new HashMap<>();

        //获取用户名
        Order order = orderDao.getOrderById(oId);
        Integer uId = order.getU_id();
        User user = userDao.getUserById(uId);
        order.setUsername(user.getUsername());

        //获取订单对应的订单项
        List<OrderItem> orderItemList = orderDao.getOrderItemByOid(oId);
        for (OrderItem orderItem : orderItemList) {
            Integer pId = orderItem.getP_id();
            //订单项对应的商品
            Product product = productDao.findProductById(pId);
            //设置商品名称
            orderItem.setpName(product.getpName());
            //设置商品的价格
            orderItem.setPrice(product.getPrice());
        }

        //封装订单
        map.put("order", order);
        //封装订单对象的订单项
        map.put("orderItemList", orderItemList);
        return map;
    }

    @Override
    public void updateOneOrder(Order order) {

        orderDao.updateOneOrder(order);
    }

    @Override
    public PageResult getOrderBySearchMap(OrderSearchMap searchMap, Integer pageNum) {
        //创建一个结果集
        PageResult<Order> pageResult = new PageResult<>();
        //根据用户名称查询订单
        Integer startIndex = pageNum.equals(1) ? 0 : (pageNum - 1) * 10;
        if (searchMap.getUsername() != null && !"".equals(searchMap.getUsername())) {
            String username = searchMap.getUsername();
            Integer uId = userDao.getUserByName(username, null).get(0).getU_id();
            searchMap.setuId(uId);
        }
        //分页查询数据
        searchMap.setStartIndex(startIndex);
        List<Order> orderList = orderDao.getOrderBySearchMap(searchMap);
        for (Order order : orderList) {
            //查询订单对应的用户
            User user = userDao.getUserById(order.getU_id());
            order.setUsername(user.getUsername());
        }
        //查询所有订单数据的长度
        searchMap.setStartIndex(null);
        Integer totalCount = orderDao.getOrderBySearchMap(searchMap).size();
        //计算总页数
        Integer totalPage = totalCount % 10 > 0 ? totalCount / 10 + 1 : totalCount / 10;
        pageResult.setDataList(orderList);
        pageResult.setTotal(totalCount);
        pageResult.setTotalPage(totalPage);
        pageResult.setCurrPage(pageNum);
        return pageResult;
    }
}

package com.lv.controller;


import com.lv.pojo.Cart;
import com.lv.pojo.User;
import com.lv.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@RequestMapping("/order")
@Controller
public class OrderController {

    @Autowired
    OrderService orderService;

    //订单界面的展示
    @RequestMapping("/show")
    public ModelAndView showOrderPage(HttpSession session) {
        //todo 返回订单页面 这个要查询的数据是比较多的 注意
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null && user != null) {
            modelAndView.addObject("user", user);
            modelAndView.addObject("cart", cart);
        }

        modelAndView.setViewName("order");
        return modelAndView;
    }

    /***
     * 添加订单的功能
     * payMethod 付款方式 0 微信 1 支付宝 2 其它
     * user user对象
     * address 订单的地址
     */
    @RequestMapping("/add")
    public String addOrder(String payMethod, User user, String address,HttpSession session) {
        //1 保存订单
        orderService.save(user,address,payMethod);
        //2 清空session中的cart数据
        session.setAttribute("cart",null);
        //3 从定向到首页
        return "redirect:/indexPage";

    }
}

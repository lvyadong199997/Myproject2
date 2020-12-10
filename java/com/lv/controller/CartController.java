package com.lv.controller;

import com.lv.pojo.Cart;
import com.lv.pojo.CartItem;
import com.lv.pojo.User;
import com.lv.service.CartService;
import com.lv.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("/cart")
@Controller
public class CartController {


    @Autowired
    HttpServletRequest request;

    @Autowired
    CartService cartService;

    /**
     * pId 要添加商品的主键
     * count 要添加商品的数量
     * colorIndex 商品颜色的索引
     * speciIndex 商品规格的索引
     * <p>
     * 购物车的添加功能
     */
    @RequestMapping("/add")
    public ModelAndView addCart(Integer pId, Integer count, Integer colorIndex, Integer speciIndex, HttpSession session, HttpServletResponse response) throws Exception {
        User user = (User) session.getAttribute("user");
        ModelAndView modelAndView = new ModelAndView();
        if (user != null) {
            //用户已经登录
            modelAndView = new ModelAndView();
            //调用service层存储到session中
            cartService.addProduct(pId, count, colorIndex, speciIndex);

            modelAndView.setViewName("redirect:/cart/show");
        } else {
            //用户未登录
            //todo 这个地方还可以做一个优化 用户登录完后 跳转到刚才访问的页面
            modelAndView = new ModelAndView("redirect:/loginPage?fromPid="+pId);
        }
        return modelAndView;
    }

    //购物车商品的展示
    @RequestMapping("/show")
    public ModelAndView showCart(HttpSession session) {

        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        ModelAndView modelAndView = new ModelAndView();
        if (cart != null ) {
            //存在购物车
            List<CartItem> cartItemList = cart.getCartItemList();
            modelAndView.addObject("cart", cart);
            modelAndView.setViewName("cart");

        }else if(user != null){
            //或者 用户已经登录
            modelAndView.setViewName("cart");
        }
        else {
            //不存在购物车 用户没有登录
            modelAndView.setViewName("redirect:/loginPage");
        }


        return modelAndView;
    }

    //购物车的删除功能
    @RequestMapping("/del")
    public ModelAndView delFromCart(Integer pId, String color, String speci) {

        speci = speci.replaceAll(" ", "+");
        System.out.println(pId);
        System.out.println(color);
        System.out.println(speci);

        //删除选中的商品
        cartService.delProduct(pId, color, speci);
        //重新查询购物车
        ModelAndView modelAndView = new ModelAndView("redirect:/cart/show");
        return modelAndView;
    }

}

package com.lv.controller;

import com.lv.pojo.Category;
import com.lv.pojo.Product;
import com.lv.service.CategoryService;
import com.lv.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

// 可以扩展一些功能 不比说 验证码 等
//返回一些界面 我就写这个地方了
//todo 注意这里请求的路径我是写死了的 后期要注意一下
@Controller
public class CommonController {

    @Autowired
    CategoryService categoryService;

    @Autowired
    ProductService productService;

    @RequestMapping("/indexPage")
    public ModelAndView index() {
        //Todo 返回首页 附带一些分类数据  这个地方还没有写完 比如还有一些商品的数据没有返回
        ModelAndView modelAndView = new ModelAndView();
        List<Category> categoryList = categoryService.findAllCategory();
        // 手机 电话卡数据
        List<Product> productList = productService.getEightProduct("手机 电话卡");
        // 家电 插线板数据
        List<Product> productList2 = productService.getEightProduct("家电 插线板");
        // 智能 路由器数据
        List<Product> productList3 = productService.getEightProduct("智能 路由器");
        //封装手机 电话卡数据
        modelAndView.addObject("productList", productList);
        //给前端传递一个 手机 电话卡分类主键
        modelAndView.addObject("categoryId1", productList.get(0).getC_id());

        //封装家电 插线板数据
        modelAndView.addObject("productList2", productList2);
        //给前端传递一个 家电 插线板分类主键
        modelAndView.addObject("categoryId2", productList2.get(0).getC_id());

        // 封装智能 路由器数据
        modelAndView.addObject("productList3", productList3);
        //给前端传递一个 智能 路由器分类主键
        modelAndView.addObject("categoryId3", productList3.get(0).getC_id());

        //todo 封装分类数据 这个后期可以存储到redis中
        modelAndView.addObject("categoryList", categoryList);
        //设置模板名
        modelAndView.setViewName("index");
        return modelAndView;
    }

    @RequestMapping("/loginPage")
    public ModelAndView loginPage(Integer fromPid) {
        ModelAndView modelAndView = new ModelAndView();
        //返回登录页面
        if (fromPid != null) {
            //从详情页调到登录页的
            modelAndView.setViewName("login");
            modelAndView.addObject("fromPid", fromPid);
            return modelAndView;
        }
        modelAndView.setViewName("login");
        return modelAndView;
    }

    @RequestMapping("/registerPage")
    public String registerPage() {
        //返回注册页页面
        return "register";
    }

    @RequestMapping("/cartPage")
    public String cartPage() {
        //返回购物车页页面
        return "redirect:/cart/show";
    }

    @RequestMapping("/listPage")
    public String listPage() {
        //返回列表页
        return "list";

    }

    @RequestMapping("/detailPage")
    public String detailPage() {
        //返回详情页
        return "detail";
    }
}

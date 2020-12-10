package com.lv.controller;


import com.lv.pojo.PageResult;
import com.lv.pojo.Product;
import com.lv.pojo.SearchMap;
import com.lv.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductController {

    @Autowired
    ProductService productService;

    /**
     * 商品详情
     * pId 为商品主键
     */
    @RequestMapping("/detail/{pId}")
    public ModelAndView detailPage(@PathVariable Integer pId) {
        //pId 是商品的主键
        ModelAndView modelAndView = new ModelAndView();
        Product p = productService.findProductById(pId);
        modelAndView.addObject("product", p);
        modelAndView.setViewName("detail");
        return modelAndView;
    }

    /**
     * 列表页
     * keyword 搜索的关键字
     * cId 分类id 可以为空 空说明不用进行分类查询
     * pageNum 当前页 可以为空 空表示第一页
     * orderBy  排序方式 可以为空 空表示不进行排序
     * 一个接口完成了商品的一个简单的过滤查询
     * 这个过滤查询个人认为做的还是可以的
     * 其中的原理是我在后台维护了一个查询对象 searchMap 它主要是存储前台传递的查询条件的
     * 这样的话每次前台访问后台的时候 后台记录的就是上一次查询的条件了
     * 而且前台每次发请求的时候 后台都会把这个 searchMap 返回给前台 好让前台更好的完成页面样式的展示
     */
    @RequestMapping("/search")
    public ModelAndView listPage(String keyword, Integer cId, Integer pageNum, String orderBy) {
        //keyword 不需要判空 因为前台判断过了
        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        //剩下的参数我就不判断了 在dao层会进行动态sql语句的创建
        PageResult pageResult = productService.getList(keyword, cId, pageNum, orderBy);
        pageResult.setCurrPage(pageNum);

        //封装查询条件对象
        SearchMap searchMap = new SearchMap();
        searchMap.setCategoryId(cId);
        searchMap.setOrderBy(orderBy);
        searchMap.setKeyword(keyword);

        ModelAndView modelAndView = new ModelAndView();
        //封装数据
        modelAndView.addObject("pageResult", pageResult);
        modelAndView.addObject("searchMap", searchMap);
        modelAndView.setViewName("list");

        return modelAndView;
    }


}

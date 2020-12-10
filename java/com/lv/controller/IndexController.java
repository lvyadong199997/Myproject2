package com.lv.controller;

import com.lv.pojo.PageResult;
import com.lv.pojo.SearchMap;
import com.lv.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

//首页控制器(更多页显示)

@Controller
public class IndexController {


    @Autowired
    ProductService productService;


    /**
     * 返回了解更多页面
     * cId 分类主键
     * pageNum 当前页  如果为空的话默认第一页
     * orderBy 通过什么进行排序 如果为空的话默认不排序 这个我在dao层进行了判断 所以不用在Controller层区进行判断了
     */
    //todo 这个过滤查询的功能该没写 orderBy
    @RequestMapping("/more/{cId}")
    public ModelAndView getMorePage(@PathVariable Integer cId, Integer pageNum, String orderBy) {
        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }

        PageResult pageResult = productService.getMore(cId, pageNum, orderBy);

        SearchMap searchMap = new SearchMap();
        searchMap.setOrderBy(orderBy);
        searchMap.setCategoryId(cId);

        //设置当前页 这个地方我就写这里了 但是注意这个地方不应该写这
        pageResult.setCurrPage(pageNum);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("pageResult", pageResult);
        modelAndView.addObject("searchMap", searchMap);
        modelAndView.setViewName("more");

        return modelAndView;

    }
}

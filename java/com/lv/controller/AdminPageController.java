package com.lv.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lv.pojo.*;
import com.lv.service.*;
import com.lv.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 后台页面显示
 * 后台管理
 */
@RequestMapping("/admin")
@Controller
public class AdminPageController {


    @Autowired
    ProductService productService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    UserService userService;

    @Autowired
    OrderService orderService;

    @Autowired
    BannerService bannerService;


    /**
     * 商品列表
     * pageNum 当前页
     */
    @RequestMapping("/product-list")
    public ModelAndView productListPage(@RequestParam(defaultValue = "1") Integer pageNum,
                                        String pName) {
        ModelAndView modelAndView = new ModelAndView();
        //创建一个Map对象 封装查询的过滤条件
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("pName", pName);
        if (pName != null || "".equals(pName)) {
            //根据商品的名称进行数据的分页查询
            PageResult pageResult = productService.getProductByName(pName, pageNum);
            modelAndView.addObject("pageResult", pageResult);
            modelAndView.addObject("searchMap", searchMap);
            modelAndView.setViewName("admin/product-list");

        } else {
            //没有条件的分页查询
            PageResult pageResult = productService.getProductForPage(pageNum);
            modelAndView.addObject("pageResult", pageResult);
            modelAndView.addObject("searchMap", searchMap);
            modelAndView.setViewName("admin/product-list");
        }

        return modelAndView;
    }

    /**
     * pId 商品主键
     * 商品详情(数据回显)
     */
    @RequestMapping("/product-show")
    public ModelAndView productAddPage(Integer pId, Product p) {
        ModelAndView modelAndView = new ModelAndView("admin/product-add");
        //数据回显
        Product product = productService.findProductById(pId);
        List<Category> categoryList = categoryService.findAllCategory();
        modelAndView.addObject("product", product);
        modelAndView.addObject("categoryList", categoryList);
        return modelAndView;
    }


    /**
     * 商品添加(或者更新)
     */
    @RequestMapping(value = "/product-add", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, String> productAdd(@RequestBody Product p) {
        System.out.println(p);
        Map<String, String> map = new HashMap<>();
        Integer pId = p.getP_id();
        if (pId != null) {
            //商品更新
            productService.updateOneProduct(p);
            map.put("msg", "商品更新成功");
        } else {
            //商品新增
            productService.insertOneProduct(p);
            map.put("msg", "商品增加成功");
        }
        return map;
    }

    /**
     * 商品添加页面的显示
     */
    @GetMapping("/product-add")
    public ModelAndView productAddPage() {
        ModelAndView modelAndView = new ModelAndView("admin/product-add");
        List<Category> categoryList = categoryService.findAllCategory();
        modelAndView.addObject("categoryList", categoryList);
        return modelAndView;
    }

    /**
     * 用户列表
     * pageNum 当前页
     */
    @RequestMapping("/user-list")
    public ModelAndView userListPage(@RequestParam(defaultValue = "1") Integer pageNum,
                                     @RequestParam(value = "uName", required = false) String uName) {
        ModelAndView modelAndView = new ModelAndView("admin/user-list");
        //创建一个Map对象 封装查询的过滤条件
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("uName", uName);
        if (uName != null || "".equals(uName)) {
            //根据名称查询数据
            PageResult pageResult = userService.getUserForPage(pageNum, uName);
            modelAndView.addObject("pageResult", pageResult);
            modelAndView.addObject("searchMap", searchMap);
        } else {
            //无条件查询
            PageResult pageResult = userService.getUserForPage(pageNum);
            modelAndView.addObject("pageResult", pageResult);
            modelAndView.addObject("searchMap", searchMap);
        }

        return modelAndView;
    }


    /**
     * 用户数据回显
     * uId 用户主键
     */
    @RequestMapping("/user-show")
    public ModelAndView userShowPage(Integer uId) {
        ModelAndView modelAndView = new ModelAndView("admin/user-add");
        User user = userService.getUserById(uId);
        modelAndView.addObject("user", user);
        return modelAndView;
    }


    /**
     * 新增用户或者修改用户
     * 异步写的(Ajax请求 返回json数据)
     */
    @RequestMapping(value = "/user-add", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> userAdd(@RequestBody User user) {
        Integer uId = user.getU_id();
        Map<String, String> map = new HashMap<>();
        if (uId != null) {
            //修改数据
            System.out.println("数据修改");
            userService.updateUser(user);
            map.put("msg", "修改成功");
        } else {
            //新增用户
            System.out.println("数据新增");
            userService.insertUser(user);
            map.put("msg", "新增成功");
        }
        return map;
    }


    //用户添加界面显示
    @GetMapping("/user-add")
    public String userAddPage() {
        return "admin/user-add";
    }


    /**
     * 分类列表(没有分页处理)
     */
    @RequestMapping("/category-list")
    public ModelAndView categoryListPage(@RequestParam(defaultValue = "1") Integer pageNum,
                                         @RequestParam(value = "cName", required = false) String cName) {
        ModelAndView modelAndView = new ModelAndView("admin/category-list");
        //创建一个Map对象 封装查询的过滤条件
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("cName", cName);
        if (cName != null) {
            //根据分类名称查询
            PageResult pageResult = categoryService.getCategoryForPage(pageNum, cName);
            modelAndView.addObject("pageResult", pageResult);
            modelAndView.addObject("searchMap", searchMap);
        } else {
            PageResult pageResult = categoryService.findCategoryForPage(pageNum);
            modelAndView.addObject("pageResult", pageResult);
            modelAndView.addObject("searchMap", searchMap);
        }

        return modelAndView;
    }

    /**
     * 分类数据回显
     * cId 分类主键
     */
    @RequestMapping("/category-show")
    public ModelAndView categoryShowPage(Integer cId) {
        ModelAndView modelAndView = new ModelAndView("admin/category-add");
        Category category = categoryService.findCategoryById(cId);
        modelAndView.addObject("category", category);
        return modelAndView;
    }


    /**
     * 新增分类或者修改分类信息
     * 这个地方有个bug 在index首页中 进行数据查询的时候 其中分类的名称是写死了的 所以修改一些分类的名称是 会出bug 注意
     * 异步写的(Ajax请求 返回json数据)
     */
    @RequestMapping(value = "/category-add", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> categoryAdd(@RequestBody Category category) {
        Integer cId = category.getC_id();
        Map<String, String> map = new HashMap<>();
        if (cId != null) {
            //修改数据
            categoryService.updateOneCategory(category);
            map.put("msg", "修改成功");
        } else {
            //新增用户
            categoryService.insertOneCategory(category);
            map.put("msg", "新增成功");
        }
        return map;
    }

    /**
     * 增加分类界面 的显示
     */
    @GetMapping("/category-add")
    public String categoryAddPage() {
        return "admin/category-add";
    }


    /**
     * 轮播图列表(没有分页)
     */
    @RequestMapping("/banner-list")
    public ModelAndView bannerListPage() {
        ModelAndView modelAndView = new ModelAndView("admin/banner-list");
        List<Lbt> lbtList = bannerService.getAllBanner();
        modelAndView.addObject("lbtList", lbtList);
        return modelAndView;
    }

    /**
     * 轮播图数据回显
     */
    @RequestMapping("banner-show")
    public ModelAndView BannerShow(Integer LId) {
        ModelAndView modelAndView = new ModelAndView("admin/banner-edit");
        Lbt lbt = bannerService.getBannerById(LId);
        modelAndView.addObject("lbt", lbt);

        return modelAndView;

    }

    /**
     * 轮播图的添加(或者更新)
     */
    @RequestMapping(value = "/banner-add", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> bannerEditPage(@RequestBody Lbt banner) {
        Map<String, String> map = new HashMap<>();
        Integer id = banner.getL_id();
        if (id != null) {
            //修改数据
            bannerService.updateOneBanner(banner);
            map.put("msg", "修改成功");
        } else {
            //新增数据
            bannerService.insertOneBanner(banner);
            map.put("msg", "新增成功");
        }

        return map;
    }

    //轮播图页面显示
    @GetMapping("/banner-edit")
    public String bannerPage() {
        return "admin/banner-edit";
    }

    /**
     * 文件上传
     */
    @RequestMapping("/upload")
    @ResponseBody
    public Map<String, Object> upload(@RequestParam(name = "file") MultipartFile upload, HttpSession session) {
        //返回的结果
        Map<String, Object> resultMap = new HashMap<>();
//        System.out.println("文件上传");
        String realPath = session.getServletContext().getRealPath("/images");
//        System.out.println(realPath);
        File realFile = new File(realPath);
        if (!realFile.exists()) {
            realFile.mkdirs();
        }
        String uuidName = UUIDUtil.getUUID2();
        //获取扩展名: 获取文件名
        //获取真实的文件名
        String originalFilename = upload.getOriginalFilename();
        //截取字符串，获取文件的扩展名
        String extendName = originalFilename.substring(originalFilename.lastIndexOf("."));
//        System.out.println(extendName);
        //唯一的文件名
        String fileName = uuidName + extendName;
//        System.out.println(fileName);

        try {
            //文件上传成功
            upload.transferTo(new File(realPath, fileName));
            resultMap.put("code", "成功");
            resultMap.put("imageName", fileName);
            return resultMap;
        } catch (Exception e) {
            //文件上传失败
            resultMap.put("code", "-1");
            e.printStackTrace();
            return resultMap;
        }

    }


    /**
     * 订单列表
     * pageNum 当前页
     */

    @RequestMapping("/order-list")
    public ModelAndView orderListPage(@RequestParam(defaultValue = "1") Integer pageNum) {
        ModelAndView modelAndView = new ModelAndView("admin/order-list");
        PageResult<Order> pageResult = orderService.getAllOrderForPage(pageNum);
        modelAndView.addObject("pageResult", pageResult);
        return modelAndView;
    }

    /**
     * oId 订单主键
     * 根据 订单主键 查询对应的订单项
     */
    @RequestMapping("/order-show")
    public ModelAndView orderAddPage(Integer oId) {
        ModelAndView modelAndView = new ModelAndView("admin/order-add");
        Map<String, Object> result = orderService.getAllOrderItemByOId(oId);
        modelAndView.addObject("result", result);
        return modelAndView;
    }

    /**
     * 订单数据份更新
     * Ajax请求
     * RequestBody注解 将前台的json数据绑定到order对象中
     */
    @RequestMapping("/order-update")
    @ResponseBody
    public Map orderUpdate(@RequestBody Order order) {
        Map<String, String> map = new HashMap<>();
        try {
            orderService.updateOneOrder(order);
            map.put("msg", "修改成功");
        } catch (Exception e) {
            map.put("msg", "修改失败");
        }
        return map;
    }

    /**
     * searchMap 封装的查询条件
     * 属性如下:
     * oStatus 订单状态
     * payMethod 订单的支付方式
     * oId 订单主键
     * username 用户名
     * 这里单开了一个模板 用来更好的处理页面
     */
    @RequestMapping("/order-search")
    public ModelAndView orderSearch(OrderSearchMap searchMap,
                                    @RequestParam(defaultValue = "1") Integer pageNum) throws JsonProcessingException {
        ModelAndView modelAndView = new ModelAndView("admin/order-search");
        PageResult pageResult = orderService.getOrderBySearchMap(searchMap, pageNum);
        modelAndView.addObject("pageResult", pageResult);
        modelAndView.addObject("searchMap", searchMap);
        ObjectMapper mapper = new ObjectMapper();
        //将查询对象返回前台(转换为json数据)
        String json = mapper.writeValueAsString(searchMap);
        modelAndView.addObject("jsonMap", json);
        return modelAndView;
    }


    //登录页面的显示
    @RequestMapping("login")
    public String loginPage() {
        return "admin/login";
    }

    //首页的显示
    @RequestMapping("/index")
    public String indexPage() {
        return "admin/index";
    }

    //欢迎页面的显示
    @RequestMapping("/welcome")
    public String welcomePage() {
        return "admin/welcome";
    }

}

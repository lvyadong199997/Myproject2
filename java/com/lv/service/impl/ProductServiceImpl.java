package com.lv.service.impl;

import com.lv.dao.CategoryDao;
import com.lv.dao.ProductDao;
import com.lv.pojo.Category;
import com.lv.pojo.PageResult;
import com.lv.pojo.Product;
import com.lv.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    ProductDao productDao;

    @Autowired
    CategoryDao categoryDao;

    @Override
    public List<Product> getEightProduct(String cName) {
        return productDao.getEightProduct(cName);
    }

    @Override
    public Product findProductById(Integer pId) {
        Product p = productDao.findProductById(pId);
        //处理数据库中不规范的数据
        p.setColorList(HandDBString(p.getpColor()));
        p.setSpeciList(HandDBString(p.getpSpeci()));
        return p;
    }

    /**
     * 这个方法主要是负责返回更多页面的 估计到列表页面还要再写一个方法
     */
    @Override
    public PageResult getMore(Integer cId, Integer pageNum, String orderBy) {
//        1 获取总条数
        Integer total = productDao.getTotalForCategory(cId);
//        2 获取商品集合
        Integer pageSize = 20;
        Integer startIndex = (pageNum - 1) * pageSize;
        List<Product> productList = productDao.findProductByCategoryId(cId, startIndex, orderBy);
//        3 计算总页数
        Integer totalPage;
        if (total % pageSize > 0) {
//            这个是下一页还有商品
            totalPage = total / pageSize + 1;
        } else {
            //这个是下一页没有商品了
            totalPage = total / pageSize;
        }
//        4 获取分类名称
        Category name = productDao.getCategoryName(cId);
        List<Category> CategoryList = new ArrayList<>();
        CategoryList.add(name);
//        5 封装数据
        PageResult pageResult = new PageResult();
        pageResult.setProductList(productList);
        pageResult.setTotal(total);
        pageResult.setTotalPage(totalPage);
        pageResult.setCategoriesList(CategoryList);
        return pageResult;

    }

    /**
     * 返回列表页
     * keyword 搜索的关键字
     * cId 分类id 可以为空 空说明不用进行分类查询
     * pageNum 当前页 可以为空 空表示第一页
     * orderBy  排序方式 可以为空 空表示不进行排序
     */
    @Override
    public PageResult getList(String keyword, Integer cId, Integer pageNum, String orderBy) {
        //1 获取商品集合
        Integer pageSize = 20;
        Integer startIndex = (pageNum - 1) * pageSize;
        List<Product> productList = productDao.findProductByKeyword(keyword, cId, startIndex, orderBy);
        //2 获取所有的分类 这个地方有点小问题 其实不需要每次都查询所有的分类 已改进
        //存储查询后商品的分类 主要是为了去重
        List<Product> productList2 = productDao.findProductByKeyword(keyword, cId, null, orderBy);
        Set<Integer> categorySet = new HashSet<>();
        for (Product product : productList2) {
            categorySet.add(product.getC_id());
        }

        List<Category> categoryList = new ArrayList<>();
        for (Integer id : categorySet) {
            categoryList.add(productDao.getCategoryName(id));
        }

        /*
         * 3 获取数据的总和 如果没有cId 则查询的大小就是搜索数据的数量
         * 如果有cId 则查询的是经过过滤条件的商品数据的的数量
         * */
        Integer total = productDao.getTotalForSearch(keyword, cId);
        //4 计算总页数
        Integer totalPage;

        if (total % pageSize > 0) {
            // 这个是下一页还有商品
            totalPage = total / pageSize + 1;
        } else {
            //这个是下一页没有商品了
            totalPage = total / pageSize;
        }
        //5 获取商品的分类的名称
        Category name = productDao.getCategoryName(cId);
        //6 封装数据
        PageResult pageResult = new PageResult();
        pageResult.setCategoriesList(categoryList);
        pageResult.setProductList(productList);
        pageResult.setTotalPage(totalPage);
        pageResult.setTotal(total);
        return pageResult;
    }

    @Override
    public PageResult getProductForPage(Integer pageNum) {
        PageResult pageResult = new PageResult();
        Integer startIndex = pageNum.equals(1) ? 0 : (pageNum - 1) * 10;
        List<Product> productList = productDao.getProductForPage(startIndex);
        Integer totalCount = productDao.getToalCountProduct();
        //一页十条数据
        Integer totalPage = totalCount % 10 > 0 ? totalCount / 10 + 1 : totalCount / 10;
        //封装数据
        pageResult.setProductList(productList);
        pageResult.setTotalPage(totalPage);
        pageResult.setTotal(totalCount);
        pageResult.setCurrPage(pageNum);
        return pageResult;
    }

    @Override
    public PageResult getProductByName(String pName, Integer pageNum) {
        PageResult pageResult = new PageResult();
        Integer startIndex = pageNum.equals(1) ? 0 : (pageNum - 1) * 10;
        List<Product> productList = productDao.getProductByName(pName, startIndex);
        //商品总数量
        Integer totalCount = productDao.findProductByKeyword(pName, null, null, null).size();
        //一页十条数据
        Integer totalPage = totalCount % 10 > 0 ? totalCount / 10 + 1 : totalCount / 10;
        pageResult.setProductList(productList);
        pageResult.setTotalPage(totalPage);
        pageResult.setTotal(totalCount);
        pageResult.setCurrPage(pageNum);
        return pageResult;
    }

    @Override
    public void insertOneProduct(Product product) {
        productDao.insertOneProduct(product);
    }

    @Override
    public void updateOneProduct(Product product) {
        productDao.updateOneProduct(product);
    }


    /**
     * 处理数据库中不规范的数据
     * 将 ['星际黑', '月光银'] 转换为  [星际黑, 月光银]
     * 字符串数据  转换为  JAVA集合对象
     * 参数 s 为不规范的字符串数据
     */
    public List<String> HandDBString(String s) {
        ArrayList<String> List = new ArrayList<>();
        String s2 = s.trim().substring(1, s.length() - 1);
        String[] colors = s2.replaceAll("'", "").split(",");
        for (String c : colors) {
            List.add(c.trim());
        }
        return List;
    }
}

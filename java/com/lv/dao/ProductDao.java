package com.lv.dao;

import com.lv.pojo.Category;
import com.lv.pojo.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ProductDao {

    //    cName 分类名称
    public List<Product> getEightProduct(String cName);

    //    pId 商品主键
    Product findProductById(Integer pId);

    /**
     * 根据分类id查询数据 要求 排序 分页
     * cId 分类主键
     * StartIndex 从哪一个索引位置开始 limit 0,20
     * limit 20,20  limit 40,20
     * 0或者20就是这个参数的含义
     * orderBy 根据什么排序
     * 这个地方使用了 $ 符号 是因为如果使用#的话 order By默认排序不会生效
     */
    List<Product> findProductByCategoryId(@Param("cId") Integer cId, @Param("StartIndex") Integer StartIndex, @Param("orderBy") String orderBy);

    //查询分类商品的总条数
    Integer getTotalForCategory(Integer cId);

    //获取分类名称
    Category getCategoryName(Integer cId);

    //获取排序后的商品数据 测试使用
    List<Product> getProductByOrderByPrice(Integer cId);

    //模糊查询
    List<Product> findProductByKeyword(@Param("keyword") String keyword, @Param("cId") Integer cId, @Param("StartIndex") Integer StartIndex, @Param("orderBy") String orderBy);

    //获取搜索商品数据的个数
    Integer getTotalForSearch(@Param("keyword") String keyword, @Param("cId") Integer cId);

    //获取商品分页
    List<Product> getProductForPage(Integer startIndex);

    //获取商品总数量
    Integer getToalCountProduct();

    //根据商品名称进行查询
    List<Product> getProductByName(@Param("pName") String pName, @Param("startIndex") Integer startIndex);

    //插入一个商品
    void insertOneProduct(Product product);

    //更新商品数据
    void updateOneProduct(Product product);
}

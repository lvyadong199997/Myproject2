package com.lv.service.impl;

import com.lv.dao.ProductDao;
import com.lv.pojo.Cart;
import com.lv.pojo.CartItem;
import com.lv.pojo.Product;
import com.lv.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;


@Service
public class CartServiceImpl implements CartService {

    //todo 注意这个地方为了测试 我加了一个  required = false
    @Autowired(required = false)
    HttpSession session;

    @Autowired
    ProductDao productDao;


    //    在购物车中添加商品  该操作不涉及数据库的插入操作

    /**
     * pId 要添加商品的主键
     * count 要添加商品的数量
     * colorIndex 商品颜色的索引
     * speciIndex 商品规格的索引
     * <p>
     * 购物车的添加功能
     */
    @Override
    public void addProduct(Integer pId, Integer count, Integer colorIndex, Integer speciIndex) {
        //在session中获取购物车对象
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            //还没有购物车
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        List<CartItem> itemList = cart.getCartItemList();
        if (itemList == null) {
            //如果为空 则new 一个新的集合对象
            itemList = new ArrayList<>();
        }
        //查询数据库 主要是为了得到商品的一些数据
        Product product = productDao.findProductById(pId);
        //对颜色数据进行一些处理
        List<String> colorList = HandDBString(product.getpColor());
        String color = colorList.get(colorIndex);
        //对规格数据进行一些处理
        List<String> speciList = HandDBString(product.getpSpeci());
        String speci = speciList.get(speciIndex);
        //在session中查询数据判断商品数据是否已经存在
        CartItem cartItem = findCartItem(itemList, pId, color, speci);
        if (cartItem != null) {
            //商品已经在购物车中存在 则直接在已经存在的商品中加数量就行了
            //商品已经存在 则直接修改原来的商品的数据就行
            cartItem.setCount(cartItem.getCount() + count);
            String s = new BigDecimal(cartItem.getPrice().toString()).multiply(new BigDecimal(cartItem.getCount().toString())).toString();
            cartItem.setTotal(Float.parseFloat(s));
            calculatePriceAndToalInCart(cart);
        } else {
            //商品在购物车中不存在 创建一个新的 CartItem 对象
            CartItem cartItem1 = new CartItem();
            //设置购物车项的一些属性
            cartItem1.setCount(count);//数量
            cartItem1.setColor(color);//颜色
            cartItem1.setpId(pId);//主键
            cartItem1.setpImg(product.getpImg());//照片
            cartItem1.setPrice(product.getPrice());//价格
            cartItem1.setSpeci(speci);//规格
            //这个地方对商品的名字进行了一些优化 商品名称加上商品的颜色和商品的规格
            //todo 有点bug 商品的名称中的一些数据回重复 记得要清理一下  还有就是列表页中的 全部的样式 也要改一下
            cartItem1.setpName(product.getpName() + " " + color + " " + speci);
            //设置小计 使用 BigDecimal 对数据进行运算
            BigDecimal p = new BigDecimal(product.getPrice().toString());
            BigDecimal c = new BigDecimal(count.toString());
            BigDecimal multiply = p.multiply(c);
            //设置商品的小计
            cartItem1.setTotal(Float.parseFloat(multiply.toString()));
            //添加到购物车集合中
            itemList.add(cartItem1);
            //将购物车集合查询添加到cart对象中
            cart.setCartItemList(itemList);
            //计算购物车的总金额和总数量
            calculatePriceAndToalInCart(cart);


        }
    }

    /***
     *
     * 从购物车中删除商品
     * pId   商品主键
     * color 颜色
     * speci 规格
     */
    @Override
    public void delProduct(Integer pId, String color, String speci) {
        Cart cart = (Cart) session.getAttribute("cart");
        List<CartItem> cartItemList = cart.getCartItemList();
//        查询到要删除的商品
        CartItem cartItem = findCartItem(cartItemList, pId, color, speci);
        boolean flag = cartItemList.remove(cartItem);
        if (flag) {
            cart.setCartItemList(cartItemList);
            calculatePriceAndToalInCart(cart);
            session.setAttribute("cart", cart);

        }
        return;
    }


    /***
     * 查询商品是否存在 如果存在则返回该对象 如果不存在 则返回一个null
     * itemList 购物车项集合
     * pId   商品主键
     * color 颜色
     * speci 规格
     */
    public CartItem findCartItem(List<CartItem> itemList, Integer pId, String color, String speci) {
        //集合为空 则不需要再进行下面的操作
        if (itemList.size() == 0) {
            return null;
        }
        //遍历集合 查询商品
        for (CartItem item : itemList) {
            //item.getpId().equals(pId) 改成 item.getpId()==pId 试试
            if (item.getpId().equals(pId)) {
                //1 主键相同 再进行判断颜色和规格
                if (item.getColor().equals(color) && item.getSpeci().equals(speci)) {
                    //2 颜色和规格页相同 则购物车中已经存在了该商品 则返回该对象
                    return item;
                }
            }
        }
        //商品在购物车项中并不存在 则返回null
        return null;
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

    //计算购物车的总金额和总数量

    /**
     * 计算购物车的总数量和总价格
     * cart 购物车对象
     */
    public void calculatePriceAndToalInCart(Cart cart) {
        List<CartItem> cartItemList = cart.getCartItemList();
        Float totalPrice = 0.0F;
        Integer totalCount = 0;
        for (CartItem cartItem : cartItemList) {
            Integer count = cartItem.getCount();
            Float price = cartItem.getPrice();
            totalCount += count;
            totalPrice += count * price;
        }
        cart.setTotalCount(totalCount);
        cart.setTotalPrice(totalPrice);


    }
}

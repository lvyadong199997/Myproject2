package com.lv.pojo;


import java.util.List;

//商品实体
public class Product {
    //商品主键
    private Integer p_id;
    //商品名称
    private String pName;
    //商品价格
    private Float price;
    //商品描述
    private String pDesc;
    //商品颜色
    private String pColor;
    //商品规格
    private String pSpeci;
    //分类外键
    private Integer c_id;
    //商品库存
    private Integer store;
    //商品照片
    private String pImg;
    //数据库转换的数据 颜色集合
    private List<String> colorList;
    //数据库转换的数据 规格集合
    private List<String> speciList;

    @Override
    public String toString() {
        return "Product{" +
                "p_id=" + p_id +
                ", pName='" + pName + '\'' +
                ", price=" + price +
                ", pDesc='" + pDesc + '\'' +
                ", pColor='" + pColor + '\'' +
                ", pSpeci='" + pSpeci + '\'' +
                ", c_id=" + c_id +
                ", store=" + store +
                ", pImg='" + pImg + '\'' +
                ", colorList=" + colorList +
                ", speciList=" + speciList +
                '}';
    }

    public List<String> getColorList() {
        return colorList;
    }

    public void setColorList(List<String> colorList) {
        this.colorList = colorList;
    }

    public List<String> getSpeciList() {
        return speciList;
    }

    public void setSpeciList(List<String> speciList) {
        this.speciList = speciList;
    }

    public String getpSpeci() {
        return pSpeci;
    }

    public void setpSpeci(String pSpeci) {
        this.pSpeci = pSpeci;
    }

    public Integer getP_id() {
        return p_id;
    }

    public void setP_id(Integer p_id) {
        this.p_id = p_id;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public String getpDesc() {
        return pDesc;
    }

    public void setpDesc(String pDesc) {
        this.pDesc = pDesc;
    }

    public String getpColor() {
        return pColor;
    }

    public void setpColor(String pColor) {
        this.pColor = pColor;
    }

    public Integer getC_id() {
        return c_id;
    }

    public void setC_id(Integer c_id) {
        this.c_id = c_id;
    }

    public Integer getStore() {
        return store;
    }

    public void setStore(Integer store) {
        this.store = store;
    }

    public String getpImg() {
        return pImg;
    }

    public void setpImg(String pImg) {
        this.pImg = pImg;
    }
}

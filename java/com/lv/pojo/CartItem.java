package com.lv.pojo;

public class CartItem {
    //商品主键
    private Integer pId;
    //商品数量
    private Integer count;
    //商品的照片
    private String pImg;
    //商品的名称
    private String pName;
    //商品的颜色
    private String color;
    //商品的规格
    private String speci;
    //商品的小计
    private Float total;
    //商品的价格
    private Float price;

    @Override
    public String toString() {
        return "CartItem{" +
                "pId=" + pId +
                ", count=" + count +
                ", pImg='" + pImg + '\'' +
                ", pName='" + pName + '\'' +
                ", color='" + color + '\'' +
                ", speci='" + speci + '\'' +
                ", total=" + total +
                ", price=" + price +
                '}';
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getpImg() {
        return pImg;
    }

    public void setpImg(String pImg) {
        this.pImg = pImg;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSpeci() {
        return speci;
    }

    public void setSpeci(String speci) {
        this.speci = speci;
    }

    public Float getTotal() {
        return total;
    }

    public void setTotal(Float total) {
        this.total = total;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }
}

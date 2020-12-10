package com.lv.pojo;

//订单项实体
public class OrderItem {
    // 订单项主键
    private Integer oI_id;
    // 商品外键
    private Integer p_id;
    // 用户外键
    private Integer u_id;
    // 商品数量
    private Integer count;
    // 订单外键
    private Integer o_id;
    // 该订单项的总金额
    private String total_fee;
    //该订单项的颜色
    private String color;
    //该订单项的规格
    private String speci;
    //商品名称
    private String pName;
    //商品价格
    private Float price;

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


    @Override
    public String toString() {
        return "OrderItem{" +
                "oI_id=" + oI_id +
                ", p_id=" + p_id +
                ", u_id=" + u_id +
                ", count=" + count +
                ", o_id=" + o_id +
                ", total_fee='" + total_fee + '\'' +
                ", color='" + color + '\'' +
                ", speci='" + speci + '\'' +
                ", pName='" + pName + '\'' +
                ", price=" + price +
                '}';
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

    public Integer getoI_id() {
        return oI_id;
    }

    public void setoI_id(Integer oI_id) {
        this.oI_id = oI_id;
    }

    public Integer getP_id() {
        return p_id;
    }

    public void setP_id(Integer p_id) {
        this.p_id = p_id;
    }

    public Integer getU_id() {
        return u_id;
    }

    public void setU_id(Integer u_id) {
        this.u_id = u_id;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getO_id() {
        return o_id;
    }

    public void setO_id(Integer o_id) {
        this.o_id = o_id;
    }

    public String getTotal_fee() {
        return total_fee;
    }

    public void setTotal_fee(String total_fee) {
        this.total_fee = total_fee;
    }
}

package com.lv.pojo;

//订单实体
public class Order {
    //订单主键
    private Integer o_id;
    //电话
    private String phone;
    //订单状态
    private String oStatus;
    //订单创建时间
    private String createTime;
    //订单的用户
    private Integer u_id;
    //订单付款时间
    private String payTime;
    //订单地址
    private String address;
    //订单总金额  注意这里使用的是字符串
    private String money;
    //付款方式
    private Short payMethod;
    //用户名
    private String username;


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return "Order{" +
                "o_id=" + o_id +
                ", phone='" + phone + '\'' +
                ", oStatus='" + oStatus + '\'' +
                ", createTime='" + createTime + '\'' +
                ", u_id=" + u_id +
                ", payTime='" + payTime + '\'' +
                ", address='" + address + '\'' +
                ", money='" + money + '\'' +
                ", payMethod=" + payMethod +
                '}';
    }

    public Short getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(Short payMethod) {
        this.payMethod = payMethod;
    }

    public Integer getO_id() {
        return o_id;
    }

    public void setO_id(Integer o_id) {
        this.o_id = o_id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getoStatus() {
        return oStatus;
    }

    public void setoStatus(String oStatus) {
        this.oStatus = oStatus;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public Integer getU_id() {
        return u_id;
    }

    public void setU_id(Integer u_id) {
        this.u_id = u_id;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }
}

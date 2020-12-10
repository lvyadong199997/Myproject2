package com.lv.pojo;
//订单查询对象
public class OrderSearchMap {

    private Integer oStatus;
    private Integer payMethod;
    private Integer oId;
    private String username;
    private Integer uId;
    private Integer startIndex;

    @Override
    public String toString() {
        return "OrderSearchMap{" +
                "oStatus=" + oStatus +
                ", payMethod=" + payMethod +
                ", oId=" + oId +
                ", username='" + username + '\'' +
                ", uId=" + uId +
                ", startIndex=" + startIndex +
                '}';
    }

    public Integer getoStatus() {
        return oStatus;
    }

    public void setoStatus(Integer oStatus) {
        this.oStatus = oStatus;
    }

    public Integer getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(Integer payMethod) {
        this.payMethod = payMethod;
    }

    public Integer getoId() {
        return oId;
    }

    public void setoId(Integer oId) {
        this.oId = oId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }

    public Integer getStartIndex() {
        return startIndex;
    }

    public void setStartIndex(Integer startIndex) {
        this.startIndex = startIndex;
    }
}

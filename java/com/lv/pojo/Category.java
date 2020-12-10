package com.lv.pojo;



//分类实体

public class Category {
    //分类id
    private Integer c_id;
    //分类名称
    private String cName;

    public Integer getC_id() {
        return c_id;
    }

    public void setC_id(Integer c_id) {
        this.c_id = c_id;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    @Override
    public String toString() {
        return "Category{" +
                "c_id=" + c_id +
                ", cName='" + cName + '\'' +
                '}';
    }
}

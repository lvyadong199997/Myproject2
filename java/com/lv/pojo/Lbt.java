package com.lv.pojo;

//轮播图实体
public class Lbt {
    //轮播图主键
    private Integer l_id;
    //轮播图存放的路径
    private String image;
    //轮播图描述
    private String imgDesc;
    //轮播图超链接
    private String url;

    @Override
    public String toString() {
        return "Lbt{" +
                "l_id=" + l_id +
                ", image='" + image + '\'' +
                ", imgDesc='" + imgDesc + '\'' +
                ", url='" + url + '\'' +
                '}';
    }

    public Integer getL_id() {
        return l_id;
    }

    public void setL_id(Integer l_id) {
        this.l_id = l_id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getImgDesc() {
        return imgDesc;
    }

    public void setImgDesc(String imgDesc) {
        this.imgDesc = imgDesc;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}

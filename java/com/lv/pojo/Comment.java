package com.lv.pojo;


//商品评论实体
public class Comment {
    //评论主键
    private Integer c_id;
    //用户外键
    private Integer u_id;
    //评论内容
    private String content;
    //评论时间
    private Integer commentTime;
    //商品外键id
    private Integer p_id;

}

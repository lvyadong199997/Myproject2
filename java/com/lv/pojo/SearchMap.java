package com.lv.pojo;

//查询过滤条件  这个会返回给前端 让前端更好的进行数据展示
public class SearchMap {
    //分类主键  选中的分类id
    private Integer categoryId;
    //默认排序方式
    private String orderBy;
    //查询的关键字
    private String keyword;

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    @Override
    public String toString() {
        return "SearchMap{" +
                "categoryId=" + categoryId +
                ", orderBy='" + orderBy + '\'' +
                ", keyword='" + keyword + '\'' +
                '}';
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }
}

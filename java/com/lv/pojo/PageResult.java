package com.lv.pojo;


import java.util.List;

//分页结果集
public class PageResult<T> {
    //总条数
    private Integer total;
    //商品集合
    private List<Product> productList;
    //分类数据集合
    private List<Category> categoriesList;
    //总页数
    private Integer totalPage;
    //当前页
    private Integer currPage;
    //泛型
    private List<T> dataList;

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    public Integer getCurrPage() {
        return currPage;
    }

    public void setCurrPage(Integer currPage) {
        this.currPage = currPage;
    }

    @Override
    public String toString() {
        return "PageResult{" +
                "total=" + total +
                ", productList=" + productList +
                ", categoriesList=" + categoriesList +
                ", totalPage=" + totalPage +
                ", currPage=" + currPage +
                ", dataList=" + dataList +
                '}';
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    public List<Category> getCategoriesList() {
        return categoriesList;
    }

    public void setCategoriesList(List<Category> categoriesList) {
        this.categoriesList = categoriesList;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }
}

<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>列表页</title>
    <link rel="stylesheet" href="css/commom.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/list.css">
    <script src="../js/jquery-3.3.1.min.js"></script>

    <script>
        $(function () {
            //点击搜索
            $("#search").on("click", function () {
                var keyword = $(".search input").val();
                // alert(keyword);
                if (keyword != "") {

                    location.href = "/search?keyword=" + keyword;
                }
            });

            //定点击事件 进行页面的跳转
            $(".filter-list ul li").each(function (index, ele) {
                $(ele).on("click", function (e) {
                    var cId = $(this).attr("cId");
                    location.href = "/search?keyword=${searchMap.keyword}&cId=" + cId;
                })
            });

            //回车搜索
            $("#searchBtn").on("keypress",function (e) {
                if (e.keyCode == "13") {
                    console.log(123);
                    $("#search").click();
                }
            })
        });


    </script>
</head>

<body>
<div class="header clearfix">
    <div class="w clearfix">
        <div class="container left">
            <a href="/indexPage">LYD 商城</a>
        </div>
        <div class="bar right ">

            <c:if test="${cookie.username.name==null}">
                <%--用户未登录--%>
                <a href="/loginPage">
                    <!-- 使用字体图标 -->
                    <span class="iconfont">&#xe725;</span>登录
                </a>
                <a href="/registerPage">
                    <span class="iconfont">&#xe6d6;</span>注册</a>
            </c:if>

            <c:if test="${cookie.username.name!=null}">
                <%--用户已经登录--%>
                <span style="color: #fff">${cookie.username.value} 欢迎您</span>
                <a href="/user/loginOut">
                    退出</a>
            </c:if>

            <a href="/cartPage">
                <span class="iconfont">&#xe656;</span>购物车</a>
        </div>
    </div>
</div>
<!-- 这个是搜索栏 -->
<div class="nav w clearfix">
    <!-- 一个logo -->
    <div class="logo clearfix">
        <a href="/indexPage"></a>

    </div>
    <!-- 一个搜索框 -->
    <div class="search ">
        <input type="text" placeholder="小米10" value="${searchMap.keyword}" id="searchBtn">
    </div>
    <!-- 搜索按钮 -->
    <div class="searchbut ">
        <a href="javascript:;" id="search">
            <!-- <input type="button" value=''> -->
            <span class="iconfont">&#xe602;</span>
        </a>
    </div>
</div>
<!-- 头部结束 -->
<!-- 这里面写商品列表 开始 -->
<div class="search-container clearfix">
    <!-- 面包屑导航 -->
    <div class="breadcrumbs w">
        <a href="javascript:;">首页</a>
        <span class="sep">></span>
        <a href="javascript:;">全部结果</a>
        <span class="sep">></span>
        <span class="" style="color:#757575;">${searchMap.keyword}</span>
    </div>
    <!-- 查询条件 -->
    <div class="search-filter">
        <div class="filter-list w clearfix">
            <ul>
                <span class="label">分类 :</span>

                <%--判断是否有分类主键 没有则默认选择全部分类 全部 样式显示--%>
                <%--这个地方又加了一个平淡分类集合是否为空 pageResult.categoriesList.size() --%>
                <%--总体的效果还是不错的 就这么写了--%>
                <c:if test="${searchMap.categoryId==null or pageResult.categoriesList.size()!=1}">
                    <li class="active" cId="" style="cursor: pointer">全部</li>
                </c:if>

                <%--判断是否有分类主键 有则使用选择分类ID 全部 样式就不在显示了--%>
                <c:if test="${searchMap.categoryId!=null and pageResult.categoriesList.size()==1}">
                    <li cId="" style="cursor: pointer">全部</li>
                </c:if>

                <c:forEach items="${pageResult.categoriesList}" var="category">
                    <%--遍历商品的分类并进行选中样式的显示--%>
                    <c:if test="${searchMap.categoryId==category.c_id or pageResult.categoriesList.size()==1}">
                        <li cId="${category.c_id}">
                            <a href="javascript:;" class="active">${category.cName}</a></li>
                    </c:if>

                    <c:if test="${searchMap.categoryId!=category.c_id and pageResult.categoriesList.size()!=1}">
                        <li cId="${category.c_id}">
                            <a href="javascript:;">${category.cName}</a></li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-- 查询结果 -->
    <div class="search-result w clearfix">
        <div class="order-list clearfix">
            <ul>
                <c:if test="${searchMap.orderBy==null || searchMap.orderBy==''}">
                    <li>
                        <a href="/search?keyword=${searchMap.keyword}&cId=${searchMap.categoryId}" class="active"
                           order="">综合</a>
                    </li>
                    <li>
                        <a href="/search?keyword=${searchMap.keyword}&orderBy=price&cId=${searchMap.categoryId}"
                           order="price">价格</a>
                    </li>

                </c:if>
                <%--这个地方主要是防止 searchMap.orderBy有的时候是空的--%>
                <c:if test="${searchMap.orderBy!=null and searchMap.orderBy!=''}">
                    <li>
                        <a href="/search?keyword=${searchMap.keyword}&cId=${searchMap.categoryId}" order="">综合</a>
                    </li>
                    <li>
                        <a href="/search?keyword=${searchMap.keyword}&orderBy=price&cId=${searchMap.categoryId}"
                           class="active" order="price">价格</a>
                    </li>
                </c:if>

            </ul>

        </div>
        <div class="p_list clearfix">
            <%--这个地方要有20个商品--%>
            <%--遍历商品--%>
            <c:forEach items="${pageResult.productList}" var="product">
                <div class="goods_item">
                    <div class="goods_img">
                        <a href="../detail/${product.p_id}">
                            <img src="../images/${product.pImg}" alt="" width="200px" height="200px">
                        </a>
                    </div>
                    <h2>
                        <a href="../detail/${product.p_id}">${product.pName}</a>
                    </h2>
                    <p>
                        <span class="p_money">${product.price}元</span>
                    </p>
                </div>
            </c:forEach>


        </div>

    </div>

</div>
<!-- 分页标签 -->
<div class="preandnext w">
    <!-- 前一页 -->
    <%--这个需要判断前一页是否会超出页面范围 如果超出就禁用超链接--%>
    <c:if test="${pageResult.currPage-1<=0}">
        <a href="javascript:;">
            <span class="iconfont">&#xe667;</span>
        </a>
    </c:if>
    <c:if test="${pageResult.currPage-1>0}">
        <a href="/search?pageNum=${pageResult.currPage-1}&orderBy=${searchMap.orderBy}&keyword=${searchMap.keyword}&cId=${searchMap.categoryId}">
            <span class="iconfont">&#xe667;</span>
        </a>
    </c:if>


    <c:forEach begin="1" end="${pageResult.totalPage}" var="i">
        <%--判断是否为当前页 如果是则会加上一个样式 --%>
        <c:if test="${i==pageResult.currPage}">
            <a href="javascript:;" class="active2">${pageResult.currPage}</a>
        </c:if>
        <%--不是当前页 如果不是则不会加上样式--%>
        <c:if test="${i!=pageResult.currPage}">
            <a href="/search?pageNum=${i}&orderBy=${searchMap.orderBy}&keyword=${searchMap.keyword}&cId=${searchMap.categoryId}">${i}</a>
        </c:if>
    </c:forEach>

    <!-- 后一页 -->
    <%--这个需要判断后一页是否会超出页面范围 如果超出就禁用超链接--%>
    <c:if test="${pageResult.currPage+1>pageResult.totalPage}">
        <a href="javascript:;">
            <span class="iconfont">&#xe601;</span>
        </a>
    </c:if>
    <c:if test="${pageResult.currPage+1<=pageResult.totalPage}">
        <a href="/search?pageNum=${pageResult.currPage+1}&orderBy=${searchMap.orderBy}&keyword=${searchMap.keyword}&cId=${searchMap.categoryId}">
            <span class="iconfont">&#xe601;</span>
        </a>
    </c:if>


</div>
<!-- 这里面写商品列表 结束 -->
<!-- 尾部开始 -->
<div class="footer w">
    <div class="font_desc w">
        <span>LYD 商城</span>
        <div class="font_desc2 clearfix">
            <!-- 第一列 -->
            <div class="font_desc3 ">
                <ul>
                    <li>
                        <a href="javascript:;">联系我们</a>
                    </li>
                    <li><a href="javascript:;">关于我们</a></li>
                    <li><a href="javascript:;">用户协议</a></li>
                    <li><a href="javascript:;">加入我们</a></li>
                </ul>
            </div>
            <!-- 第二列 -->
            <div class="font_desc4 ">
                <ul>
                    <li>
                        <a href="javascript:;">友情链接</a>
                    </li>
                    <li><a href="javascript:;">隐私政策</a></li>
                    <li><a href="javascript:;">LYD认证</a></li>
                    <li><a href="javascript:;">不骗人的</a></li>
                </ul>
            </div>
            <!-- 第三列 -->
            <div class=" info  right">
                <p>如有侵权 请联系作者</p>
                <p>个人邮箱:1965434913@qq.com</p>
                <p>本商城只供学习使用 不会产生任何商业价值</p>
            </div>
            <div class="position">
                <a href="javascript:;"><img src="./images/logo.png" alt=""></a>
            </div>
        </div>
    </div>
</div>
<!-- 尾部结束 -->
</body>

</html>
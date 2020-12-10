<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>详情页</title>
    <link rel="stylesheet" href="../css/commom.css">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/footer.css">
    <link rel="stylesheet" href="../css/detail.css">


    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/detail.js"></script>

    <script>
        $(function () {
            $("#search").on("click", function () {
                var keyword = $(".search input").val();
                // alert(keyword);
                if(keyword!=""){

                    location.href="/search?keyword="+keyword;
                }
            });

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
        <input type="text" placeholder="小米10" id="searchBtn">
    </div>
    <!-- 搜索按钮 -->
    <div class="searchbut ">
        <a href="/listPage" id="search">
            <!-- <input type="button" value=''> -->
            <span class="iconfont">&#xe602;</span>
        </a>
    </div>
</div>
<!-- 头部结束 -->
<!-- 商品详情开始 -->
<div class="page clearfix ">
    <div class="imgAndPro clearfix">
        <div class="img-left left">
            <a href="javascript:;"><img src="../images/${product.pImg}" alt="" width="400px"></a>
        </div>
        <div class="product-con left">
            <h2>${product.pName}</h2>
            <p class="sale-desc">${product.pDesc}</p>
            <div class="company-info">LYD自营</div>
            <div class="price-info"><span>${product.price}</span> 元</div>
            <div class="buy-option">
                <div class="option_title">选择数量</div>
                <input type="text" value="1" id="pCount">
                <a href="javascript:;" class="add" id="add">+</a>
                <a href="javascript:;" class="sub" id="sub">-</a>

            </div>
            <div class="buy-option">
                <div class="option_title">选择版本</div>
                <ul class="clearfix" id="speci">

                    <c:forEach items="${product.speciList}" var="speci" varStatus="i">

                        <c:if test="${i.index==0}">
                            <%--li标签中的index属性 我会在添加购物车的时候用到 注意--%>
                            <li class="active3" index="${i.index}"><a href="javascript:;"
                                                                      class="active4">${speci==""?"暂无规格数据":speci}</a>
                            </li>
                        </c:if>

                        <c:if test="${i.index!=0}">
                            <li index="${i.index}"><a href="javascript:;">${speci==""?"暂无规格数据":speci}</a></li>
                        </c:if>
                    </c:forEach>

                </ul>
            </div>
            <div class="buy-option">
                <div class="option_title">选择颜色</div>
                <ul class="clearfix" id="color">

                    <c:forEach items="${product.colorList}" var="color" varStatus="i">
                        <c:if test="${i.index==0}">
                            <li class="active3" index="${i.index}"><a href="javascript:;"
                                                                      class="active4">${color==""?"暂无颜色数据":color}</a>
                            </li>
                        </c:if>

                        <c:if test="${i.index!=0}">
                            <li index="${i.index}"><a href="javascript:;" >${color==""?"暂无颜色数据":color}</a></li>
                        </c:if>
                    </c:forEach>


                </ul>
            </div>
            <div class="btn-box">
                <a href="javascript:;" id="addCart">加入购物车</a>
                <a href="javascript:;" onclick="alert('暂无该功能 敬请期待')">收藏</a>
            </div>
        </div>
    </div>

</div>
<!-- 商品详情结束 -->
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
                <a href="javascript:;"><img src="../images/logo.png" alt=""></a>
            </div>
        </div>
    </div>
</div>
<!-- 尾部结束 -->
</body>

</html>
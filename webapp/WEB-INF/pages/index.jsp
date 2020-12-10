<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>首页</title>
    <link rel="stylesheet" href="css/commom.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/footer.css">
    <script src="../js/jquery-3.3.1.min.js"></script>

    <script>
        $(function () {
            //点击搜索
            $("#search").on("click", function () {
                var keyword = $(".search input").val();
                // alert(keyword);
                if(keyword!=""){

                    location.href="/search?keyword="+keyword;
                }else {
                    location.href="/search?keyword="+"小米";
                }
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
<!-- 这个是头部 -->
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
        <input type="text" placeholder="小米" id="searchBtn">
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

<!-- 导航 -->
<div class="side w">
    <!-- 轮播图 -->
    <div class="images w" id="images">
        <ul id="lpt" style="left:-1225.6px" class="clearfix">
            <!-- 这个是最后一张 为了轮播图的效果 -->
            <li>
                <a href="javascript:;"><img src="images/f.png" alt=""></a>
            </li>

            <li>
                <a href="javascript:;"><img src="images/c.jpg" alt=""></a>
            </li>
            <li>
                <a href="javascript:;"><img src="images/d.png" alt=""></a>
            </li>
            <li>
                <a href="javascript:;"><img src="images/e.png" alt=""></a>
            </li>
            <li>
                <a href="javascript:;"><img src="images/f.png" alt=""></a>
            </li>
            <!-- 这是第一张图片 -->
            <li>
                <a href="#"><img src="images/c.jpg" alt=""></a>
            </li>
        </ul>
        <!-- 轮播图的左右箭头 -->
        <div class="arrow">
            <span class="arrow_l iconfont" id="arrow_r">&#xe601;</span>
            <!-- 左边不写了 有点逻辑问题 -->
            <span class="arrow_r iconfont" id="arrow_l">&#xe667;</span>
        </div>


    </div>
    <!-- 侧边导航 -->
    <div class="navlist">
        <ul>
            <%--遍历分类数据--%>
            <c:forEach items="${categoryList}" var="category">
                <li>
                    <a href="/more/${category.c_id}">${category.cName}</a>
                </li>
            </c:forEach>
        </ul>

    </div>
    <!-- 轮播图的点 -->
    <div class="square">
        <ul id="square">
            <li class="squareofactive"></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>
<!-- 手机商品展示 首页的商品数据一般是八个-->
<div class="show w">
    <div class="title clearfix">
        <h2>手机</h2>
        <a href="/more/${categoryId1}">了解更多<span class="iconfont">&#xe601;</span></a>
    </div>
    <div class="shops">
        <div class="sideimg left">
            <img src="./images/g.png" alt="">
        </div>
        <div class="items right">
            <ul class="clearfix">
                <c:forEach items="${productList}" var="product">
                    <li>
                        <a href="/detail/${product.p_id}">
                            <img src="./images/${product.pImg}" alt="" width="200px">
                            <h3 class="title_item">${product.pName}</h3>
                                <%--<p class="desc_item">${product.pDesc}</p>--%>
                            <p class="price">
                                <span class="">${product.price}</span>元
                            </p>
                        </a>
                    </li>
                </c:forEach>


            </ul>
        </div>
    </div>
</div>
<!-- 家电商品展示 注意这里的 .two css选择器-->
<div class="show w">
    <div class="title clearfix">
        <h2>家电</h2>
        <a href="/more/${categoryId2}">了解更多<span class="iconfont">&#xe601;</span></a>
    </div>
    <div class="shops">
        <div class=" left two">
            <!-- 这里可以拆分为为两个商品 -->
            <!-- <img src="./images/g.png" alt=""> -->
            <ul>
                <li>

                    <img src="./images/item02.png" alt="" width="100%" height="100%">
                </li>
                <li><img src="./images/item03.png" alt="" width="100%" height="100%"></li>
            </ul>

        </div>
        <div class="items right">
            <ul class="clearfix">
                <c:forEach items="${productList2}" var="product">
                    <li>
                        <a href="/detail/${product.p_id}">
                            <img src="./images/${product.pImg}" alt="" width="200px">
                            <h3 class="title_item">${product.pName}</h3>
                                <%--<p class="desc_item">${product.pDesc}</p>--%>
                            <p class="price">
                                <span class="">${product.price}</span>元
                            </p>
                        </a>
                    </li>
                </c:forEach>

            </ul>
        </div>
    </div>
</div>
<!-- 智能商品展示 -->
<div class="show w">
    <div class="title clearfix">
        <h2>智能</h2>
        <a href="/more/${categoryId3}">了解更多<span class="iconfont">&#xe601;</span></a>
    </div>
    <div class="shops">
        <div class="sideimg left">
            <img src="./images/g.png" alt="">
        </div>
        <div class="items right">
            <ul class="clearfix">
                <c:forEach items="${productList3}" var="product">
                    <li>
                        <a href="/detail/${product.p_id}">
                            <img src="./images/${product.pImg}" alt="" width="200px">
                            <h3 class="title_item">${product.pName}</h3>
                                <%--<p class="desc_item">${product.pDesc}</p>--%>
                            <p class="price">
                                <span class="">${product.price}</span>元
                            </p>
                        </a>
                    </li>
                </c:forEach>


            </ul>
        </div>
    </div>
</div>
<!-- 商品展示结束 -->
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
<script src="js/jquery-3.3.1.min.js"></script>
<script>
    $(function () {
        // ---轮播图开始
        var ul = document.getElementById("lpt");
        var len = ul.children.length; //6
        var images = document.getElementById("images");
        var i = 1;
        var width = -1225.6;
        var timer;
        // 轮播图的点
        var lis = $(" .side .square ul li");


        // 添加过度事件
        ul.addEventListener("transitionend", function () {
            // 自己添加的最左边的图片
            // 自己添加的最右边的图片
            if (parseFloat(ul.style.left) <= 5 * width) {
                ul.style.transition = 'none';
                ul.style.left = width + "px";

                $.each(lis, function (index, ele) {
                    lis.each(function (index, ele) {
                        ele.className = "";
                    })
                });
                i = 1;
                lis[i - 1].className = "squareofactive";
            }


        });

        function next_pic() {

            i++;
            ul.style.transition = "all .3s";
            ul.style.left = i * width + "px";
            $.each(lis, function (index, ele) {
                lis.each(function (index, ele) {
                    ele.className = "";
                })
            });
            if (i < 5) {
                lis[i - 1].className = "squareofactive";
            } else {
                lis[0].className = "squareofactive";
            }

        }


        // 设置轮播图
        var timer;
        timer = setInterval(next_pic, 6000);
        // 鼠标悬浮轮播图 暂停动画
        ul.addEventListener("mousemove", function () {
            clearInterval(timer);

        });
        // 鼠标离开轮播图 恢复动画
        ul.addEventListener("mouseout", function () {
            timer = setInterval(next_pic, 6000);

        });

        // 设置左右箭头

        arrow_r.addEventListener("click", function () {
            next_pic();

        });
    })
</script>

</html>
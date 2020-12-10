<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>购物车</title>
    <!-- 引入css -->
    <link rel="stylesheet" href="../css/commom.css">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/footer.css">
    <link rel="stylesheet" href="../css/cart.css">

    <script src="../js/jquery-3.3.1.min.js"></script>
    <script>
       $(function () {

           // 添加删除点击事件
           $(".delProduct").each(function(index, ele) {
               $(ele).on("click", function() {

                   var param = $(this).parent().siblings("input[type='hidden']").val();
                   var s = param.split(",");
                   location.href="../cart/del?pId="+s[0]+"&color="+s[1]+"&speci="+s[2];
               })
           });

           $("#submit").on("click",function () {
           // ../order/show
                if(parseInt($("#total").html())==0){
                    //购物车中没有商品
                    alert("请先添加商品");
                }else {
                    location.href="../order/show";
                }
           });

       })


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

</div>
<!-- 头部结束 -->
<!-- 这个地方放中间的购物车 -->
<div class="cart w ">
    <div class="cartlist clearfix">

        <div class="list_top clearfix">
            <div class="col" style="width:320px ;text-align: right">商品名称</div>
            <div class="col one_price" style="width:260px ;text-align: right">单价</div>
            <div class="col" style="width:260px ;text-align: center">数量</div>
            <div class="col ">小计</div>
            <div class="col" style="width:260px ;text-align: center">操作</div>
        </div>

        <div class="list_bottom">

            <c:forEach items="${cart.cartItemList}" var="item">
                <!-- 这是一个商品的开始 -->
            <div class="list_top clearfix ">
                <div class="col2 spe" title="${item.pName}">
                 <a href="../detail/${item.pId}"><img src="../images/${item.pImg}" alt="" width="80px" height="80px" title="${item.pName}"> ${item.pName}</a>
                </div>
                <div class="col2 p_price ">${item.price} 元</div>
                <div class="col2">
                    <span class="pCount">${item.count}</span>
                </div>
                <div class="col2"> <span class="pMoney">${item.total} </span> 元</div>
                <div class="col2">
                    <a href="javascript:;" class="delProduct">删除</a> </div>
                <%--<input type="hidden" name="param" value="${item.pId+"#"+item.color+"#"+item.speci}" >--%>
                <input type="hidden" name="param" value="${item.pId},${item.color},${item.speci}" >
            </div>
            </c:forEach>
            <!-- 这是一个商品的结束-->


        </div>

    </div>
    <!-- 提交订单 -->
    <div class="submit">
        <div class="sub_left left">
            <p>共 <span id="total">${cart.totalCount==null?0:cart.totalCount}</span> 件商品 </p>
        </div>
        <div class="sub_right right">
            <a href="javascript:;" id="submit">提交订单</a>
        </div>
        <div class="money right">
            合计 <span class="red" id="totalMoney">${cart.totalPrice==null?0:cart.totalPrice}</span> 元
        </div>
    </div>
    <!-- 提交订单结束 -->
</div>
<!-- 这个地方放中间的购物车 -->
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
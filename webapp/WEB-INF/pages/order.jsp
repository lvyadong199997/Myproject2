<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>订单页面</title>
    <!-- 引入css -->
    <link rel="stylesheet" href="../css/commom.css">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/footer.css">
    <link rel="stylesheet" href="../css/cart.css">
    <link rel="stylesheet" href="../css/order.css">
    <script src="../js/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            //点击搜索
            $("#search").on("click", function () {
                var keyword = $(".search input").val();
                // alert(keyword);
                if (keyword != "") {

                    location.href = "../search?keyword=" + keyword;
                }
            });


            //回车搜索
            $("#searchBtn").on("keypress", function (e) {
                if (e.keyCode == "13") {
                    console.log(123);
                    $("#search").click();
                }
            });

            $(".pay_method div").each(function (index, ele) {
                $(ele).on("click",function () {

                    $(".pay_method div").each(function (index, ele) {
                        ele.className="";
                    });
                    this.className="active";
                    $("#payMethod").val(this.getAttribute("index"));
                })
            });

            $("#submit").on("click",function () {
                $("#data").submit();

                alert("由于个人技术原因 支付功能暂时没有完成 到此为止 订单模块结束 感谢您的使用");
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

</div>
<!-- 头部结束 -->
<!-- 中间的内容开始 -->
<div class="main w">
    <div class="order_top">填写并核对订单信息</div>
    <div class="order">
        <div class="order_main">
            <form action="../order/add" method="post" id="data">
            <div class="hr"></div>
            <div class="info_order">
                <h3>收货人信息</h3>
                <div class="item"><label>收货人:</label><input type="text" name="username" value="${user.username}"
                                                            autocomplete="off" required></div>
                <div class="item"><label>地址:</label><input type="text" name="address" required></div>
                <div class="item"><label>手机号:</label><input type="text" name="phoneNum" value="${user.phoneNum}" required></div>
                <div class="item"><label>邮箱:</label><input type="text" name="email" value="${user.email}" required></div>
            </div>
            <div class="hr"></div>

            <div class="pay_method clearfix">
                <h3>支付方式</h3>
                <div class="active" index="0">微信</div>
                <div class="" index="1">支付宝</div>
                <div class="" index="2">其它</div>
                <input type="hidden" name="payMethod" value="0" id="payMethod">
            </div>

            <div class="hr"></div>
            <div class="product_list">
                <h3>送货清单</h3>
                <table>
                    <tbody>
                    <tr>
                        <th>商品名称</th>
                        <th>单价</th>
                        <th>数量</th>
                        <th>小计</th>
                    </tr>
                    <c:forEach items="${cart.cartItemList}" var="item">
                        <tr>
                            <td>
                                <div class="p_name">
                                    <img src="../images/${item.pImg}" alt="" width="80px" height="80px">${item.pName}
                                </div>
                            </td>
                            <td>
                                <div class="p_price">
                                        ${item.price} 元
                                </div>
                            </td>
                            <td>
                                <div class="p_count">
                                        ${item.count}
                                </div>
                            </td>
                            <td>
                                <div class="p_total">
                                        ${item.total} 元
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="hr"></div>
    <div class="order_bottom clearfix">
        <div>
            <div class="left total">
                <p>共选中 <span>${cart.totalCount}</span> 件商品 </p>
            </div>
            <div class="right pay">
                <a href="javascript:;" id="submit">去付款</a>
            </div>
            <div class="right money">
                合计 <span class="red">${cart.totalPrice}</span> 元
            </div>
        </div>
    </div>
    </form>
</div>
<!-- 中间的内容结束-->
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
                <a href="#"><img src="../images/logo.png" alt=""></a>
            </div>
        </div>
    </div>
</div>
<!-- 尾部结束 -->
</body>

</html>
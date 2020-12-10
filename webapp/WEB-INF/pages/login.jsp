<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>登录</title>
    <link rel="stylesheet" href="../css/commom.css">
    <link rel="stylesheet" href="../css/login.css">
    <style>
        /* css样式 */
    </style>
</head>

<body>
<div class="header w">
    <div class="logo">
        <a href="/indexPage"></a>
    </div>
</div>
<div class="main">
    <form action="../user/login?fromPid=${fromPid}" method="post">
        <div class="login_input">
            <div class="nav_tab">
                <a href="javascript:;">
                    账号登录
                </a>
            </div>
            <!-- 这里看看使不使用form表单 -->
            <!-- 用户名 -->
            <div class="username">
                <input type="text" placeholder="用户名" id="username" name="username" autocomplete="off" autofocus>
                <!-- 字体图标 -->
                <span class="iconfont">&#xe725;</span>
            </div>
            <!-- 密码 -->
            <div class="password">
                <input type="password" placeholder="密码" name="password" autocomplete="off">
                <span class="iconfont">&#xe632;</span>
            </div>

            <%--错误信息--%>
            <span style="color: red ;display: block;margin-top: 5px;margin-left: 46px" id="message">${requestScope.get("message")}</span>

            <!-- 登录按钮 -->
            <div class="btn">
                <input type="submit" value="登录" id="submit">
                <%--<input type="button" value="登录">--%>
            </div>

            <!--  立即注册 忘记密码 -->
            <div class="reverse">
                <a href="/registerPage">立即注册</a> |
                <a href="#">忘记密码</a>
            </div>
        </div>
    </form>
</div>
</div>
<!-- 引入jq -->

</body>

</html>
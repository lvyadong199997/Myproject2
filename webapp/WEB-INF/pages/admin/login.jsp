<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>后台登录-X-admin2.0</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <%--<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />--%>
    <link rel="stylesheet" href="../../css/font.css">
    <link rel="stylesheet" href="../../css/xadmin.css">
    <script type="text/javascript" src="../../js/jquery-3.3.1.min.js"></script>
    <script src="../../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>

</head>

<body class="login-bg">

    <div class="login layui-anim layui-anim-up">
        <div class="message">LYD后台管理系统</div>
        <div id="darkbannerwrap"></div>

        <form method="post" class="layui-form" action="../admin/index">
            <input name="username" placeholder="用户名" type="text" class="layui-input" value="admin">
            <hr class="hr15">
            <input name="password" placeholder="密码" type="password" class="layui-input" value="123456">
            <hr class="hr15">
            <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <%--<a href="../admin/index" style="text-align:center; display: block"> 首页</a>--%>
            <hr class="hr20">
        </form>
    </div>

    <script>
    </script>


</body>

</html>
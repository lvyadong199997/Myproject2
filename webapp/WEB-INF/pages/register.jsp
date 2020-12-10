<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>注册</title>
    <link rel="stylesheet" href="css/commom.css">
    <link rel="stylesheet" href="css/register.css">
</head>

<body>
    <div class="register">
        <div class="logo">
            <a href="/indexPage"></a>
        </div>
        <div class="title">
            <h4>注册帐号</h4>
        </div>
        <form action="/user/register" method="post">
            <div class="username">
                <input type="text" placeholder="手机号" name="phoneNum" autocomplete="off" required autofocus>
            </div>
            <!-- 密码 -->
            <div class="password">
                <input type="email" placeholder="邮箱" name="email" autocomplete="off" required>
            </div>
            <div class="password">
                <input type="text" placeholder="用户名" id="username" name="username" autocomplete="off" required>
                <span style="color: red ;display: block;margin-top: 5px;margin-left: 46px" id="message"></span>
            </div>
            <div class="password">
                <input type="password" placeholder="密码" name="password" autocomplete="off" required>
            </div>
            <div class="password">
                <input type="password" placeholder="确认密码" name="password2" autocomplete="off" required>
            </div>
            <div class="btn">
                <input type="submit" value="注册" id="submit">
                <%--<input type="button" value="登录">--%>
            </div>
        </form>
    </div>
</body>
<script src="../js/jquery-3.3.1.min.js"></script>
<script>
    // 编写js

    $("#username").on("blur",function () {
        if ($("#username").val() != "") {
            $.ajax(
                {
                    url: "../user/findUser",
                    data: {"username":$("#username").val()},
                    datatype: "json",
                    success: function (data) {
                        if(!data.success){
                            //用户名已经存在
                            $("#message").html(data.message);
                            //禁止注册
                            $("#submit").attr({"disabled":"true"});
                            $("#submit").css({"cursor;":"not-allowed"});

                        }else {
                            $("#message").html("");
                            $("#submit").removeAttr("disabled");
                        }


                    }
                });
        }
    });
</script>
</html>
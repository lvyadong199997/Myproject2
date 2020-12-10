<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../../css/font.css">
    <link rel="stylesheet" href="../../css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
    <div class="x-body">
        <form class="layui-form" id="categoryForm">
            <div class="layui-form-item">
                <label for="cId" class="layui-form-label">
                            <span class="x-red"></span>分类主键
                        </label>
                <div class="layui-input-inline">
                    <input type="text" id="cId" name="c_id" value="${category.c_id}"  autocomplete="off" class="layui-input" readonly>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="cName" class="layui-form-label">
                    <span class="x-red"></span>分类名称
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="cName" name="cName" value="${category.cName}" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">
              </label>
                <button class="layui-btn" lay-filter="add" lay-submit="">
                    增加 (修改)
              </button>
            </div>
        </form>
    </div>
    <script>
        layui.use(['form', 'layer'], function() {
            $ = layui.jquery;
            var form = layui.form,
                layer = layui.layer;

            //自定义验证规则
            // form.verify({
            //     nikename: function(value) {
            //         if (value.length < 5) {
            //             return '昵称至少得5个字符啊';
            //         }
            //     },
            //     pass: [/(.+){6,12}$/, '密码必须6到12位'],
            //     repass: function(value) {
            //         if ($('#L_pass').val() != $('#L_repass').val()) {
            //             return '两次密码不一致';
            //         }
            //     }
            // });

            //将表单中的数据转换为Json发送给后台
            function serializeJson(ele) {
                var serializeObj = {};
                $(ele.serializeArray()).each(function () {
                    serializeObj[this.name] = this.value;
                });
                return JSON.stringify(serializeObj);
            };
            //监听提交

            form.on('submit(add)', function (data) {
                //发异步
                $.ajax({
                    url: "../admin/category-add",
                    contentType: "application/json",
                    type: "post",
                    data: serializeJson($("#categoryForm")),
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                        layer.alert(data["msg"], {
                            icon: 6
                        }, function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                            parent.location.reload();
                        });
                    }
                });
                return false;
            });

            // form.on('submit(add)', function(data) {
            //     console.log(data);
            //     //发异步，把数据提交给php
            //     layer.alert("增加成功", {
            //         icon: 6
            //     }, function() {
            //         // 获得frame索引
            //         var index = parent.layer.getFrameIndex(window.name);
            //         //关闭当前frame
            //         parent.layer.close(index);
            //     });
            //     return false;
            // });


        });
    </script>
</body>

</html>
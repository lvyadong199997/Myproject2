<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="../../css/font.css">
    <link rel="stylesheet" href="../../css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/xadmin.js"></script>
</head>

<body>
<div class="x-body">
    <form class="layui-form" id="bannerForm">
        <div class="layui-form-item">
            <label for="id" class="layui-form-label">
                <span class="x-red">*</span>主键
            </label>
            <div class="layui-input-inline">
                <input type="text" id="id" name="l_id" required="" value="${lbt.l_id}" autocomplete="off"
                       class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="link" class="layui-form-label">
                <span class="x-red">*</span>轮播图
            </label>
            <div class="layui-upload">
                <button type="button" class="layui-btn" id="test1">上传图片</button>
                <div class="layui-upload-list">
                    <input type="hidden" name="image" id="imageName">
                    <img class="layui-upload-img" id="demo1" src="../images/${lbt.image}" width="400px">
                    <%--<p id="demoText"></p>--%>
                </div>
            </div>
        </div>


        <div class="layui-form-item">
            <label for="link" class="layui-form-label">
                <span class="x-red">*</span>链接
            </label>
            <div class="layui-input-inline">
                <input type="text" id="link" name="url" value="${lbt.url}" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="desc" class="layui-form-label">
                <span class="x-red">*</span>描述
            </label>
            <div class="layui-input-inline">
                <input type="text" id="desc" name="imgDesc" required="" value="${lbt.imgDesc}" autocomplete="off"
                       class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>
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
    layui.use(['form', 'layer', 'upload'], function () {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer,
            upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            , url: '../admin/upload' //改成您自己的上传接口
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                }
                //上传成功
                $("#imageName").val(res.imageName)
                // $("#imageName").setAttribute("value",res.imageName);
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });

        function serializeJson(ele) {
            var serializeObj = {};
            $(ele.serializeArray()).each(function () {
                serializeObj[this.name] = this.value;
            });
            return JSON.stringify(serializeObj);
        };

        form.on('submit(add)', function (data) {
            //发异步
            $.ajax({
                url: "../admin/banner-add",
                contentType: "application/json",
                type: "post",
                data: serializeJson($("#bannerForm")),
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


        //监听提交
        // form.on('submit(add)', function (data) {
        //     console.log(data);
        //     //发异步，把数据提交给php
        //     layer.alert("增加成功", {
        //         icon: 6
        //     }, function () {
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
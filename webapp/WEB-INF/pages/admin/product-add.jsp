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
</head>

<body>
    <div class="x-body">
        <form class="layui-form" id="productForm" >
            <div class="layui-form-item">
                <label for="username" class="layui-form-label">
                                    <span class="x-red"></span>商品主键
                                </label>
                <div class="layui-input-inline">
                    <input type="text" id="username" value="${product.p_id}" name="p_id"   autocomplete="off" class="layui-input" readonly>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品名称</label>
                <div class="layui-input-block">
                    <input type="text" name="pName"  value="${product.pName}" required lay-verify="required" placeholder="请输入商品名称" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品价格</label>
                <div class="layui-input-inline">
                    <input type="text" name="price" value="${product.price}" required lay-verify="required" placeholder="请输入商品价格" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品照片</label>
                <div class="layui-upload">
                    <button type="button" class="layui-btn" id="test1">上传图片</button>
                    <div class="layui-upload-list">
                        <input type="hidden" name="pImg" value="${product.pImg}" id="imageName">
                        <img class="layui-upload-img" id="demo1" src="../images/${product.pImg}" width="400px">
                        <p id="demoText"></p>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品分类</label>
                <div class="layui-input-inline">
                    <select name="c_id" lay-verify="required">
                        <c:forEach items="${categoryList}" var="category">
                            <c:if test="${product.c_id==category.c_id}">
                                <option value="${category.c_id}" selected>${category.cName}</option>
                            </c:if>
                            <c:if test="${product.c_id!=category.c_id}">
                                <option value="${category.c_id}">${category.cName}</option>
                            </c:if>

                        </c:forEach>
                  </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品规格</label>
                <div class="layui-input-block">
                    <input type="text" name="pSpeci" value="${product.pSpeci}" required lay-verify="required" placeholder="请输入商品规格" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品颜色</label>
                <div class="layui-input-block">
                    <input type="text" name="pColor" value="${product.pColor}" required lay-verify="required" placeholder="请输入商品颜色" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">商品描述</label>
                <div class="layui-input-block">
                    <textarea name="pDesc" placeholder="请输入商品描述" class="layui-textarea" >
                        ${product.pDesc}
                    </textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="abcd" class="layui-form-label">
              </label>
                <button class="layui-btn" lay-filter="add" lay-submit="" id="abcd">
                    增加 (修改)商品
              </button>
                <%--<input type="submit"  class="layui-btn" id="">--%>
            </div>

        </form>
    </div>
    <script>
        layui.use(['form', 'layer','upload'], function() {
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
                    url: "../admin/product-add",
                    contentType: "application/json",
                    type: "post",
                    data: serializeJson($("#productForm")),
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


    <script>
    </script>
</body>

</html>
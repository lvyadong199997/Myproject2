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
    <form class="layui-form" id="orderForm">
        <input type="hidden" name="o_id" value="${result.get("order").o_id}">
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="x-red">*</span>用户名
            </label>
            <div class="layui-input-inline">
                <input type="text" name="username" value="${result.get("order").username}" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="phone" class="layui-form-label">
                <span class="x-red">*</span>手机号
            </label>
            <div class="layui-input-inline">
                <input type="text" id="phone" name="phone" value="${result.get("order").phone}" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="x-red">*</span>收货地址
            </label>
            <div class="layui-input-block">
                <input type="text" name="address" value="${result.get("order").address}" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="x-red">*</span>支付方式
            </label>
            <div class="layui-input-inline">
                <select name="payMethod">
                    <c:if test="${result.get('order').payMethod==0}">
                        <option value="0" selected>微信</option>
                        <option value="1">支付宝</option>
                        <option value="2">其它</option>
                    </c:if>
                    <c:if test="${result.get('order').payMethod==1}">
                        <option value="0" >微信</option>
                        <option value="1" selected>支付宝</option>
                        <option value="2">其它</option>
                    </c:if>
                    <c:if test="${result.get('order').payMethod==2}">
                        <option value="0">微信</option>
                        <option value="1">支付宝</option>
                        <option value="2" selected>其它</option>
                    </c:if>

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="x-red">*</span>订单状态
            </label>
            <div class="layui-input-inline">
                <select name="oStatus">
                    <c:if test="${result.get('order').oStatus==0}">
                        <option value="0" selected>未支付</option>
                        <option value="1">已支付</option>
                    </c:if>
                    <c:if test="${result.get('order').oStatus!=0}">
                        <option value="0">未支付</option>
                        <option value="1" selected>已支付</option>
                    </c:if>
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label for="desc" class="layui-form-label">
                订单详情
            </label>
            <div class="layui-input-block">
                <table class="layui-table">
                    <thead>
                    <tr>
                        <td>商品名称</td>
                        <td>商品单价</td>
                        <td>商品数量</td>
                        <td>商品小计</td>
                        <td>商品颜色</td>
                        <td>商品规格</td>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${result['orderItemList']}" var="orderItem">
                        <tr>
                            <td>${orderItem.pName}</td>
                            <td>${orderItem.price}</td>
                            <td>${orderItem.count}</td>
                            <td>${orderItem.total_fee}</td>
                            <td>${orderItem.color}</td>
                            <td>${orderItem.speci}</td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="x-red">*</span>总金额
            </label>
            <div class="layui-input-inline">
                <input type="text" id="username" name="money" value="${result.get("order").money}" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="x-red">*</span>下单时间
            </label>
            <div class="layui-input-inline">
                <input type="text"  name="createTime" value="${result.get("order").createTime}"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
            </label>
            <button class="layui-btn" lay-filter="add" lay-submit="">
                增加(修改)
            </button>
        </div>
    </form>
</div>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        //自定义验证规则
        // form.verify({
        //     nikename: function (value) {
        //         if (value.length < 5) {
        //             return '昵称至少得5个字符啊';
        //         }
        //     },
        //     pass: [/(.+){6,12}$/, '密码必须6到12位'],
        //     repass: function (value) {
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
                url: "../admin/order-update",
                contentType: "application/json",
                type: "post",
                data: serializeJson($("#orderForm")),
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


    });
</script>

</body>

</html>
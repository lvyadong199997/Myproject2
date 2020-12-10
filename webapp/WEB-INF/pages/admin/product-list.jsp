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
<div class="layui-row" style="margin:20px 0 0 0">
    <div class=" layui-col-md-offset2 layui-col-md4">
        <div class="layui-col-md8"><input type="text" id="searchKey" name="title" required lay-verify="required"
                                          placeholder="请输入商品名称"
                                          autocomplete="off" class="layui-input" value="${searchMap["pName"]}"></div>
        <div class="layui-col-md4">
            <button class="layui-btn" id="searchBtn">查询商品</button>
        </div>
    </div>
</div>
<div class="x-body">

    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn" onclick="x_admin_show('添加商品','./product-add')"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">共有数据：${pageResult.total} 条</span>
    </xblock>

    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i
                        class="layui-icon">&#xe605;</i></div>
            </th>
            <th>商品主键</th>
            <th>商品名称</th>
            <th>商品价格</th>
            <th>商品颜色</th>
            <th>商品规格</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.productList}" var="p">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i
                            class="layui-icon">&#xe605;</i></div>
                </td>
                <td>${p.p_id}</td>
                <td>${p.pName}</td>
                <td>${p.price}</td>
                <td>${p.pColor}</td>
                <td>${p.pSpeci}</td>
                <td class="td-manage">
                    <a title="查看" onclick="x_admin_show('编辑','./product-show?pId=${p.p_id}')" href="javascript:;">
                        <i class="layui-icon">&#xe63c;</i>
                    </a>
                    <a title="删除" onclick="member_del(this,'要删除的id')" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
    <div class="page">
        <div>
            <a class="prev"
               href="../admin/product-list?pageNum=${pageResult.currPage-1==0?1:pageResult.currPage-1}&pName=${searchMap["pName"]}">&lt;&lt;</a>
            <c:forEach begin="1" end="${pageResult.totalPage}" var="i">
                <%--当前页--%>
                <c:if test="${i==pageResult.currPage}">
                    <span class="current">${i}</span>
                </c:if>
                <%--不是当前页--%>
                <c:if test="${i!=pageResult.currPage}">
                    <a class="num" href="../admin/product-list?pageNum=${i}&pName=${searchMap["pName"]}">${i}</a>
                </c:if>
            </c:forEach>
            <a class="next"
               href="../admin/product-list?pageNum=${pageResult.currPage+1>pageResult.totalPage?pageResult.currPage:pageResult.currPage+1}&pName=${searchMap["pName"]}">&gt;&gt;</a>
        </div>
    </div>

</div>
<script>
    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

    /*用户-停用*/
    function member_stop(obj, id) {
        layer.confirm('确认要停用吗？', function (index) {

            if ($(obj).attr('title') == '启用') {

                //发异步把用户状态进行更改
                $(obj).attr('title', '停用')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!', {
                    icon: 5,
                    time: 1000
                });

            } else {
                $(obj).attr('title', '启用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', {
                    icon: 5,
                    time: 1000
                });
            }

        });
    }

    /*用户-删除*/
    function member_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            $(obj).parents("tr").remove();
            layer.msg('已删除!', {
                icon: 1,
                time: 1000
            });
        });
    }


    function delAll(argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？' + data, function (index) {
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {
                icon: 1
            });
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }


    $("#searchBtn").on("click", function (e) {
        var keyword = $("#searchKey").val();
        if (keyword != "") {
            location.href = "../admin/product-list?pName=" + keyword;
        } else {
            location.href = "../admin/product-list";
        }
    });

    //回车搜索
    $("#searchKey").on("keypress", function (e) {
        if (e.keyCode == "13") {
            $("#searchBtn").click();
        }
    });
</script>

</body>

</html>
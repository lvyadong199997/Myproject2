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
    <div class="layui-row">
        <div class="layui-form layui-col-md12 x-so">
            <input type="text" id="searchKey" value="${searchMap["uName"]}" placeholder="请输入用户名" autocomplete="off"
                   class="layui-input">
            <button class="layui-btn" id="searchBtn"><i class="layui-icon">&#xe615;</i></button>
        </div>
    </div>
    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn" onclick="x_admin_show('添加用户','./user-add','800','400')"><i class="layui-icon"></i>添加
        </button>
        <span class="x-right" style="line-height:40px">共有数据：${pageResult.total} 条</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i
                        class="layui-icon">&#xe605;</i></div>
            </th>
            <th>用户ID</th>
            <th>用户名</th>
            <th>手机号</th>
            <th>邮箱</th>
            <th>注册时间</th>
            <th>操作</th>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.dataList}" var="user">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i
                            class="layui-icon">&#xe605;</i></div>
                </td>
                <td>${user.u_id}</td>
                <td>${user.username}</td>
                <td>${user.phoneNum}</td>
                <td>${user.email}</td>
                <td>${user.registerTime}</td>
                <td class="td-manage">
                    <a title="编辑" onclick="x_admin_show('编辑','./user-show?uId=${user.u_id}','800','400')"
                       href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
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
               href="../admin/user-list?pageNum=${pageResult.currPage-1==0?1:pageResult.currPage-1}&uName=${searchMap["uName"]}">&lt;&lt;</a>
            <c:forEach begin="1" end="${pageResult.totalPage}" var="i">
                <c:if test="${i==pageResult.currPage}">
                    <span class="current">${i}</span>
                </c:if>
                <c:if test="${i!=pageResult.currPage}">
                    <a class="num" href="../admin/user-list?pageNum=${i}&uName=${searchMap["uName"]}">${i}</a>
                </c:if>

            </c:forEach>
            <a class="next"
               href="../admin/user-list?pageNum=${pageResult.currPage==pageResult.totalPage?pageResult.totalPage:pageResult.currPage+1}&uName=${searchMap["uName"]}">&gt;&gt;</a>

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
    };

    $("#searchBtn").on("click", function (e) {
        var keyword = $("#searchKey").val();
        // location.href = "../admin/user-list?uName=l";
        if (keyword != "") {
            var url = "../admin/user-list?uName=" + keyword;
            location.href = url;
        } else {
            location.href = "../admin/user-list";
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
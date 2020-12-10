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
        <div class="layui-form layui-col-md12 x-so layui-form-pane">
            <input class="layui-input" id="searchKey" placeholder="分类名" name="cate_name" value="${searchMap["cName"]}">
            <button class="layui-btn" id="searchBtn">查询</button>
        </div>
    </div>

    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn" onclick="x_admin_show('添加用户','./category-add','450','250')"><i
                class="layui-icon"></i>添加
        </button>
        <span class="x-right" style="line-height:40px">共有数据：${pageResult.total} 条</span>
    </xblock>
    <table class="layui-table layui-form">
        <thead>
        <tr>
            <th width="20">
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i
                        class="layui-icon">&#xe605;</i></div>
            </th>
            <th width="70">ID</th>
            <th>分类名称</th>
            <th width="220">操作</th>
        </thead>
        <tbody class="x-cate">
        <c:forEach items="${pageResult.categoriesList}" var="category">
            <tr cate-id="1" fid="0">
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i
                            class="layui-icon">&#xe605;</i></div>
                </td>
                <td>${category.c_id}</td>
                <td>
                    <i class="layui-icon x-show" status='true'></i> ${category.cName}
                </td>
                <td class="td-manage">
                    <button class="layui-btn layui-btn layui-btn-xs"
                            onclick="x_admin_show('编辑','category-show?cId=${category.c_id}','450','250')"><i
                            class="layui-icon">&#xe642;</i>编辑
                    </button>
                    <button class="layui-btn-danger layui-btn layui-btn-xs" onclick="member_del(this,'要删除的id')"
                            href="javascript:;"><i class="layui-icon">&#xe640;</i>删除
                    </button>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>
<style type="text/css">

</style>
<script>
    layui.use(['form'], function () {
        form = layui.form;

    });


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
        // location.href = "../admin/user-list?uName=l";
        if (keyword != "") {
            var url = "../admin/category-list?cName=" + keyword;
            location.href = url;
        } else {
            location.href = "../admin/category-list";
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
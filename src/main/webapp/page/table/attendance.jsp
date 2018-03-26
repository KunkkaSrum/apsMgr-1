<%--
  Created by IntelliJ IDEA.
  User: 黄益华
  Date: 2018/3/24
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title></title>
    <link rel="stylesheet" href="<%=basePath%>control/layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/attendance.css">
    <link rel="stylesheet" href="<%=basePath%>css/common.css">
    <link rel="stylesheet" href="<%=basePath%>control/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>control/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-5" style="padding-left: 0px">
            <div style="display: flex">
                <div class="tree-bg">
                    <ul id="treeObj" class="ztree"></ul>
                </div>
                <div class="tree-bg">
                    <ul id="treeProperty" class="ztree"></ul>
                </div>
            </div>
            <div class="panel-property table-background">
                <table id="propertyTable" class="layui-table" lay-filter="propertyEdit"></table>
            </div>
        </div>
        <div class="col-md-7" style="padding-left: 5px">
            <div class="table-btn">
                <button class="btn btn-primary" id="tableAdd">新增</button>
                <button class="btn btn-danger" id="tableDelete">删除</button>
                <button class="btn btn-primary">保存</button>
                <button class="btn btn-primary">导入</button>
                <button class="btn btn-primary">导出</button>
            </div>
            <div class="table-background">
                <table id="attendanceTable" class="layui-table" lay-filter="attendanceEdit"></table>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="barTimeStart">
    <input type="text" class="layui-input" id="test5" placeholder="yyyy-MM-dd HH:mm:ss">
</script>
<script type="text/html" id="barTimeEnd">
    <input type="text" class="layui-input" id="test6" placeholder="yyyy-MM-dd HH:mm:ss">
</script>

<script id="barTable" type="text/html">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="indexTpl">
    {{d.LAY_TABLE_INDEX+1}}
</script>
<script type="text/javascript" src="<%=basePath%>control/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>js/attendance.js"></script>
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>control/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>control/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<script type="text/javascript">
    var tableDate = [];

    layui.use(['table', 'laydate'], function () {
        var table = layui.table;
        var laydate = layui.laydate;
        var layer = layui.layer;

        $.ajax({
            url: '<%=basePath%>json/tableJson/attendance_json.json'
            , type: "get"
            , async: false
            , success: function (result) {
                tableDate = result;
            }
            , error: function (error) {
                layui.alert("数据出错：" + error);
            }
        });


        table.render({
            elem: '#attendanceTable',
            height: 'full-100',
            page: false,
            size: 'sm',
            cols: [[ //标题栏
                {title: '序号', templet: '#indexTpl', align: 'center', width: 100, rowspan: "2"}//rowspan即纵向跨越的单元格数
                , {align: 'center', title: '出勤模式代码', colspan: '2'}
                , {field: 'mode', title: '模式', width: 120, align: 'center', edit: 'text', rowspan: "2"}
                , {field: 'remark', title: '备注', width: 160, align: 'center', edit: 'text', rowspan: "2"}
                , {fixed: 'right', title: '操作', width: 90, align: 'center', toolbar: '#barTable', rowspan: '2'}
            ], [
                {field: 'timeStart', title: '开始时间', align: 'center', edit: 'text'}
                , {field: 'timeEnd', title: '结束时间', align: 'center', edit: 'text'}
            ]],
            data: tableDate.data,
            limit: tableDate.count
        });

        table.render({
            elem: '#propertyTable',
            url : '<%=basePath%>json/instruction/ins_attendance.json',
            height: 'full-340',
            size: 'sm',
            // skin: 'line',
            even: true,
            page: false,
            cols: [[ //标题栏
                {field: 'property', title: '属性', width: 120}
                , {field: 'value', title: '值', width: 180}
                , {field: 'instruction', title: '说明'}
            ]]
        });

        laydate.render({
            elem: '#test5'
            , type: 'time'
        });
        laydate.render({
            elem: '#test6'
            , type: 'time'
        });

        //监听工具条
        table.on('tool(attendanceEdit)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                layer.msg('ID：' + data.id + ' 的查看操作');
            } else if (obj.event === 'del') {
                layer.confirm('真的删除该行数据吗？', function (index) {
                    obj.del();
                    layer.close(index);
                });
            }
        });


        $("#tableAdd").click(function () {
            var addData = [];
            addData = table.cache["attendanceTable"];
            console.log(table.cache["attendanceTable"]);
            var oneData = {
                "id": 1022,
                "timeStart": "123",
                "timeEnd": "123",
                "mode": "123",
                "remark": "2141"
            };
            addData.push(oneData);
            table.reload("attendanceTable", {
                data: addData
            })
        });
        //
        // $("#tableDelete").click(function () {
        //     var addData  =  table.cache["attendanceTable"];
        //     addData.remove(addData.length-1);
        //     table.reload("attendanceTable", {
        //         data:addData
        //     })
        // })
    });
</script>
<script type="text/javascript">
    var objUrl = "<%=basePath%>json/explain.json";
    var propertyUrl = "<%=basePath%>json/property.json";
    var objNodes = getTreeData(objUrl);
    var propertyNodes = getTreeData(propertyUrl);
    var setting = {
        data: {
            key: {
                title: "t"
            },
            simpleData: {
                enable: true
            }
        },
        callback: {
            onClick: onClick
        }
    };

    // var log, className = "dark";
    //
    // function beforeClick(treeId, treeNode, clickFlag) {
    //     className = (className === "dark" ? "" : "dark");
    //     showLog("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.asd);
    //     return (treeNode.click != false);
    // }

    function onClick(event, treeId, treeNode, clickFlag) {
        showLog("[ " + getTime() + " onClick ]&nbsp;&nbsp;clickFlag = " + clickFlag + " (" + (clickFlag === 1 ? "普通选中" : (clickFlag === 0 ? "<b>取消选中</b>" : "<b>追加选中</b>")) + ")");
    }

    function showLog(str) {
        if (!log) log = $("#log");
        log.append("<li class='" + className + "'>" + str + "</li>");
        if (log.children("li").length > 8) {
            log.get(0).removeChild(log.children("li")[0]);
        }
    }
    //
    // function getTime() {
    //     var now = new Date(),
    //         h = now.getHours(),
    //         m = now.getMinutes(),
    //         s = now.getSeconds();
    //     return (h + ":" + m + ":" + s);
    // }

    $(document).ready(function () {
        $.fn.zTree.init($("#treeObj"), setting, objNodes);
        $.fn.zTree.init($("#treeProperty"), setting, propertyNodes);
    });
    //-->
</script>
</body>
</html>
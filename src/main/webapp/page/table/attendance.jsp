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
    <link rel="stylesheet" href="<%=basePath%>control/bootstrap-table/bootstrap-table.min.css">
    <link rel="stylesheet" href="<%=basePath%>control/bootstrap3-editable/css/bootstrap-editable.css">
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
<script type="text/javascript" src="<%=basePath%>control/bootstrap-table/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=basePath%>control/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>control/bootstrap3-editable/js/bootstrap-editable.min.js"></script>
<script type="text/javascript" src="<%=basePath%>control/bootstrap-table/extensions/editable/bootstrap-table-editable.js"></script>
<script>

    /**
     * 表内编辑//https://www.cnblogs.com/songjl/p/7088356.html
     */

    $(function () {
        // 初始化表格
        var oTable = new tableInit();
        oTable.init();
    });


    var tableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.init = function () {
            $("#bomTable").bootstrapTable({
                url: '<%=basePath%>json/tableJson/bomData.json',
                height: $(window).height() - 100,
                toolbar: '#toolbar',
                showColumns: true,    //是否显示所有的列
                showRefresh: true,     //是否显示刷新按钮
                minimumCountColumns: 2,    //最少显示的列
                clickToSelect: false,
                showExport: true,
                exportDataType: 'all',
                exportTypes:[ 'csv', 'txt', 'sql', 'doc', 'excel', 'xlsx', 'pdf'],
                columns: [
                    {checkbox: true}
                    , {field: "id", title: "id", visible: false}
                    , {
                        field: 'items', title: '品目', width:200,  editable: {
                            type: 'text', title: '品目', validate: function (v) {
                                if (!v) return '用户名不能为空';
                            }
                        },
                    }
                    , {
                        field: 'ProcedureNumber', title: '工序编号',
                        editable: {
                            type: 'select',
                            title: '部门',
                            source: function () {
                                var result = [{value: "0", text: "qwe"}];
                                $.ajax({
                                    url: '<%=basePath%>json/data_table.json'
                                    ,async: false
                                    ,success: function (data) {
                                        var data = data.data;
                                        $.each(data, function (key, value) {
                                            result.push({value: value.id, text: value.auth_group_name})
                                        });
                                    }
                                });
                                return result;
                            }
                        }
                    }
                    , {field: 'ProcedureCode', title: '工序代码'}
                    , {field: 'resources', title: '资源',width:200}
                    , {field: 'resourcesPriority', title: '资源优先度',width:200}
                    , {field: 'frontSet', title: '前设置'}
                    , {field: 'produce', title: '制造'}
                    , {field: 'backSet', title: '后设置'}
                    , {field: 'continueMethod', title: '接续方法'}
                    , {field: 'necessaryResources', title: '必要资源量'}
                    , {field: 'moveTimeMin', title: '移动时间min'}
                    , {field: 'moveTimeMax', title: '移动时间max'}
                    , {field: 'wasteNumber', title: '废品数量'}
                    , {field: 'yield', title: '成品率'}
                    , {field: 'produceEffic', title: '制造效率'}
                    , {field: 'instructionType', title: '指令种类'}
                    , {field: 'instructionCode', title: '指令代码'}
                    , {field: 'instructionUseful', title: '指令有效条件'}
                    , {field: 'workingBatchMin', title: '工作批量min'}
                    , {field: 'workingBatchMax', title: '工作批量max'}
                    , {field: 'workingBatchUnit', title: '工作批量单位'}
                ],

                //编辑时触发
                onEditableSave: function (field, row, oldValue, $el) {
                    $("#bomTable").bootstrapTable("resetView");
                    $.ajax({
                        type: "",
                        url: "",
                        data: row,
                        dataType: 'JSON',
                        success: function (data, status) {
                            if (status == "success") {
                                alert('提交数据成功');
                            }
                        },
                        error: function () {
                        }
                    });
                },
//                rowStyle: function (row, index) {
//                    var style = "";
//                    style = {};
//                    return {classes: style}
//                },
            });
            $.fn.editable.defaults.mode = 'inline';
        };
        return oTableInit;
    };

    function insertRow() {
        var timeDiffer = new Date().getTime() - new Date("2018-01-01 00:00:00").getTime();
        var id = "bom"+timeDiffer;
        var data = {
            id: id,
            items: "",
            ProcedureNumber: "",
            ProcedureCode: "",
            resources: "",
            resourcesPriority: "",
            frontSet: "",
            produce: "",
            backSet: "",
            continueMethod: "",
            necessaryResources: "",
            moveTimeMin: "",
            moveTimeMax: "",
            wasteNumber:"",
            yield: "",
            produceEffic: "",
            instructionType: "",
            instructionCode: "",
            instructionUseful: "",
            workingBatchMin: "",
            workingBatchMax: "",
            workingBatchUnit: ""
        };
        $("#bomTable").bootstrapTable('insertRow', {
            index: $('#bomTable').bootstrapTable('getData').length,
            row: data
        });
    }

    function saveTable() {
        var tableData = $('#bomTable').bootstrapTable('getData');
        $.ajax({
            url: "<%=basePath%>"
            ,type: "post"
            ,data: {bomTable: tableData}
            ,success: function (result) {

            }
        })
    }

    function deleteRow() {
        var ids = $.map($('#bomTable').bootstrapTable('getSelections'),function(row){
            return row.id;
        });
        $('#bomTable').bootstrapTable('remove',{
            field : 'id',
            values : ids
        });
    }

</script>
<script type="text/javascript">
    layui.use(['table', 'laydate'], function () {
        var table = layui.table;

        table.render({
            elem: '#propertyTable',
            url: '<%=basePath%>json/instruction/ins_attendance.json',
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
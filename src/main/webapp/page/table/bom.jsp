<%--
  Created by IntelliJ IDEA.
  User: 黄益华
  Date: 2018/3/21
  Time: 11:08
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
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title></title>
    <link rel="stylesheet" href="<%=basePath%>control/layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/bom.css">
    <link rel="stylesheet" href="<%=basePath%>css/common.css">
    <link rel="stylesheet" href="<%=basePath%>control/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>control/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>control/bootstrap-table/bootstrap-table.min.css">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-4" style="padding-left: 0px">
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
        <div class="col-md-8" style="padding-left: 5px">
            <%--<div class="table-btn">--%>
                <%--<button class="layui-btn" id="tableAdd">新增</button>--%>
                <%--<button class="layui-btn layui-btn-danger" id="tableDelete">删除</button>--%>
                <%--<button class="layui-btn">保存</button>--%>
            <%--</div>--%>
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
                <button id="btn_edit" type="button" class="btn btn-default">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                </button>
                <button id="btn_delete" type="button" class="btn btn-default">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                </button>
            </div>
            <div class="table-background table-responsive">
                <table id="bomTable"  lay-filter="bomEdit"></table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade"  id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 1800px" >
        <div class="modal-content" >
            <form class="form-inline">
                <div >
                    <div class="form-group  ">
                        <label for="items" class="  control-label">品目</label>
                        <input type="text" class="form-control" id="items" placeholder="品目">
                    </div>
                    <div class="form-group  ">
                        <label for="ProcedureNumber" class="  control-label">工序编号</label>
                        <input type="text" class="form-control" id="ProcedureNumber" placeholder="工序编号">
                    </div>
                    <div class="form-group  ">
                        <label for="ProcedureCode" class="  control-label">工序代码</label>
                        <input type="text" class="form-control" id="ProcedureCode" placeholder="工序代码">
                    </div>
                    <div class="form-group  ">
                        <label for="resources" class="  control-label">资源</label>
                        <input type="text" class="form-control" id="resources" placeholder="资源">

                    </div>
                    <div class="form-group  ">
                        <label for="resourcesPriority" class="  control-label">资源优先度</label>
                        <input type="text" class="form-control" id="resourcesPriority" placeholder="资源优先度">

                    </div>
                </div>
                <div>
                    <div class="form-group  ">
                        <label for="frontSet" class="  control-label">前设置</label>
                        <input type="text" class="form-control" id="frontSet" placeholder="前设置">
                    </div>
                    <div class="form-group  ">
                        <label for="produce" class="  control-label">制造</label>
                        <input type="text" class="form-control" id="produce" placeholder="制造">
                    </div>
                    <div class="form-group  ">
                        <label for="backSet" class="  control-label">后设置</label>
                        <input type="text" class="form-control" id="backSet" placeholder="后设置">
                    </div>
                    <div class="form-group  ">
                        <label for="continueMethod" class="  control-label">接续方法</label>
                        <input type="text" class="form-control" id="continueMethod" placeholder="接续方法">
                    </div>
                    <div class="form-group  ">
                        <label for="necessaryResources" class="  control-label">必要资源量</label>
                        <input type="text" class="form-control" id="necessaryResources" placeholder="必要资源量">
                    </div>
                </div>
                <div>
                    <div class="form-group  ">
                        <label for="moveTimeMin" class="  control-label">移动时间min</label>
                        <input type="text" class="form-control" id="moveTimeMin" placeholder="移动时间min">
                    </div>
                    <div class="form-group  ">
                        <label for="moveTimeMax" class="  control-label">移动时间max</label>
                        <input type="text" class="form-control" id="moveTimeMax" placeholder="移动时间max">
                    </div>
                    <div class="form-group  ">
                        <label for="wasteNumber" class="  control-label">废品数量</label>
                        <input type="text" class="form-control" id="wasteNumber" placeholder="废品数量">
                    </div>
                    <div class="form-group  ">
                        <label for="yield" class="  control-label">成品率</label>
                        <input type="text" class="form-control" id="yield" placeholder="成品率">
                    </div>
                    <div class="form-group  ">
                        <label for="produceEffic" class="  control-label">制造效率</label>
                        <input type="text" class="form-control" id="produceEffic" placeholder="制造效率">
                    </div>
                </div>
                <div>
                    <div class="form-group  ">
                        <label for="instructionType" class="  control-label">指令种类</label>
                        <input type="text" class="form-control" id="instructionType" placeholder="指令种类">
                    </div>
                    <div class="form-group  ">
                        <label for="instructionCode" class="  control-label">指令代码</label>
                        <input type="text" class="form-control" id="instructionCode" placeholder="指令代码">
                    </div>
                    <div class="form-group  ">
                        <label for="instructionUseful" class="  control-label">指令有效条件</label>
                        <input type="text" class="form-control" id="instructionUseful" placeholder="指令有效条件">
                    </div>
                    <div class="form-group  ">
                        <label for="workingBatchMin" class="  control-label">工作批量min</label>
                        <input type="text" class="form-control" id="workingBatchMin" placeholder="工作批量min">
                    </div>
                    <div class="form-group  ">
                        <label for="workingBatchMax" class="  control-label">工作批量max</label>
                        <input type="text" class="form-control" id="workingBatchMax" placeholder="工作批量max">
                    </div>
                </div>
                <div>
                    <div class="form-group  ">
                        <label for="workingBatchUnit" class="  control-label">工作批量单位</label>
                        <input type="text" class="form-control" id="workingBatchUnit" placeholder="工作批量单位">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2  ">
                        <button  id="modelSave"  class="btn btn-default" onclick="getModelData()">保存</button>
                    </div>
                </div>
            </form>
        </div></div>
</div>
<script type="text/javascript" src="<%=basePath%>control/layui/layui.js"></script>
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>control/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>control/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bom.js"></script>
<script type="text/javascript" src="<%=basePath%>control/bootstrap-table/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=basePath%>control/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script>

    /**
     * 表格修改方式//https://blog.csdn.net/orangeTop/article/details/76532707
     */

    $(function() {
        // 初始化表格
        var oTable = new tableInit();
        oTable.init();
        //2.初始化Button的点击事件
        // var oButtonInit = new ButtonInit();
        // oButtonInit.Init();
    });

    var tableInit = function() {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.init = function () {
            $("#bomTable").bootstrapTable({
                url: '<%=basePath%>json/tableJson/bomData.json',
                height: $(window).height() - 100,
                toolbar: '#toolbar',
                showColumns : true,    //是否显示所有的列
                showRefresh : true,     //是否显示刷新按钮
                minimumCountColumns : 2,    //最少显示的列
                clickToSelect : true,
                columns: [
                    {field: 'items', title:'品目'}
                    ,{field: 'ProcedureNumber', title:'工序编号'}
                    ,{field: 'ProcedureCode', title:'工序代码'}
                    ,{field: 'resources', title:'资源'}
                    ,{field: 'resourcesPriority', title:'资源优先度'}
                    ,{field: 'frontSet', title:'前设置'}
                    ,{field: 'produce', title:'制造'}
                    ,{field: 'backSet', title:'后设置'}
                    ,{field: 'continueMethod', title:'接续方法'}
                    ,{field: 'necessaryResources', title:'必要资源量'}
                    ,{field: 'moveTimeMin', title:'移动时间min'}
                    ,{field: 'moveTimeMax', title:'移动时间max'}
                    ,{field: 'wasteNumber', title:'废品数量'}
                    ,{field: 'yield', title:'成品率'}
                    ,{field: 'produceEffic', title:'制造效率'}
                    ,{field: 'instructionType', title:'指令种类'}
                    ,{field: 'instructionCode', title:'指令代码'}
                    ,{field: 'instructionUseful', title:'指令有效条件'}
                    ,{field: 'workingBatchMin', title:'工作批量min'}
                    ,{field: 'workingBatchMax', title:'工作批量max'}
                    ,{field: 'workingBatchUnit', title:'工作批量单位'}
                ]
            });
        };
        // //得到查询的参数
        // oTableInit.queryParams = function(params) {
        //     var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
        //         limit : params.limit, //页面大小
        //         offset : params.offset, //页码
        //         departmentname : $("#txt_search_departmentname").val(),
        //         statu : $("#txt_search_statu").val()
        //     };
        //     return temp;
        // };
        return oTableInit;
    };

    var ButtonInit = function() {
        var oInit = new Object();
        var postdata = {};

        oInit.Init = function() {
            //初始化页面上面的按钮事件

        };

        return oInit;
    };

    function getModelData() {
        var a = $("#workingBatchUnit").val();
        console.log(a);
    }

</script>
<script type="text/javascript">
    var tableDate = [];
    $.ajax({
        url: '<%=basePath%>json/tableJson/bomData.json'
        , type: "get"
        , async: false
        , success: function (result) {
            tableDate = result;
        }
        , error: function (error) {
            layui.alert("数据出错：" + error);
        }
    });
    layui.use('table', function () {
        var table = layui.table;


        <%--//第一个实例--%>
        <%--table.render({--%>
        <%--elem: '#bomTable'--%>
        <%--, height: 'full-100'--%>
        <%--, cellMinWidth: 150--%>
        <%--, url: '<%=basePath%>json/tableJson/bomData.json' //数据接口--%>
        <%--, page: false //开启分页--%>
        <%--, size: 'sm'--%>
        <%--, cols: [[ //表头--%>
        <%--{field: 'id', title: 'ID', sort: true, edit: 'text', align: 'center', fixed: 'left'}--%>
        <%--, {field: 'username', title: '品目', edit: 'text', align: 'center'}--%>
        <%--, {field: 'sex', title: '工序选定器', edit: 'text', align: 'center', sort: true}--%>
        <%--, {field: 'city', title: '工序选定器有效条件', align: 'center', edit: 'text'}--%>
        <%--, {field: 'sign', title: '工序编号', align: 'center', edit: 'text'}--%>
        <%--, {field: 'experience', title: '工序代码', align: 'center', edit: 'text', sort: true}--%>
        <%--, {field: 'score', title: '评分', align: 'center', edit: 'text', sort: true}--%>
        <%--, {field: 'classify', title: '职业', align: 'center', edit: 'text'}--%>
        <%--, {field: 'wealth', title: '财富', align: 'center', edit: 'text', sort: true}--%>
        <%--]]--%>
        <%--});--%>

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
        var tables = $("#bomTable").next().find(".layui-table-box");
        tables.find("[data-field='classify']").css("display", "none");
        //监听单元格编辑
        table.on('edit(bomEdit)', function (obj) {
            var value = obj.value //得到修改后的值
                , data = obj.data //得到所在行所有键值
                , field = obj.field; //得到字段
            layer.msg('[ID: ' + data.id + '] ' + field + ' 字段更改为：' + value);
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
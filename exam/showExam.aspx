<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showExam.aspx.cs" Inherits="exam_showExam" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/export.js" type="text/javascript"></script>
    <script src="../js/ckeditor/ckeditor.js" type="text/javascript"></script>
    <script src="../js/ckfinder/ckfinder.js" type="text/javascript"></script>
    <style type="text/css">
        .title
        {
            color: Blue;
            font-size: x-large;
            text-align: left;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $('#dg').datagrid({
                title: "考试题目",
                url: "getExam.ashx",
                fit: true,
                fitColumns: true,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar",
                pagination: "true",
                pageSize: 30,
                singleSelect: false,
                sortName: 'E_CREATEDATE',               //排序字段
                sortOrder: 'desc',
                remoteSort: false,
                //multiSort:true,
                rownumbers: "true",

                onDblClickRow: function (index, row) {
                    $('#HDindex').val(index);
                    $("#dlgInput").dialog({
                        autoOpen: false,
                        resizable: false,
                        modal: true,
                        href: 'formExam.aspx?Flag=1&E_ID=' + row.E_ID//如果是修改，flag=1；如果是新建，flag=0
                    });
                    $('#dlgInput').dialog('open');
                }
            });

            $('#dlgInput').dialog('close');
            $('#dlgSta').dialog('close');
            if ($('#Standard').val() == "1")
                $('#btn_examSta').css('background-color', 'yellow');
        });
        function saveItem(flag) {
            var index = $('#HDindex').val();
            if (flag) {
                var row = $('#dg').datagrid('getRows')[index];
                var url = 'updateExam.ashx?ID=' + row.E_ID;
            } else
                var url = 'insertExam.ashx';
            $('#ff').form('submit', {
                url: url,
                success: function (data) {
                    data = eval('(' + data + ')');
                    if (flag != "1") {
                        $('#dg').datagrid('appendRow', { isNewRecord: true });
                    }
                    $('#dg').datagrid('updateRow', {
                        index: index,
                        row: data
                    });
                    $('#dg').datagrid('selectRow', index);
                    $('#dlgInput').dialog('close');
                }
            });

        }
        function destroyItem() {                   //刘靖  可批量删除 2014.11.13
            var rows = $('#dg').datagrid("getChecked");
            if (rows.length) {
                $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                    if (r) {
                        for (var i = rows.length - 1; i >= 0; --i) {
                            $.ajax({
                                type: "post",
                                url: "destroyExam.ashx",
                                data: "ID=" + rows[i].E_ID,
                                async: false,//同步
                                success: function (data) {
                                    if (data == "1") {
                                        var index = $('#dg').datagrid('getRowIndex', rows[i]);
                                        $('#dg').datagrid('deleteRow', index);
                                    }
                                    else
                                        alert("删除失败！");
                                }
                            });
                        }
                    }
                });
            }
        }
        function enter () { if (event.keyCode == '13') { FindData(); } }//在搜索中，右键-查询
        ///方法说明：查询 
        /// </summary>     
        function FindData() {
            $('#dg').datagrid('load', {
                S_TITLE: $('#S_TITLE').val(),
                S_TYPE: $("input[name='S_TYPE']:checked").val(),
                S_LEVEL: $('#S_LEVEL').combobox('getValue')
            });
        }
        //点击radio时，改变其样式，如果被选中就进行查询
        function changeStyle() {
            if ($("#SXradio").val() == 1) {//单选radio
                $("#SXradio").attr("value", "0");
                $("#SXradio").removeAttr("checked");
            } else {
                $("#SXradio").val("1");
                $("#SXradio").attr("checked", "checked");
                FindData();
            }
            if ($("#MXradio").val() == 1) {//多选radio
                $("#MXradio").attr("value", "0");
                $("#MXradio").removeAttr("checked");
            } else {
                $("#MXradio").val("1");
                $("#MXradio").attr("checked", "checked");
                FindData();
            }
            if ($("#PDradio").val() == 1) {//判断radio
                $("#PDradio").attr("value", "0");
                $("#PDradio").removeAttr("checked");
            } else {
                $("#PDradio").val("1");
                $("#PDradio").attr("checked", "checked");
                FindData();
            }
        }
        ///方法说明：制定考试标准
        /// </summary>     
        function SaveStandard() {
            $('#FStandard').form('submit', {
                success: function (data) {
                    if (data == "1") {
                        $.messager.confirm('提示', '考试规格指定成功！', function (r) {
                            if (r) {
                                //examStandard();//保存后不关闭dialog
                                $('#dlgSta').dialog('close'); //保存后关闭dialog
                                $('#btn_examSta').css('background-color', 'transparent');
                            }
                        });
                    }
                    else
                        $.messager.confirm('提示', '考试规格指定失败！');
                }
            });

        }
        function newItem() {
            var index = $('#dg').datagrid('getRows').length;
            $('#HDindex').val(index);
            $("#dlgInput").dialog({
                autoOpen: false,
                resizable: false,
                modal: true,
                href: 'formExam.aspx'
            });
            $('#dlgInput').dialog('open');
        }

        
    </script>
</head>
<body>
    <table id="dg">
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true">
                </th>
                <th field="E_TITLE" width="200" sortable="true">
                    题目
                </th>
                <th field="E_ANSWER" width="50" sortable="true">
                    答案
                </th>
                <th field="E_TYPE" width="30" sortable="true">
                    类型
                </th>
                <th field="E_LEVEL" width="20" sortable="true">
                    难度系数
                </th>
                <th field="E_CREATEDATE" width="50" sortable="true">
                    编辑日期
                </th>
            </tr>
        </thead>
    </table>
    <input type="hidden" id="userLevel" runat="server" />
    <input type="hidden" id="Standard" runat="server" />
    <div id="toolbar">
        <table cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td>
                    <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true"onclick="newItem()">新建</a>
                    <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
                    <span style="width: 30px; display: inline-block; text-align: right">类型:</span>
                    <input type="radio" id="SXradio" name="S_TYPE" value="0" onclick="changeStyle()" />单选
                    <input type="radio" id="MXradio" name="S_TYPE" value="0" onclick="changeStyle()" />多选
                    <input type="radio" id="PDradio" name="S_TYPE" value="0" onclick="changeStyle()" />判断
                    <span style="width: 35px; display: inline-block; text-align: right"><label for="S_TITLE">题目:</label></span><input class="easyui-textbox" id="S_TITLE" onkeydown="enter()"/>
                    <span style="width: 60px; display: inline-block; text-align: right"><label for="S_LEVEL">难度系数:</label></span>
                    <select name="S_LEVEL" id="S_LEVEL" class="easyui-combobox" listheight="20" panelheight="90">
                        <option value="">（空）</option>
                        <option value="难">难</option>
                        <option value="中等">中等</option>
                        <option value="简单">简单</option>
                    </select>
                    <span style="width: 60px; display: inline-block; text-align: right">
                    <a href="#" class="easyui-linkbutton" iconcls='icon-search' onclick="FindData()">查询</a>
                    </span>
                </td>
            </tr>
        </table>
    </div>
    <%--试题录入表单--%>
    <input type="hidden" value="" id="HDindex" runat="server" />
    <div id="dlgInput" class="easyui-dialog" style="width: 900px; height: 450px; padding: 10px 20px"
        data-options="closed:true,buttons:'#dlgInput-buttons'" title="编辑试题">
    </div>
    <div id="dlgInput-buttons">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveItem($('#HDflag').val())">
            保存</a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
                onclick="javascript:$('#dlgInput').dialog('close')">关闭</a>
    </div>
</body>
</html>

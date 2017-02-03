<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Z_setExam.aspx.cs" Inherits="exam_Z_setExam" %>

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
                onClickRow: onClickRow,
                onDblClickRow: function (index, row) {
                    $('#HDindex').val(index);
                    $("#dlgInput").dialog({
                        autoOpen: false,
                        resizable: false,
                        modal: true,
                        href: 'formExam.aspx?Flag=1&E_ID=' + row.E_ID
                    });
                    $('#dlgInput').dialog('open');
                },
                loader: function (param, success, error) {
                    $("#dg").datagrid('endEdit', editIndex);

                    //如果调用acceptChanges(),使用getChanges()则获取不到编辑和新增的数据。

                    //使用JSON序列化datarow对象，发送到后台。
                    var rows = $("#dg").datagrid('getChanges');

                    var rowstr = JSON.stringify(rows); //alert(rowstr);
                    $.post('Z_CreateExam.ashx', rowstr, function (data) {
                        
                    });

                    var that = $(this);
                    var opts = that.datagrid("options");
                    if (!opts.url) {
                        return false;
                    }
                    $.ajax({
                        type: opts.method,
                        url: opts.url,
                        data: param,
                        dataType: "json",
                        success: function (data) {
                            that.data().datagrid['cache'] = data;
                            success(bulidData(data));
                        },
                        error: function () {
                            //alert(data);
                            alert('用户已过期,请重新登录！');
                            window.top.location.href = getRootPath_web() + '/login.aspx';
                        }
                    });
                    function bulidData(data) {
                        var temp = $.extend({}, data);
                        var tempRows = [];
                        var start = 0;
                        var end = parseInt(param.rows);
                        var rows = data.rows;
                        for (var i = start; i < end; i++) {
                            if (rows[i]) {
                                tempRows.push(rows[i]);
                            } else {
                                break;
                            }
                        }
                        temp.rows = tempRows;
                        return temp;
                    }
                    function getRootPath_web() {
                        //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
                        var curWwwPath = window.document.location.href;
                        //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
                        var pathName = window.document.location.pathname;
                        var pos = curWwwPath.indexOf(pathName);
                        //获取主机地址，如： http://localhost:8083
                        var localhostPaht = curWwwPath.substring(0, pos);
                        //获取带"/"的项目名，如：/uimcardprj
                        //var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
                        return (localhostPaht);
                    }
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
                                async: false,
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
        function enter() { if (event.keyCode == '13') { FindData(); } }//输入查询条件时，右键-查询
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
        function examStandard() {
            $("#dlgSta").dialog({
                autoOpen: false,
                resizable: false,
                modal: true,
                href: 'ExamStandard.aspx'
            });
            $('#dlgSta').dialog('open');
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
                <th data-options="field:'status',width:60,align:'center',editor:{type:'checkbox',options:{on:'Y',off:''}}">
                    作为考试题 
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
                <td style="text-align: right">
                    <a href="#" id="btn_examSta" class="easyui-linkbutton" iconcls="icon-edit" plain="true"
                        onclick="examStandard()" style="">制定考试标准</a>
                </td>
                <td style="width:20px"></td>
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
    <%--制定考试标准--%>
    <div id="dlgSta" class="easyui-dialog" style="width: 700px; height: 350px; padding: 10px 20px"
        data-options="closed:true,buttons:'#dlgSta-buttons'" title="考试标准">
    </div>
    <div id="dlgSta-buttons">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="SaveStandard()">
            保存</a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
                onclick="javascript:$('#dlgSta').dialog('close')">关闭</a>
    </div>

    <script type="text/javascript">
        $(function () {
            //点击空白处，datagrid自动保存
            var gcn = gcn || {};
            gcn.listen = function (a, e, b) {
                if (a.addEventListener)
                { a.addEventListener(e, b, false) }
                else if (a.attachEvent) { a.attachEvent('on' + e, b) }
            };
            gcn.redirect = function () {
                if (endEditing()) {
                    $('#dg').datagrid('acceptChanges');
                }
            };
            gcn.listen(document, 'click', gcn.redirect);
        });
        var editIndex = undefined;
        function endEditing() {
            if (editIndex == undefined) { return true }
            if ($('#dg').datagrid('validateRow', editIndex)) {
                $('#dg').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickRow(index) {
            if (editIndex != index) {
                if (endEditing()) {
                    $('#dg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#dg').datagrid('selectRow', editIndex);
                }
            }
        }
       
	</script>
</body>
</html>
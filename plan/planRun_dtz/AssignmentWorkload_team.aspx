<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignmentWorkload_team.aspx.cs" Inherits="plan_planRun_dtz_AssignmentWorkload_team" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../../js/export.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#dg').datagrid({
                title: "工程量信息表",
                url: "AssignmentWorkload_getTeam.ashx?pid=" + $('#PID').val() + "&DM=" + encodeURI($('#DM').val()),
                fit: true,
                fitColumns: true,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar_aw",
                pagination: "true",
                pageSize: 30,
                singleSelect: false,
                sortName: 'PID',               //排序字段
                sortOrder: 'desc',
                remoteSort: false,
                //multiSort:true,
                rownumbers: "true",
                view: detailview,
                selectOnCheck: true,
                detailFormatter: function (index, row) {
                    return '<div class="ddv"></div>';
                },
                onExpandRow: function (index, row) {
                    var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                    var pid = $("#PID").val() != "" ? $("#PID").val() : row.PID;
                    ddv.panel({
                        border: false,
                        cache: true,
                        href: 'AssignmentWorkload_inputTeam.aspx?index=' + index + '&pid=' + pid,
                        onLoad: function () {
                            $('#dg').datagrid('fixDetailRowHeight', index);
                            $('#dg').datagrid('selectRow', index);
                            $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                        }
                    });
                    $('#dg').datagrid('fixDetailRowHeight', index);
                },
                loader: SCLoader
            });
            ////规定用户权限
            var userlevel = $('#userLevel').val();
            if (userlevel != "3") {
                $('#btn_new_aw').css('display', 'none');
                $('#btn_delete_aw').css('display', 'none');
                $('#dg').datagrid("hideColumn", "ck");
            }
        });

        function saveItem(index) {
            var row = $('#dg').datagrid('getRows')[index];
            var url = row.isNewRecord ? 'AssignmentWorkload_insert.ashx' : 'AssignmentWorkload_update.ashx?ID=' + row.ID;
            $('#dg').datagrid('getRowDetail', index).find('form').form('submit', {
                url: url,
                onSubmit: function () {
                    $("#save").removeAttr("onclick");
                    return $(this).form('validate');
                },
                success: function (data) {
                    data = eval('(' + data + ')');
                    data.isNewRecord = false;
                    $('#dg').datagrid('collapseRow', index);
                    $('#dg').datagrid('updateRow', {
                        index: index,
                        row: data
                    });
                }
            });
        }

        function cancelItem(index) {
            var row = $('#dg').datagrid('getRows')[index];
            if (row.isNewRecord) {
                $('#dg').datagrid('deleteRow', index);
            } else {
                $('#dg').datagrid('collapseRow', index);
            }
        }
        function destroyItem_aw() {                   //刘靖  可批量删除 2014.11.13
            var rows = $('#dg').datagrid("getChecked");
            if (rows.length) {
                $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                    if (r) {
                        for (var i = rows.length - 1; i >= 0; i--) {
                            $.post('AssignmentWorkload_destroy.ashx', { id: rows[i].ID });
                        }
                        $("#dg").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项  
                        $('#dg').datagrid('reload');
                    }
                });
            }
        }

        function newItem_aw() {
            $('#dg').datagrid('appendRow', { isNewRecord: true });
            var index = $('#dg').datagrid('getRows').length - 1;
            $('#dg').datagrid('expandRow', index);
            $('#dg').datagrid('selectRow', index);
        }

        ///<summary>
        ///方法说明:导出EXCEL功能
        ///2014.11.2  修复了传输数据时编码不一致导致参数出错的问题
        ///暂无创建时间查询方式
        ///</summary>  
        function Save_Excel_aw() {
            var username = $('#userName').val();
            var userlevel = $('#userLevel').val();
            var conditions = '';
            if ($('#PID').val() != "" && $('#DM').val() != "") {
                conditions += " and PID='" + $('#PID').val() + "' and Sender='" + $('#DM').val() + "'";
            }
            else if (userlevel == "1")//当前用户为小队
            {
                conditions += " and Receiver='" + username + "'";
            }
            if ($('#Receiver').val() != "")
                conditions += ' and RECEIVER = \'' + $('#Receiver').val() + '\'';
            window.location = "../../tools/toExcel.aspx?name=项目名称,项目编号,方案负责人,设计负责人,概算负责人,接收人,工作内容,当前时间节点,创建日期" +
            " &field=PNAME,PNUMBER,SOLUCHIEF,DESICHIEF,BUDGETCHIEF,RECEIVER,CONTENT,TIMERANGE,CREATEDATE&location=T_ASSIGNMENTWORKLOAD&condition=" + escape(conditions);
            return false;

        }

        ///方法说明：查询 
        /// </summary>     
        function FindData_aw() {
            $('#dg').datagrid('load', {
                Receiver: $('#Receiver').val()
            });
        }
</script>
</head>
<body>
 <table id="dg">
        <thead>    
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="PNAME"  width="100" sortable="true">项目名称</th>
				<th field="PNUMBER"   width="100" sortable="true">项目编号</th>
				<th field="SOLUCHIEF"  width="100" >方案负责人</th>
				<th field="DESICHIEF"  width="100" >设计负责人</th>
				<th field="BUDGETCHIEF"  width="150" >概算负责人</th>                
                <th field="RECEIVER"  width="150">接收人</th>
                <th field="MINECONTENT" width="150">矿工作量</th>
				<th field="CONTENT" width="150">小队工作内容</th>
				<th field="TIMERANGE"  width="150">当前时间节点</th>
                <th field="FEEDBACKINFORMATION"  width="150" data-options="styler:function(){return 'color:Orange;'}">小队反馈信息</th>
                <th field="CREATEDATE"  width="150">创建时间</th>
            </tr>
       </thead>
  </table>
  <input type="hidden" value="1" id="PID" runat="server"/>
  <input type="hidden" value="1" id="DM" runat="server"/>
  <input type="hidden" value="1" id="userName" runat="server"/> 
  <input type="hidden" value="1" id="userLevel" runat="server"/>
  
  <div id="toolbar_aw">
        <a href="#"  id="btn_new_aw" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem_aw()">分派工程量</a> 
        <a href="#" id="btn_delete_aw" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem_aw()">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true"  onclick="return Save_Excel_aw()" >导出</a>
        <span><label for="Receiver">接收人:</label></span><input class="easyui-textbox" id="Receiver" size="10" /> 
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_aw()"">查询</a></div>
</body>
</html>


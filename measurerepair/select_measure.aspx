<%@ Page Language="C#" AutoEventWireup="true" CodeFile="select_measure.aspx.cs" Inherits="Instrument_Select" %>
<!--发起测控系统维修时，选择待维修系统操作界面-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
</head>
<body>
    <input id="ids" runat="server" type="hidden"/>
    <table id="dg2" width=100%>
    <thead>  
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="CPUXH" width="80">CPU型号</th>
				<th field="GW" width="160">安装岗位</th>
				<th field="XTX" width="55">系统类别</th>								
                <th field="BZ" width="280">备注</th>
            </tr>
    </thead>
    </table>
    <div id="toolbar2">
        <a href="#" id="btn_ok" class="easyui-linkbutton" iconcls="icon-ok" plain="true" onclick="ok()">确认</a> 
        <a href="#" id="A1" class="easyui-linkbutton" iconcls="icon-back" plain="true" onclick="goback()">关闭</a>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#dg2').datagrid({
                title: "填写故障申请单-挑选待维修系统",
                url: "get_measure_information.ashx",
                fit: true,
                // fitColumns: true,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar2",
                rownumbers: "true",
                selectOnCheck: true,
                singleSelect: true
            });
        });
        function ok() {
            var rows = $('#dg2').datagrid("getChecked");
            $('#cc').layout('remove', 'north'); //刷新layout
            $('#cc').layout('add', {
                region: 'north',
                height: 190,
                split: true,
                href: "ensure_wxd.aspx?ID=" + rows[0].ID
            });
          //  $('#cc').layout('expand', 'north');
        }
        function goback() {
            $('#cc').layout('remove', 'north'); //刷新layout
        }
 </script>
</body>
</html>

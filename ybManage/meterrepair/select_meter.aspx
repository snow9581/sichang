<%@ Page Language="C#" AutoEventWireup="true" CodeFile="select_meter.aspx.cs" Inherits="Instrument_Select" %>
<!--发起仪表外送检定时，选择待检定仪表操作界面-->
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
    <table id="dg2" width='100%'>
    <thead>  
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="YBFL" width="55">仪表分类</th>
				<th field="YBMC" width="55">仪表名称</th>
				<th field="KM" width="55">矿名</th>				
				<th field="DM" width="55">队名</th>
				<th field="AZDD" width="90">安装地点</th>
                <th field="GGXH" width="55">规格型号</th>
                <th field="SCCJ" width="70">生产厂家</th>
                <th field="CCBH" width="80">出厂编号</th>
                <th field="CCRQ" width="55">出厂日期</th>
                <th field="ZQDDJ" width="70">准确度等级</th>
                <th field="LC" width="50">量程</th>
                <th field="JDZQ" width="55">检定周期</th>
                <th field="JDDW" width="55">检定单位</th>
                <th field="JDRQ" width="55">检定日期</th>
                <th field="JDJG" width="55">检定结果</th>
                <th field="GLZT" width="55">管理状态</th>
                <th field="SFWS" width="55">是否外送</th>
                <th field="BZ" width="28">备注</th>
            </tr>
    </thead>
    </table>
    <div id="toolbar2">
        <a href="#" id="btn_ok" class="easyui-linkbutton" iconcls="icon-ok" plain="true" onclick="ok()">确认</a> 
        <a href="#" id="A1" class="easyui-linkbutton" iconcls="icon-back" plain="true" onclick="goback()">关闭</a>
        <span>仪表名称:</span><input type="text" name="YBMC" id="YBMC" value="" class="easyui-validatebox" size="12"/>
        <span>规格型号:</span><input type="text" id="GGXH" name="GGXH" value="" class="easyui-validatebox" size="12"/> 
        <span>安装地点:</span><input type="text" name="AZDD" id="AZDD" value="" class="easyui-validatebox" size="12"/>
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#dg2').datagrid({
                title: "填写故障申请单-挑选待维修仪表",
                url: "get_meter_information.ashx",
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
        ///方法说明：查询 
        /// </summary>     
        function FindData() {
            $('#dg2').datagrid('load', {
                YBMC: $('#YBMC').val(),
                GGXH: $('#GGXH').val(),
                AZDD: $('#AZDD').val()            
            });
        }
 </script>
</body>
</html>

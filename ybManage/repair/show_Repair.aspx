<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_Repair.aspx.cs" Inherits="ybManage_repair_show_Repair" %>

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
    <div id="cc" class="easyui-layout" style="width:100%">	
    <div data-options="region:'center',split:true">
    <input id="userLevel" runat="server" type="hidden"/>
    <input id="xx" runat="server" type="hidden"/>
    <input id="dm" runat="server" type="hidden"/>
    <table id="dg" width=100%>
        <thead>
            <tr>
                <th data-options="field:'pic',width:50,align:'center',formatter:picformatter">状态</th>
                <th field="workitem" id="wi" hidden="true" width="50">操作</th>
				<th field="DW" width="100">单位</th>				
				<th field="WXLB" width="100">维修类别</th>
                <th field="AZWZ" width="100">安装位置</th>
                <th field="YQYBMC" width="150">仪表仪器名称</th>
				<th field="GGXH"width="100">规格型号</th>
                <th field="RQ"width="50">日期</th>
                <th field="GZXX"width="100">故障现象</th>
                <th field="SHR"width="100">审核人</th>
                <th field="SPR"width="100">审批人</th>
                <th field="WXR"width="100">维修人</th>
			</tr>
        </thead>
    </table>
    <div id="toolbar">
        <a href="#" id="btn_new" style=" visibility:hidden" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
    </div>
    </div>
    </div>
</body>
<script type="text/javascript">
       $.fn.datebox.defaults.formatter = function (date) {
           var y = date.getFullYear();
           var m = date.getMonth() + 1;
           var d = date.getDate();
           return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
       };
       $.fn.datebox.defaults.parser = function (s) {
           if (!s) return new Date();
           var ss = s.split('-');
           var y = parseInt(ss[0], 10);
           var m = parseInt(ss[1], 10);
           var d = parseInt(ss[2], 10);
           if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
               return new Date(y, m - 1, d);
           } else {
               return new Date();
           }
       };
       function picformatter(val, row) {
           if (row.workitem == '等待中') {
               pic = "../../images/run.png";
           }
           else if (row.workitem == '通过') {
               pic = "../../images/over.png";
           }
           else if (row.workitem == '不通过') {
               pic = "../../themes/icons/cancel.png";
           }
           else {
               pic = "../../images/work.png";
           }
           var pp = "<a onclick=\"working('" + row.workitem + "'," + row.ID + ")\"><img width='20px' height='20px' src='" + pic + "'/></a>";
           return pp;

       }
       function Record2() {
           $('#cc').layout('remove', 'north');
           $('#cc').layout('add', {
               region: 'north',
               height: 300,
               split: true,
               collapsed: true,
               href: "Record.aspx"
           });
           $('#cc').layout('expand', 'north');
       }
       function newItem() {
           $('#cc').layout('remove', 'north'); //刷新layout
           $('#cc').layout('add', {
               region: 'north',
               height: 200,
               split: true,
               collapsed: true,
               href: "input_Repair.aspx"
           });
           $('#cc').layout('expand', 'north');
       }
       function working(state, hh) {
           $('#cc').layout('remove', 'north'); //刷新layout
           $('#cc').layout('add', {
               region: 'north',
               height: 200,
               split: true,
               collapsed: true,
               href: "input_Repair.aspx?ID="+hh
           });
           $('#cc').layout('expand', 'north');
       }
       $(function () {
           $('#dg').datagrid({
               title: "仪表送修",
               url: "get_Repair.ashx",
               fit: true,
               fitColumns: true,
               collapsible: true,
               toolbar: "#toolbar",
               pagination: "true",
               pageSize: 30,
               singleSelect: false,
               remoteSort: false,
               //multiSort:true,
               rownumbers: "true"
           });
           var userlevel = $("#userLevel").val();
           if (userlevel == '1')
               $("#btn_new").css('visibility', 'visible');
           if ($('#xx').val() != '') {
               $('#cc').layout('add', {
                   region: 'north',
                   height: 300,
                   split: true,
                   collapsed: true,
                   href: "Record.aspx?ID=" + $('#xx').val()
               });
               $('#cc').layout('expand', 'north');
           }
       });
       $(document).ready(function () {
           var height1 = $(window).height() - 20;
           $("#cc").attr("style", "width:100%;height:" + height1 + "px");
           $("#cc").layout("resize", {
               width: "100%",
               height: height1 + "px"
           });
       });
       $(window).resize(function () {
           var height1 = $(window).height() - 30;
           $("#cc").attr("style", "width:100%;height:" + height1 + "px");
           $("#cc").layout("resize", {
               width: "100%",
               height: height1 + "px"
           });
       });
    </script>
</html>

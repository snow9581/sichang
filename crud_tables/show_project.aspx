<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_project.aspx.cs" Inherits="crud_tables_show_project" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css"/>
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/export.js" type="text/javascript"></script>   

 <script type="text/javascript">
     $(function () {
         $('#dg').datagrid({
             title: "浏览查询",
             url: "../crud_get/get_project.ashx?buf=0",
             fit: true,
             fitColumns: true,
             showFooters: true,
             collapsible: true,
             toolbar: "#toolbar",
             pagination: "true",
             pageSize: 30,
             singleSelect: false,
             sortName: '',               //排序字段
             sortOrder: 'asc',
             remoteSort: false,
             //multiSort:true,
             rownumbers: "true",
             view: detailview,
             detailFormatter: function (index, row) {
                 return '<div class="ddv"></div>';
             },
             onExpandRow: function (index, row) {
                 var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                 ddv.panel({
                     border: false,
                     cache: true,
                     href: '../crud_form/input_project.aspx',
                     onLoad: function () {
                         $('#dg').datagrid('fixDetailRowHeight', index);
                         $('#dg').datagrid('selectRow', index);
                         $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                     }
                 });
                 $('#dg').datagrid('fixDetailRowHeight', index);
             }
         });
     });
         ///方法说明：查询 
         /// </summary>     
         function FindData() {
             $('#dg').datagrid('load', {
                 PNAME: $('#PNAME').val(),
                 SOLUCHILF: $('#SOLUCHIEF').val(),
                 PNUMBER: $('#PNUMBER').val()
             });
         }
         ////使layout自动适应高度
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
</head>
<body>
<div id="cc" class="easyui-layout">	
<div data-options="region:'center',split:true">
  <table id="dg"  style="width:100%; height:100%">
        <thead>    
            <tr>
                <th field="PNAME" width ="150">项目名称</th>	
                <th field="PNUMBER" width ="150">项目编号</th>		
                <th field="SOLUCHIEF"width="100">方案负责人</th>
				<th field="DESICHIEF"  width="100">设计负责人</th>
             	<th field="PLANINVESMENT"  width="100">实际投资</th>
<%--		        <th field="PNumber"  width="150">方案批复文号</th>
                <th field="DESIAPPROVALARRIVALFILENUMBER"  width="150">设计批复文号</th>
				<th field="PLANARRIVALFILENUMBER"  width="150" >计划文号</th>--%>
			</tr>
        </thead>
    </table>
    <div id="toolbar">
        <span><label for="PNAME">项目名称:</label></span><input class="easyui-textbox" id="PNAME" value="" size="10" /> 
        <span><label for="SOLUCHIEF">项目方案负责人:</label></span><input class="easyui-textbox" id="SOLUCHIEF" value="" size="10" />
        <span><label for="PNUMBER">项目号:</label></span><input class="easyui-textbox" id="PNUMBER" value="" size="10" />  
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
     </div>
</div>
</div>

</body>
</html>
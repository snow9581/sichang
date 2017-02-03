<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Buffer.aspx.cs" Inherits="plan_planrun_bdtz_Buffer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../../js/export.js" type="text/javascript"></script>
 <script type="text/javascript">
     $(function () {
         $('#dg').datagrid({
             title: "废弃流程库-中长期规划",
             url: "./get_long_plan.ashx?buf=1",
             fit: true,
             fitColumns: false,
             showFooters: true,
             collapsible: true,
             toolbar: "#toolbar",
             pagination: "true",
             pageSize: 30,
             remoteSort: false,
             rownumbers: "true",
             singleSelect: false,
             loader: SCLoader 
         });
     });

     //比较延期或者提前，更改单元格背景颜色
     function color1(val, row) {
         if (row.SOLUCOMPDATE_P >= row.SOLUCOMPDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color2(val, row) {
         if (row.INSTCHECKDATE_P >= row.INSTCHECKDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color3(val, row) {
         if (row.FACTCHECKDATE_P >= row.FACTCHECKDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
   
     ///方法说明：查询 
     /// </summary>     
     function FindData() {
         $('#dg').datagrid('load', {
             PName: $('#PNAME').val(),
             SoluChief: $('#SOLUCHIEF').val()
         });
     }

     function destroyItem() {
         var rows = $('#dg').datagrid("getChecked");
         if (rows.length) {
             $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                 if (r) {
                     for (var i = rows.length - 1; i >= 0; i--) {
                         $.post('./RealDestroyPlanRun.ashx', { id: rows[i].PID });
                     }
                     $("#dg").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项  
                     $('#dg').datagrid('reload');
                     //parent.refresh();
                 }

             });
         }
     }

     function renewItem() {
         var rows = $('#dg').datagrid("getChecked");
         if (rows.length) {
             $.messager.confirm('提示', '你确定要还原已选记录吗?', function (r) {
                 if (r) {
                     for (var i = rows.length - 1; i >= 0; i--) {
                         $.post('./RenewPlanRun.ashx', { id: rows[i].PID });
                     }
                     $("#dg").datagrid('clearSelections');
                     $('#dg').datagrid('reload');
                     //parent.refresh();
                 }

             });
         }
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
<div id="cc" class="easyui-layout" style="width:100%">	
<div data-options="region:'center',split:true">
  <table id="dg">
        <thead>    
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="PNAME"  width="100" sortable="true">项目名称</th>
				<th field="SOLUCHIEF"   width="100" sortable="true">项目负责人</th>
				<th field="ESTIINVESTMENT"  width="100" sortable="true">估计预算</th>
				<th field="SOLUCOMPDATE_P"  width="150">方案计划完成时间</th>
				<th field="SOLUCOMPDATE_R" width="150" data-options="styler: color1">方案实际完成时间</th>
				<th field="INSTCHECKDATE_P"  width="150">所内计划审查时间</th>
				<th field="INSTCHECKDATE_R"  width="150" data-options="styler: color2">所内实际审查时间</th>				
				<th field="FACTCHECKDATE_P"  width="150">厂内计划审查时间</th>
				<th field="FACTCHECKDATE_R"  width="150" data-options="styler: color3">厂内实际审查时间</th>
				<th field="SOLUSUBMITDATE"  width="150">方案上报时间</th>
				<th field="SOLUCHECKDATE"  width="150">审查时间</th> 
				<th field="SOLUADVICEREPLYDATE" width="150">审查意见答复时间</th>
				<th field="SOLUAPPROVEDATE"  width="150">方案批复下达时间</th>							
			</tr>
        </thead>
    </table>

    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-back" plain="true" onclick="renewItem()">还原</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <span><label for="PNAME">项目名称:</label></span><input class="easyui-textbox" id="PNAME" value="" size=10 /> 
        <span id="sp"><label id="la" for="SOLUCHIEF">项目方案负责人:</label><input class="easyui-textbox" id="SOLUCHIEF" value="" size=10 /> </span>
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
     </div>
</div>
</div>
</body>
</html>
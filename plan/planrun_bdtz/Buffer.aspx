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
             title: "废弃流程库-委托设计",
             url: "./get_planRun_bdtz.ashx?buf=1",
             fit: true,
             fitColumns: false,
             showFooters: true,
             collapsible: true,
             toolbar: "#toolbar",
             pagination: "true",
             pageSize: 30,             //排序字段
             // sortOrder: 'asc',
             remoteSort: false,
             //multiSort:true,
             rownumbers: "true",
             loader: SCLoader 
         });
     });
     function color1(val, row) {
         if (row.SOLUCOMPDATE_P >= row.SOLUCOMPDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color2(val, row) {
         if (row.SOLUCHECKDATE_P >= row.SOLUCHECKDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color3(val, row) {
         if (row.INITIALDESISUBMITDATE_P >= row.INITIALDESISUBMITDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color4(val, row) {
         if (row.BLUEGRAPHDOCUMENT_P >= row.BLUEGRAPHDOCUMENT_R) {
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
             SoluChief: $('#SOLUCHIEF').val(),
             PNumber: $('#PNUMBER').val()
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
    </script>
</head>    
<body>
 
<div id="cc" class="easyui-layout" style="width:100%">	
<div data-options="region:'center',split:true">
  <table id="dg"  style="width:100%; height:100%">
        <thead>    
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="PNAME"  width="100" sortable="true">项目名称</th>
                <th field="PNUMBER"  width="100">项目号</th>
				<th field="SOLUCHIEF"  width="100" sortable="true">项目方案负责人</th>
				<th field="YCZLSUBMITDATE"  width="150">油藏资料提交时间</th>
				<th field="CYZLSUBMITDATE" width="150">采油资料提交时间</th>
                <th field="DMZLDELEGATEDATE" width="150">地面委托资料提交时间</th>
				<th field="SOLUCOMPDATE_P"  width="150">地面方案计划完成时间</th>
				<th field="SOLUCOMPDATE_R"  width="150" data-options="styler: color1">地面方案实际完成时间</th>					
				<th field="SOLUCHECKDATE_P"  width="150">方案审查计划时间</th>
				<th field="SOLUCHECKDATE_R"  width="150" data-options="styler: color2">方案审查实际时间</th> 
				<th field="DESISUBMITDATE" width="150">设计交底时间</th>
                <th field="INITIALDESISUBMITDATE_P"  width="150">初设计划上报时间</th>
				<th field="INITIALDESISUBMITDATE_R"  width="150" data-options="styler: color3">初设实际上报时间</th>					
				<th field="BLUEGRAPHDOCUMENT_P"  width="150">蓝图计划存档时间</th>
				<th field="BLUEGRAPHDOCUMENT_R"  width="150" data-options="styler: color4">蓝图实际存档时间</th> 		
			</tr>
        </thead>
    </table>
    <input type="hidden" value="1" id="userLevel" runat="server"/>
    <input type="hidden" value="1" id="Organization" runat="server"/>
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-back" plain="true" onclick="renewItem()">还原</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <span><label for="PNAME">项目名称:</label></span><input class="easyui-textbox" id="PNAME" value="" size=10 /> 
        <span><label for="SOLUCHIEF">项目方案负责人:</label></span><input class="easyui-textbox" id="SOLUCHIEF" value="" size=10 />
        <span><label for="PNUMBER">项目号:</label></span><input class="easyui-textbox" id="PNUMBER" value="" size=10 />  
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
     </div>
</div>
</div>

</body>
</html>
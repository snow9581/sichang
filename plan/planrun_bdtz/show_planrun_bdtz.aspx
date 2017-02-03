<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_planrun_bdtz.aspx.cs" Inherits="plan_planrun_bdtz_showpanrun_bdtz" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
             title: "委托设计",
             url: "./get_planRun_bdtz.ashx?buf=0",
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

         $("#dg").datagrid('hideColumn', "BLUEGRAPHFIL"); //隐藏蓝图
         $("#dg").datagrid('hideColumn', "INITDESIGNFILE"); //隐藏初设文档

         //规定用户权限
         var userlevel = $('#userLevel').val();
         var organization = $('#Organization').val();
         if (!(userlevel == "2" && organization == "规划室")) {
             $('#btn_new').css('display', 'none');
         }
         if (userlevel == "7" && organization == "设计室") { //设计室副主任
             $("#dg").datagrid('showColumn', "ck");
         }
         else {
             $("#dg").datagrid('hideColumn', "ck");
             $("#btn_delete").css('display', 'none');
         }
     });

     function destroyItem() {
         var rows = $('#dg').datagrid("getChecked");
         if (rows.length) {
             $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                 if (r) {
                     for (var i = rows.length - 1; i >= 0; i--) {
                         $.post('./DestroyPlanRun.ashx', { id: rows[i].PID });
                     }
                     $("#dg").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项  
                     $('#dg').datagrid('reload');
                     //parent.refresh();
                 }
             });
         }
     }

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
     
     function color4(val, row) {
         if (row.BLUEGRAPHDOCUMENT_P >= row.BLUEGRAPHDOCUMENT_R)
             return '<a style="color:green" href="../../datasubmit/downloadPic.aspx?picName=' + row.BLUEGRAPHFIL + '&package=archives" target="_blank">' + row.BLUEGRAPHDOCUMENT_R + '</a>  '
         else
             return '<a style="color:red" href="../../datasubmit/downloadPic.aspx?picName=' + row.BLUEGRAPHFIL + '&package=archives" target="_blank">' + row.BLUEGRAPHDOCUMENT_R + '</a>  '
     }
     function color3(val, row) {
         if (row.INITIALDESISUBMITDATE_P >= row.INITIALDESISUBMITDATE_R)
             return '<a style="color:green" href="../../datasubmit/downloadPic.aspx?picName=' + row.INITDESIGNFILE + '&package=archives" target="_blank">' + row.INITIALDESISUBMITDATE_R + '</a>  '
         else
             return '<a style="color:red" href="../../datasubmit/downloadPic.aspx?picName=' + row.INITDESIGNFILE + '&package=archives" target="_blank">' + row.INITIALDESISUBMITDATE_R + '</a>  '
     }
     ///setValue是EasyUI固定的写法。
     function picformatter(val, row) {
         if (row.workitem == '等待中') {
             pic = "../../images/run.png";
         } else if (row.workitem == '结束') {
             pic = "../../images/over.png";
         
         } else {
             pic = "../../images/work.png";
         }
         var pp = "<a onclick=\"working('" + row.workitem + "','" + row.workurl + "?id=" + row.PID + "')\"><img width='20px' height='20px' src='" + pic + "'/></a>";

         return pp;
     }

     function myformatter(date) {
         var y = date.getFullYear();
         var m = date.getMonth() + 1;
         var d = date.getDate();
         return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
     }
     function myparser(s) {
         if (!s)
             return new Date();
         var ss = (s.split('-'));
         var y = parseInt(ss[0], 10);
         var m = parseInt(ss[1], 10);
         var d = parseInt(ss[2], 10);
         if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
             return new Date(y, m - 1, d);
         } else {
             return new Date();
         }
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
     //方法说明：发起计划项目
     function newItem() {
         $('#cc').layout('remove', 'north');
         $('#cc').layout('add', {
             region: 'north',
             height: 237,
             split: true,
             collapsed: true,
             href: 'init_planRun_bdtz.aspx'
         });
         $('#cc').layout('expand', 'north');
     }
     function working(state, hh) {
         if (state != '等待中' && state !== '结束') {
             $('#cc').layout('remove', 'north');
             $('#cc').layout('add', {
                 region: 'north',
                 height: 237,
                 split: true,
                 collapsed: true,
                 href: hh
             });
             $('#cc').layout('expand', 'north');
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
  <table id="dg"  style="width:100%; height:100%">
        <thead>    
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'pic',width:50,align:'center',formatter:picformatter">状态</th>
                <th field="Workitem" id="wi" hidden="true" width="50">操作</th>
                <th field="Workurl" hidden="true" width="50">url</th>
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
				<th field="INITIALDESISUBMITDATE_R"  width="150" data-options="formatter: color3">初设实际上报时间</th>	
                <th field="INITDESIGNFILE" width="150">初设文件</th> 				
				<th field="BLUEGRAPHDOCUMENT_P"  width="150">蓝图计划存档时间</th>
				<th field="BLUEGRAPHDOCUMENT_R"  width="150" data-options="formatter: color4">蓝图实际存档时间</th>
                <th field="BLUEGRAPHFIL" width="150">蓝图</th> 		
                <th field="BLUEGRAPHARRIVALDATE"  width="150">蓝图下发时间</th> 
                <th field="REMARK" width="150">备注</th> 		
			</tr>
        </thead>
    </table>
    <input type="hidden" value="1" id="userLevel" runat="server"/>
    <input type="hidden" value="1" id="Organization" runat="server"/>
    <div id="toolbar">
        <a href="#"  id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">启动新项目</a>  
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

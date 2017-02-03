<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_long_plan.aspx.cs" Inherits="long_plan_show_long_plan" %>

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
             title: "中长期项目运行表",
             url: "./get_long_plan.ashx?buf=0",
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
         //规定用户权限
         var organization = $('#DM').val();
         var userlevel = $('#userLevel').val();
         if (userlevel != "2") {
             $('#btn_new').css('display', 'none');
         }
         if (userlevel == "6") {
             $('#sp').css('display', 'none');
             $('#la').css('display', 'none');
             $('#SOLUCHIEF').css('display', 'none');
         }

         if (userlevel == "7" && organization == "设计室") { //设计室副主任
             $("#dg").datagrid('showColumn', "ck");
         }
         else {
             $("#dg").datagrid('hideColumn', "ck");
             $("#btn_delete").css('display', 'none');
         }
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
     //根据状态添加不同的图片标识
         function picformatter(val,row) { 
            if(row.workitem=='等待中')
            {
                pic="../../images/run.png";
            }
            else if(row.workitem=='结束'){
                pic="../../images/over.png";
            }
            else{
                pic="../../images/work.png";
            }       
            var pp= "<a onclick=\"working('"+row.workitem+"','"+row.workurl+"?id="+row.PID+"')\"><img width='20px' height='20px' src='"+pic+"'/></a>";
            return pp;

        }
        
        function myformatter(date) {
          var y = date.getFullYear();
          var m = date.getMonth() + 1;
          var d = date.getDate();
          return y + '-' + (m < 10 ? ('0' + m) : m) + '-'+ (d < 10 ? ('0' + d) : d);
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
       function FindData(){ 
            $('#dg').datagrid('load',{
             PName: $('#PNAME').val(),
             SoluChief: $('#SOLUCHIEF').val()
           });
        }
//方法说明：发起计划项目
        function newItem() {
            $('#cc').layout('remove', 'north');
            $('#cc').layout('add',{
            region: 'north',
            height:237,
            split: true,
            collapsed:true,
            href:'init_long_plan.aspx'
            });
            $('#cc').layout('expand','north');
        }
        //展开编辑网页
        function working(state, hh) {

            if (state != '等待中' && hh[0]!='?') {
                $('#cc').layout('remove', 'north');//刷新layout
                $('#cc').layout('add',{
                region: 'north',
                height:300,
                split: true,
                collapsed:true,
                href:hh
                });
                $('#cc').layout('expand','north');
            }

        }
        function destroyItem() {
            var rows = $('#dg').datagrid("getChecked");
            if (rows.length) {
                $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                    if (r) {
                        for (var i = rows.length - 1; i >= 0; i--)
                            $.post('./DestroyPlanRun.ashx', { id: rows[i].PID });
                        $("#dg").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项
                        $('#dg').datagrid('reload');
                    }
                });
            }
        }
//        //导出excel
        function Save_Excel() {
            var conditions = ' and BUFFER=0';
            $("#toolbar >input:not(#KSRQ,#JSRQ)").each(function () {
                if ($(this).val() !== '')
                    conditions += (' and ' + $(this).attr("id") + ' like \'%' + $(this).val() + '%\'');
            });
//            if ($("#userLevel").val() == "6")
//                conditions += " and SOLUCHIEF='" + $("#userName").val() + "'";
//            if ($("#DM").val() == "矿区室")
//                conditions += " and FLAGS=2";
//            else
//                conditions += "and FLAGS=1";
            window.location = "../../tools/toExcel.aspx?name=项目名称,项目负责人,估计预算,方案计划完成时间 ,方案实际完成时间,所内计划完成时间,所内实际完成时间,厂内计划完成时间,厂内实际完成时间,方案上报时间,审查时间,审查意见答复时间,方案批复下达时间" +
            "&field=PNAME,SOLUCHIEF,ESTIINVESTMENT,SOLUCOMPDATE_P,SOLUCOMPDATE_R,INSTCHECKDATE_P,INSTCHECKDATE_R,FACTCHECKDATE_P,FACTCHECKDATE_R ,SOLUSUBMITDATE,SOLUCHECKDATE,SOLUADVICEREPLYDATE,SOLUAPPROVEDATE&location=T_PLANRUN_ZCQ&condition=" + escape(conditions);
            return false;
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
                <th data-options="field:'pic',width:50,align:'center',formatter:picformatter">状态</th>
                <th field="workitem" id="wi" hidden="true" width="50">操作</th>
                <th field="workurl" hidden="true" width="50">url</th>
                <th field="PNAME"  width="100" sortable="true">项目名称</th>
				<th field="SOLUCHIEF" width="100" sortable="true">项目负责人</th>
				<th field="ESTIINVESTMENT"  width="100" sortable="true">估计预算</th>
				<th field="SOLUCOMPDATE_P"  width="150">方案计划完成时间</th>
				<th field="SOLUCOMPDATE_R" width="150" data-options="styler: color1">方案实际完成时间</th>
				<th field="INSTCHECKDATE_P"  width="150">所内计划审查时间</th>
				<th field="INSTCHECKDATE_R"  width="150" data-options="styler: color2">所内实际审查时间</th>				
				<th field="FACTCHECKDATE_P"  width="150">厂内计划审查时间</th>
				<th field="FACTCHECKDATE_R" width="150" data-options="styler: color3">厂内实际审查时间</th>
				<th field="SOLUSUBMITDATE"  width="150">方案上报时间</th>
				<th field="SOLUCHECKDATE"  width="150">审查时间</th> 
				<th field="SOLUADVICEREPLYDATE" width="150">审查意见答复时间</th>
				<th field="SOLUAPPROVEDATE"  width="150">方案批复下达时间</th>	
               <%-- <th field="BZ"  width="150">备注</th>	--%>
			</tr>
        </thead>
    </table>
    <input type="hidden" value="1" id="userLevel" runat="server"/>
    <input type="hidden" value="1" id="DM" runat="server"/>
    <input type="hidden" value="" id="userName" runat="server"/>
    <div id="toolbar">
        <a href="#"  id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">启动新项目</a>
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true"  onclick="return Save_Excel()" >导出</a>  
        <span><label for="PNAME">项目名称:</label></span><input class="easyui-textbox" id="PNAME" value="" size=10 /> 
        <span id="sp"><label id="la" for="SOLUCHIEF">项目方案负责人:</label><input class="easyui-textbox" id="SOLUCHIEF" value="" size=10 /> </span>
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
     </div>
</div>
</div>
</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Buffer.aspx.cs" Inherits="plan_planRun_dtz_Buffer" %>

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
             title: "废弃流程库-自主设计",
             url: "./get_planRun_dtz.ashx?buf=1",
             fit: true,
             fitColumns: false,
             showFooters: true,
             collapsible: true,
             toolbar: "#toolbar",
             pagination: "true",
             pageSize: 30,
             remoteSort: false,
             //multiSort:true,
             rownumbers: "true",

             rowStyler: function (index, row) {
                 if (row.PLANFLAG == 1) {
                     return 'background-color:#6293BB;color:#fff;'; // return inline style
                     // the function can return predefined css class and inline style
                     // return {class:'r1', style:{'color:#fff'}};	
                 }
             },
             loader: SCLoader 
         });
         $("#dg").datagrid('hideColumn', "SOLUAPPROVEFILE"); //隐藏方案批复文件
         $("#dg").datagrid('hideColumn', "DESIAPPRFILE"); //隐藏设计批复文档
         $("#dg").datagrid('hideColumn', "PLANARRIVALFILE"); //隐藏计划下达文件
         $("#dg").datagrid('hideColumn', "FINALBUDGETFILE"); //隐藏最终概算文档
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
     //     function color3(val, row) {
     //        if (row.FACTCHECKDATE_P >= row.FACTCHECKDATE_R)
     //            return '<a style="color:green" href="../../datasubmit/downloadPic.aspx?picName=' + row.FINALSOLUTIONFILE + '&package=ftpimage" target="_blank">' + row.FACTCHECKDATE_R + '</a>  '
     //        else
     //            return '<a style="color:red" href="../../datasubmit/downloadPic.aspx?picName=' + row.FINALSOLUTIONFILE + '&package=ftpimage" target="_blank">' + row.FACTCHECKDATE_R + '</a>  '
     //     }
     function color4(val, row) {
         if (row.MAJORDELEGATEDATE_P >= row.MAJORDELEGATEDATE_R)
             return 'color:green;';
        else
            return 'color:red;';
     }
     function color5(val, row) {
         if (row.WORKLOADSUBMITDATE_P >= row.WORKLOADSUBMITDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color6(val, row) {
         if (row.BUDGETCOMPDATE_P >= row.BUDGETCOMPDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color7(val, row) {
         if (row.INITIALDESISUBMITDATE_P >= row.INITIALDESISUBMITDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color8(val, row) {
         if (row.BUDGETADJUSTDATE_P >= row.BUDGETADJUSTDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color9(val, row) {
         if (row.WHITEGRAPHCHECKDATE_P >= row.WHITEGRAPHCHECKDATE_R) {
             return 'color:green;';
         }
         else
             return 'color:red;';
     }
     function color10(val, row) {
         if (row.BLUEGRAPHDOCUMENT_P >= row.BLUEGRAPHDOCUMENT_R)
             return 'color:green;';
         else
             return 'color:red;';
     }
     function color11(val, row) {
         if (row.SOLUAPPROVEFILE != '#' && row.SOLUAPPROVEFILE != '' && row.SOLUAPPROVEFILE != undefined)
             return '<a style="color:black" href="../../datasubmit/downloadPic.aspx?picName=' + row.SOLUAPPROVEFILE + '&package=ftp_planfile" target="_blank">' + row.SOLUAPPROVEDATE + '</a>  '
         else
             return row.SOLUAPPROVEDATE
     }
     function color12(val, row) {
         if (row.PLANARRIVALFILE != '#' && row.PLANARRIVALFILE != '' && row.PLANARRIVALFILE != undefined)
             return '<a style="color:black" href="../../datasubmit/downloadPic.aspx?picName=' + row.PLANARRIVALFILE + '&package=ftp_planfile" target="_blank">' + row.PLANARRIVALDATE + '</a>  '
         else
             return row.PLANARRIVALDATE
     }
     function color13(val, row) {
         if (row.DESIAPPRFILE != '#' && row.DESIAPPRFILE != '' && row.DESIAPPRFILE != undefined)
             return '<a style="color:black" href="../../datasubmit/downloadPic.aspx?picName=' + row.DESIAPPRFILE + '&package=ftp_planfile" target="_blank">' + row.DESIAPPROVALARRIVALDATE + '</a>  '
         else
             return row.DESIAPPROVALARRIVALDATE
     }
     function color14(val, row) {
         if (row.BUDGETADJUSTDATE_P >= row.BUDGETADJUSTDATE_R)
             return '<a style="color:green" href="../../datasubmit/downloadPic.aspx?picName=' + row.FINALBUDGETFILE + '&package=archives" target="_blank">' + row.BUDGETADJUSTDATE_R + '</a>  '
         else
             return '<a style="color:red" href="../../datasubmit/downloadPic.aspx?picName=' + row.FINALBUDGETFILE + '&package=archives" target="_blank">' + row.BUDGETADJUSTDATE_R + '</a>  '
     }
     ///方法说明：查询 
     /// </summary>     
     function FindData_dg() {
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
    
    </script>
</head>
<body>

    <form id="form1" runat="server">

<div id="cc" class="easyui-layout">	
<div data-options="region:'center',split:true">
  <table id="dg"  style="width:100%; height:100%">
        <thead>    
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="PNAME"  width="100" sortable="true">项目名称</th>
				<th field="PSOURCE"   width="100" sortable="true">项目来源</th>
				<th field="SOLUCHIEF"  width="100" sortable="true">项目方案负责人</th>
				<th field="ESTIINVESTMENT"  width="100" sortable="true">估算投资</th>
				<th field="SOLUCOMPDATE_P"  width="150" >方案计划完成时间</th>
				<th field="SOLUCOMPDATE_R" width="150" data-options="styler: color1">方案实际完成时间</th>
				<th field="INSTCHECKDATE_P"  width="150">所内计划审查时间</th>
				<th field="INSTCHECKDATE_R"  width="150" data-options="styler: color2">所内实际审查时间</th>				
				<th field="FACTCHECKDATE_P"  width="150">厂内计划审查时间</th>
				<th field="FACTCHECKDATE_R"  width="150" data-options="styler:color3">厂内实际审查时间</th>
				<th field="SOLUSUBMITDATE" class="ii" width="100">方案上报时间</th>
				<th field="SOLUCHECKDATE"  width="100">审查时间</th> 
				<th field="SOLUADVICEREPLYDATE" width="150">审查意见答复时间</th>
				<th field="SOLUAPPROVEDATE"  width="150" data-options="formatter:color11">方案批复下达时间</th>
                <th field="SOLUAPPROVEFILE" width="150">方案批复</th>
				<th field="PNUMBER"  width="100">项目号</th>				
				<th field="PLANINVESMENT"  width="100">计划投资</th>
				<th field="DESICHIEF"  width="100">项目设计负责人</th>
				<th field="MAJORPROOFREADER" width="150">主专业校对及室负责人</th>
				<th field="BUDGETCHIEF"  width="100">概算汇总人</th>
				<th field="MAJORDELEGATEDATE_P" width="150">一次委托资料计划时间</th>
				<th field="MAJORDELEGATEDATE_R"  width="150" data-options="styler: color4">一次委托资料实际时间</th>
				<th field="WORKLOADSUBMITDATE_P"  width="150">工程量计划提交时间</th>				
				<th field="WORKLOADSUBMITDATE_R"  width="150" data-options="styler: color5">工程量实际提交时间</th>
				<th field="BUDGETCOMPDATE_P"  width="150">概算计划完成时间</th>
				<th field="BUDGETCOMPDATE_R" width="150" data-options="styler: color6">概算实际完成时间</th>
				<th field="INITIALDESISUBMITDATE_P"  width="150">初设计划上报时间</th>
				<th field="INITIALDESISUBMITDATE_R" width="150" data-options="styler: color7">初设实际上报时间</th>
				<th field="BUDGETADJUSTDATE_P"  width="150">概算计划调整时间</th>
				<th field="BUDGETADJUSTDATE_R" width="150" data-options="formatter: color14">概算实际调整时间</th>
                <th field="FINALBUDGETFILE" width="150">最终概算文档</th>
				<th field="PLANARRIVALFILENUMBER"  width="150">计划下达文件号</th>
				<th field="PLANARRIVALDATE"  width="150" data-options="formatter:color12">计划下达文件批准日期</th>
                <th field="PLANARRIVALFILE" width="150">计划下达文件</th>
				<th field="DESIAPPROVALARRIVALFILENUMBER" width="150">设计批复下达文件号</th>
				<th field="DESIAPPROVALARRIVALDATE"  width="150" data-options="formatter:color13">设计批复文件批准日期</th>
                <th field="DESIAPPRFILE" width="150">设计批复文档</th>
				<th field="WHITEGRAPHCHECKDATE_P"  width="150">施工白图计划校审时间</th>				
				<th field="WHITEGRAPHCHECKDATE_R"  width="150" data-options="styler: color9">施工白图实际校审时间</th>
				<th field="BLUEGRAPHDOCUMENT_P"  width="150">蓝图计划存档时间</th>
				<th field="BLUEGRAPHDOCUMENT_R" width="150" data-options="styler: color10">蓝图实际存档时间</th>
				<th field="REMARK"  width="150">备注</th>
                <th field="INITDATE"  width="150">发起日期</th>
			
			</tr>
        </thead>
    </table>
    <input type="hidden" value="1" id="userLevel" runat="server"/>
    <input type="hidden" value="1" id="Organization" runat="server"/>
    <input type="hidden" value="1" id="userName" runat="server"/>
    <div id="toolbar">  
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-back" plain="true" onclick="renewItem()">还原</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a> 
        <span><label for="PNAME">项目名称:</label></span><input class="easyui-textbox" id="PNAME" value="" size=10 /> 
        <span><label for="SOLUCHIEF">项目方案负责人:</label></span><input class="easyui-textbox" id="SOLUCHIEF" value="" size=10 /> 
        <span><label for="PNUMBER">项目号:</label></span><input class="easyui-textbox" id="PNUMBER" value="" size=10 />
         <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_dg()"">查询</a>
     </div>
</div>
</div>
    </form>
</body>
</html>
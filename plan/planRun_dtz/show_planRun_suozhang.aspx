<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_planRun_suozhang.aspx.cs" Inherits="plan_planRun_dtz_show_planRun_suozhang" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--规划所所长查看进度计划--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
   <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css"/>
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../../js/export.js" type="text/javascript"></script>
    <style type="text/css">   
    th{  
    border-right:1px dotted transparent;  
    }  
    </style>
 <script type="text/javascript">
     $(function () {
         $('#dg').datagrid({
             title: "进度计划",
             url: "get_planRun_suozhang.ashx?buf=0",
             fit: true,
             fitColumns: false,
             showFooters: true,
             collapsible: true,
             toolbar: "#toolbar",
             pagination: "true",
             pageSize: 20,
             nowrap: false,
             remoteSort: false,
             //multiSort:true,
             rownumbers: "true",

             rowStyler: function (index, row) {
                 if (row.PLANFLAG == 1) {
                     return 'background-color:Yellow';
                 }
             },
             loader: SCLoader
         });
         
         $("#dg").datagrid('hideColumn', "DESIAPPRFILE"); //隐藏设计批复文档
         $("#dg").datagrid('hideColumn', "PLANARRIVALFILE"); //隐藏计划下达文件

     });

     //跳转到相应的电子档案，补充信息
     function addInfm(title, pname, pnumber, ptype, path) {
         parent.addTab("补充信息->" + title, "crud_tables/archives/" + path + "?pname=" + encodeURIComponent(pname) + "&pnumber=" + encodeURIComponent(pnumber) + "&ptype=" + encodeURIComponent(ptype));
     }
     
     ///方法说明：查询 
     /// </summary>     
     function FindData_dg() {
         var stage = "";
         var radioStage = document.getElementsByName("stage");
         for (var i = 0; i < radioStage.length; i++) {
             if (radioStage[i].checked) {
                 stage = radioStage[i].value;
                 break;
             }
         }
         $('#dg').datagrid('load', {
             PYEAR: $('#PYEAR').combobox('getValue'),
             PSOURCE: $('#PSOURCE').combobox('getValue'),
             PNumber: $('#PNUMBER').val(),
             stage: stage
         });
     }
   
     function picformatter(val, row) {
         //alert(row.workitem);
         if (row.workitem == '等待中') {
             pic = "../../images/run.png";
         } else if (row.workitem == '结束') {
             pic = "../../images/over.png";
         } else if (row.workitem == '退回方案') {
             pic = "../../images/back.png";
         } else if (row.workitem == '重新审查方案') {
             pic = "../../images/Return.png";
         } else {
             pic = "../../images/work.png";
         }
         var pp = "<a><img width='20px' height='20px' src='" + pic + "'/></a>";
         return pp;
     }
    
     ///<summary>
     ///方法说明:导出EXCEL功能
     ///2014.11.2  修复了传输数据时编码不一致导致参数出错的问题
     ///暂无创建时间查询方式
     ///</summary>
     function Save_Excel() {
         var username = $('#userName').val();
         var userlevel = $('#userLevel').val();
         var conditions = ' and BUFFER=0';
         var pyear = $('#PYEAR').combobox('getValue');
         if (pyear != ''&&pyear!=null) {
             if (pyear != "其他")
                 conditions += " and PNUMBER like 'S(" + pyear + ")%'";
             else
                 conditions += " and (PNUMBER not like 'S%' or PNUMBER is null)";
         }
         var psource = $('#PSOURCE').combobox('getValue');
         if (psource != ''&& psource!=null) {
             if (psource != "其他")
                 conditions += " and PSOURCE like '%" + psource + "%'";
             else
                 conditions += " and (PSOURCE not like '%房屋维修%' and PSOURCE not like '%安全隐患%' and PSOURCE not like '%环保工程%' and PSOURCE not like '%结余资金%' and PSOURCE not like '%老区改造%' and PSOURCE not like '%生产维修%' or PSOURCE is null)";
         }
         if ($('#PNUMBER').val() != '')
             conditions += " and PNUMBER like '%" + $('#PNUMBER').val() + "%'";
         var stage = "";
         var radioStage = document.getElementsByName("stage");
         for (var i = 0; i < radioStage.length; i++) {
             if (radioStage[i].checked) {
                 stage = radioStage[i].value;
                 break;
             }
         }
         window.location = "../../tools/toExcel.aspx?name=项目名称,项目号,估算投资,计划下达文件号,计划下达文件批准日期,计划投资,设计批复下达文件号,设计批复文件批准日期,项目方案负责人,项目设计负责人,审查时间,工程量计划提交时间,工程量实际提交时间,初设计划上报时间,初设实际上报时间,蓝图计划存档时间,蓝图实际存档时间,蓝图下发时间,当前进度,备注,发起时间" +
            "&field=PNAME,PNUMBER,ESTIINVESTMENT,PLANARRIVALFILENUMBER,PLANARRIVALDATE,PLANINVESMENT,DESIAPPROVALARRIVALFILENUMBER,DESIAPPROVALARRIVALDATE,SOLUCHIEF,DESICHIEF,SOLUCHECKDATE,WORKLOADSUBMITDATE_P,WORKLOADSUBMITDATE_R,INITIALDESISUBMITDATE_P,INITIALDESISUBMITDATE_R,BLUEGRAPHDOCUMENT_P,BLUEGRAPHDOCUMENT_R,BLUEGRAPHARRIVALDATE,CURRENTPROGRESS,REMARK,INITDATE&location=T_PLANRUN_DTZ&condition=" + escape(conditions) + "&search=" + stage + "&flagCurStage=1";

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
     //消息提示
     function doCellTip() {
         $('#dg').datagrid('doCellTip', { 'max-width': '100px' });
     }
     function cancelCellTip() {
         $('#dg').datagrid('cancelCellTip');
     }
     //矿工程量连接
     function AssignmentWorkload(val, row) {
         return "<a href='#' onclick=\"parent.addTab('矿工程量','plan/planRun_dtz/AssignmentWorkload_mine.aspx?id=" + row.PID + "')\">矿工程量</a>";
     }

    </script>
</head>
<body>
    <form id="form1" runat="server">
<div id="cc" class="easyui-layout">	
<div data-options="region:'center',split:true">
  <table id="dg"  style="width:100%; height:100%">
        <thead frozen="true">    
           <tr>
                <th data-options="field:'pic',width:30,align:'center',formatter:picformatter">状态</th>
                <th field="workitem" id="wi" hidden="true" width="30">操作</th>
                <th field="mineworkload" id="mw" width="60" data-options="formatter:AssignmentWorkload">矿工程量</th>
                <th field="PNAME"  width="150" sortable="true">项目名称</th>
                <th field="PNUMBER"  width="110">项目号</th>	
            </tr>
		</thead>
		<thead>
			<tr>
                <th colspan="3" align="center">计划下达</th>
                <th field="PLANARRIVALFILE" width="150" rowspan="2">计划下达文件</th>
                <th colspan="3" align="center">批复下达</th>
                <th field="DESIAPPRFILE" width="150" rowspan="2">设计批复文档</th>
				<th field="SOLUCHIEF"  width="100" sortable="true" rowspan="2">项目方案负责人</th>
				<th field="DESICHIEF"  width="100" rowspan="2">项目设计负责人</th>
                <th field="SOLUCHECKDATE"  width="100" rowspan="2" data-options="formatter:formatterdate">审查时间</th>
                <th colspan="2" align="center">工程量提交</th>
				<th colspan="2" align="center">初设上报时间</th>
				<th colspan="2" align="center">蓝图存档时间</th>
                <th field="BLUEGRAPHARRIVALDATE" width="150"  data-options="formatter:color18" rowspan="2">蓝图最终下发时间</th>
                <th field="CURRENTPROGRESS"  width="150" rowspan="2">当前进度</th>
				<th field="REMARK"  width="150" rowspan="2">备注</th>
                <th field="INITDATE"  width="150" rowspan="2" data-options="formatter:formatterdate">发起日期</th>
			</tr>
            <tr>
                <th field="ESTIINVESTMENT"  width="100" sortable="true" rowspan="1">估算投资</th>
                <th field="PLANARRIVALFILENUMBER"  width="150" rowspan="1">计划下达文件号</th>
				<th field="PLANARRIVALDATE"  width="150" data-options="formatter:color12" rowspan="1">计划下达文件批准日期</th>

                <th field="PLANINVESMENT"  width="100" rowspan="1">计划投资</th>
				<th field="DESIAPPROVALARRIVALFILENUMBER" width="150" rowspan="1">设计批复下达文件号</th>
                <th field="DESIAPPROVALARRIVALDATE"  width="150" data-options="formatter:color13" rowspan="1">设计批复文件批准日期</th>

                <th field="WORKLOADSUBMITDATE_P"  width="150" data-options="formatter: color15"  rowspan="1">计划时间</th>				
				<th field="WORKLOADSUBMITDATE_R"  width="150" data-options="styler: color5,formatter:formatterdate"  rowspan="1">实际时间</th>
                <th field="INITIALDESISUBMITDATE_P"  width="150"  rowspan="1">计划时间</th>
				<th field="INITIALDESISUBMITDATE_R" width="150" data-options="styler: color7,formatter:formatterdate"  rowspan="1">实际时间</th>
                <th field="BLUEGRAPHDOCUMENT_P"  width="150"data-options="formatter:color17"  rowspan="1">计划时间</th>
				<th field="BLUEGRAPHDOCUMENT_R" width="150" data-options="formatter: color10"  rowspan="1">实际时间</th>
            </tr>
        </thead>
    </table>
    <input type="hidden" value="1" id="userLevel" runat="server"/>
    <input type="hidden" value="1" id="Organization" runat="server"/>
    <input type="hidden" value="1" id="userName" runat="server"/>
    <div id="toolbar">  

        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true"  onclick="return Save_Excel()" >导出</a>
        <label><input name="MessagePrompt" type="radio" value="0"  onclick="doCellTip()"/>显示消息提示</label> 
        <label><input name="MessagePrompt" type="radio"  value="1"  onclick="cancelCellTip()" checked="checked"/>禁止消息提示</label>
        <br />
        <span><label for="PYEAR">年限:</label></span><input class="easyui-combobox" id="PYEAR" value="" size="10" data-options="valueField:'text',textField:'text',url: '../../plan/getOfficeStaff/get_planYear.ashx',panelHeight:'auto'"/> 
        <span><label for="PSOURCE">项目来源:</label></span>
        <select  id="PSOURCE" class="easyui-combobox" style=" width:100px" data-options="panelHeight:'auto'">
                 <option value=""></option>
				 <option value="房屋维修">房屋维修</option>        
			     <option value="安全隐患">安全隐患</option>        
			     <option value="环保工程">环保工程</option>
			     <option value="结余资金">结余资金</option>  
                 <option value="老去改造">老区改造</option> 
                 <option value="生产维修">生产维修</option>       
			     <option value="其他">其他</option>
			</select>
        <span><label for="PNUMBER">项目号:</label></span><input class="easyui-textbox" id="PNUMBER" value="" size="10" />
        <input type="radio" name="stage" value="solution" id="solution" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>方案阶段
        <input type="radio" name="stage" value="design" id="design" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>初设阶段
        <input type="radio" name="stage" value="budget" id="budget" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>概算阶段
        <input type="radio" name="stage" value="graph" id="graph" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>施工图阶段
        <input type="radio" name="stage" value="finished" id="finished" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>已完成
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_dg()">查询</a>
     </div>
</div>
</div>
    </form>

    <div id="dlg_wl" class="easyui-dialog" style="width: 350px; height: 400px; padding: 10px 20px"
        data-options="closed:true" title="各专业工程量">
        <ul id="tt_wl" data-options="lines:true" style="height:94%;"></ul>
    </div>
    <div id="dlg_blue" class="easyui-dialog" style="width: 350px; height: 400px; padding: 10px 20px"
        data-options="closed:true" title="蓝图">
        <ul id="tt_blue" data-options="lines:true" style="height:94%;"></ul>
    </div>
    <div id="dlg_arrivalBlue" class="easyui-dialog" style="width: 350px; height: 400px; padding: 10px 20px"
        data-options="closed:true" title="下发蓝图">
        <ul id="tt_arrivalBlue" data-options="lines:true" style="height:94%;"></ul>
    </div>
    <script type="text/javascript">
        function ShowDialog(pid, pname, pnum, type) {
            if (type == "wl") {
                $('#dlg_wl').dialog('open');
                $('#tt_wl').tree({
                    url: 'get_Tree.ashx?pid=' + pid + '&pname=' + encodeURIComponent(pname) + '&pnumber=' + encodeURIComponent(pnum) + '&type=wl',
                    loadFilter: function (data) {
                        return data;
                    }
                });
            }
            else if (type == "blue") {
                $('#dlg_blue').dialog('open');
                $('#tt_blue').tree({
                    url: 'get_Tree.ashx?pid=' + pid + '&pname=' + encodeURIComponent(pname) + '&pnumber=' + encodeURIComponent(pnum) + '&type=blue',
                    loadFilter: function (data) {
                        return data;
                    }
                });
            }
            else if (type == "arrivalBlue") {
                $('#dlg_arrivalBlue').dialog('open');
                $('#tt_arrivalBlue').tree({
                    url: 'get_Tree.ashx?pid=' + pid + '&pname=' + encodeURIComponent(pname) + '&pnumber=' + encodeURIComponent(pnum) + '&type=arrivalBlue',
                    loadFilter: function (data) {
                        return data;
                    }
                });
            }
        }
    </script>
</body>
</html>
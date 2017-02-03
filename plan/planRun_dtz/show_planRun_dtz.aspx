<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_planRun_dtz.aspx.cs" Inherits="plan_planRun_dtz_show_planRun_dtz" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--显示完整的计划运行--%>
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
      .border-table {   
        border-collapse: collapse;   
        border: none;   
    }   
    .border-table .top {   
        border-top: solid blue 1px;   
        border-left: solid blue 1px;
        border-right: solid blue 1px;
    }   
    .border-table .center    
    {
        border-top: solid blue 1px;
        border-left: solid blue 1px;
        border-right: solid blue 1px;
    }   
    .border-table .bottom {   
        border-bottom: solid blue 1px;   
        border-left: solid blue 1px;
        border-right: solid blue 1px;
    }  
    .border-table .only {   
        border: solid blue 1px;
          
    }   
</style>  

 <script type="text/javascript">
     $(function () {
         $('#dg').datagrid({
             title: "自主设计",
             url: "get_planRun_dtz.ashx?buf=0",
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
                     return 'background-color:Yellow';
                 }
             },
             onDblClickRow: function (index, row) {
                 openwin(row.PID,row.PLANFLAG,row.PLANFLAG_DESIGN);
             },
             loader: SCLoader
         });
         $("#dg").datagrid('hideColumn', "SOLUAPPROVEFILE"); //隐藏方案批复文件
         $("#dg").datagrid('hideColumn', "BLUEGRAPHFILE"); //隐藏蓝图
         $("#dg").datagrid('hideColumn', "DESIAPPRFILE"); //隐藏设计批复文档
         $("#dg").datagrid('hideColumn', "PLANARRIVALFILE"); //隐藏计划下达文件
         $("#dg").datagrid('hideColumn', "FINALBUDGETFILE"); //隐藏最终概算文档
         //规定用户权限
         var organization = $('#Organization').val();
         var userlevel = $('#userLevel').val();
         if (!(userlevel == "2" && (organization == "设计室" || organization == "矿区室" || organization == "规划室"))) {
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
                 }

             });
         }
     }

    
     //跳转到相应的电子档案，补充信息
     function addInfm(title, pname, pnumber, ptype, path) {
         parent.addTab("补充信息->" + title, "crud_tables/archives/" + path + "?pname=" + encodeURIComponent(pname) + "&pnumber=" + encodeURIComponent(pnumber) + "&ptype=" + encodeURIComponent(ptype));
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
           function FindData_dg() {
               var stage = "";
               var radioStage = document.getElementsByName("stage");
               for (var i = 0; i < radioStage.length; i++) {
                   if (radioStage[i].checked) {
                       stage = radioStage[i].value;
                       alert(stage);
                       break;
                   }
               }
               $('#dg').datagrid('load', {
                   PName: $('#PNAME').val(),
                   SoluChief: $('#SOLUCHIEF').val(),
                   PNumber: $('#PNUMBER').val(),
                   stage: stage
               });

           }
//方法说明：发起计划项目
        function newItem() {
            var hh;
            if ($('#Organization').val() == "规划室" || $('#Organization').val() == "矿区室")
                hh = 'init_planRun_dtz.aspx';
            else if ($('#Organization').val() == "设计室")
                hh = 'init_planRun_free.aspx';
            else hh = "";
            $('#cc').layout('remove', 'north');
            $('#cc').layout('add',{
            region: 'north',
            height:270,
            split: true,
            collapsed:true,
            href:hh
            });
            $('#cc').layout('expand','north');
        }
        function picformatter(val, row) {        
            //alert(row.workitem);
            if(row.workitem=='等待中')
            {
                pic="../../images/run.png";
            }else if(row.workitem=='结束'){
                pic="../../images/over.png";
            } else if (row.workitem == '退回方案') {
                pic = "../../images/back.png";
            } else if (row.workitem == '重新审查方案') {
                pic = "../../images/Return.png";
            } else {
                pic="../../images/work.png";
            }          
            var pp= "<a onclick=\"working('"+row.workitem+"','"+row.workurl+"','"+row.PID+"')\"><img width='20px' height='20px' src='"+pic+"'/></a>";
            return pp;
            //return "<a onclick=\'alert()\'>"+row.workitem+"</a>";
        }
        function working(state, hh, id) {
            $('#cc').layout('remove', 'north');
            if (state != '结束'&& state != '退回方案'&&hh!='') 
            { 
                $('#cc').layout('add',{
                region: 'north',
                height:270,
                split: true,
                collapsed:true,
                href:hh+"?id="+id
                });
            $('#cc').layout('expand', 'north');
            }
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
            if ($('#PNAME').val() != '')
                conditions += " and PNAME like '%" + $('#PNAME').val() + "%'";
            if ($('#PNUMBER').val() != '')
                conditions += " and PNUMBER like '%" + $('#PNUMBER').val() + "%'";
            if ($('#SOLUCHIEF').val() != '')
                conditions += " and SOLUCHIEF like '%" + $('#SOLUCHIEF').val() + "%'";
            var stage = "";
            var radioStage = document.getElementsByName("stage");
            for (var i = 0; i < radioStage.length; i++) {
                if (radioStage[i].checked) {
                    stage = radioStage[i].value;
                    break;
                }
            }
            window.location = "../../tools/toExcel.aspx?name=项目名称,项目来源,项目方案负责人,估算投资,方案计划完成时间 ,方案实际完成时间,所内计划完成时间,所内实际完成时间,厂内计划完成时间,厂内实际完成时间,方案上报时间,审查时间,审查意见答复时间,方案批复下达时间,项目号,计划投资,项目设计负责人,主专业校对及室负责人,概算汇总人,一次委托资料计划时间,一次委托资料实际时间,工程量计划提交时间,工程量实际提交时间,概算计划完成时间,概算实际完成时间,初设计划上报时间,初设实际上报时间,概算计划调整时间,概算实际调整时间,计划下达文件号,计划下达文件批准日期,设计批复下达文件号,设计批复文件批准日期,二次委托资料结束时间,施工白图计划校审时间,施工白图实际校审时间,蓝图计划存档时间,蓝图实际存档时间,蓝图下发时间,备注,发起时间" +
            "&field=PNAME,PSOURCE,SOLUCHIEF,ESTIINVESTMENT,SOLUCOMPDATE_P,SOLUCOMPDATE_R,INSTCHECKDATE_P,INSTCHECKDATE_R,FACTCHECKDATE_P,FACTCHECKDATE_R,SOLUSUBMITDATE,SOLUCHECKDATE,SOLUADVICEREPLYDATE,SOLUAPPROVEDATE,PNUMBER,PLANINVESMENT,DESICHIEF,MAJORPROOFREADER,BUDGETCHIEF,MAJORDELEGATEDATE_P,MAJORDELEGATEDATE_R,WORKLOADSUBMITDATE_P,WORKLOADSUBMITDATE_R,BUDGETCOMPDATE_P,BUDGETCOMPDATE_P,INITIALDESISUBMITDATE_P,INITIALDESISUBMITDATE_R,BUDGETADJUSTDATE_P,BUDGETADJUSTDATE_R,PLANARRIVALFILENUMBER,PLANARRIVALDATE,DESIAPPROVALARRIVALFILENUMBER,DESIAPPROVALARRIVALDATE,SECONDCOMMISSIONDATE,WHITEGRAPHCHECKDATE_P,WHITEGRAPHCHECKDATE_R,BLUEGRAPHDOCUMENT_P,BLUEGRAPHDOCUMENT_R,BLUEGRAPHARRIVALDATE,REMARK,INITDATE&location=T_PLANRUN_DTZ&condition=" + escape(conditions) + "&search=" + stage;

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

        function doCellTip() {
            $('#dg').datagrid('doCellTip', { 'max-width': '100px' });
        }
        function cancelCellTip() {
            $('#dg').datagrid('cancelCellTip');
        }
        function openwin(pid,flagPlan,flagDesign) {
            var organization = $('#Organization').val();
            var userlevel = $('#userLevel').val();
            var url = "";
            if (userlevel == "2" && organization == "规划室")
                url = "FullPlan.aspx";
            if (userlevel == "2" && organization == "设计室")
                url = "FullDesign.aspx";
            if (userlevel == "2" && organization == "综合室")
                url = "FullBudget.aspx";
            if (userlevel == "2" && organization == "矿区室") {
            if(flagPlan=="2"&&flagDesign!="1")
                url = "FullPlan.aspx";
            if (flagPlan != "2" && flagDesign == "1")
                url = "FullDesign.aspx";
            if (flagPlan == "2" && flagDesign == "1")
                url = "Plan_Design_combine.aspx";
            }
            if (url != "") {
                window.open(url + "?id=" + pid, "newwindow", "height=600, width=1100, toolbar =no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no") //写成一行
            }
        }
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
        <thead>    
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'pic',width:50,align:'center',formatter:picformatter">状态</th>
                <th field="workitem" id="wi" hidden="true" width="50">操作</th>
                <th field="mineworkload" id="mw" width="80" data-options="formatter:AssignmentWorkload">矿工程量</th>
                <th field="workurl" hidden="true" width="50">url</th>
                <th field="PNAME"  width="100" sortable="true">项目名称</th>
				<th field="PSOURCE"   width="100" sortable="true">项目来源</th>
				<th field="SOLUCHIEF"  width="100" sortable="true">项目方案负责人</th>
				<th field="ESTIINVESTMENT"  width="100" sortable="true">估算投资</th>
				<th field="SOLUCOMPDATE_P"  width="150" data-options="formatter:formatterdate">方案计划完成时间</th>
				<th field="SOLUCOMPDATE_R" width="150" data-options="styler: color1,formatter:formatterdate">方案实际完成时间</th>
				<th field="INSTCHECKDATE_P"  width="150" data-options="formatter:formatterdate">所内计划审查时间</th>
				<th field="INSTCHECKDATE_R"  width="150" data-options="styler: color2,formatter:formatterdate">所内实际审查时间</th>				
				<th field="FACTCHECKDATE_P"  width="150" data-options="formatter:formatterdate">厂内计划审查时间</th>
				<th field="FACTCHECKDATE_R"  width="150" data-options="styler:color3,formatter:formatterdate">厂内实际审查时间</th>
				<th field="SOLUSUBMITDATE" width="100" data-options="formatter:formatterdate">方案上报时间</th>
				<th field="SOLUCHECKDATE"  width="100" data-options="formatter:formatterdate">审查时间</th>
				<th field="SOLUADVICEREPLYDATE" width="150" data-options="formatter:formatterdate">审查意见答复时间</th>
				<th field="SOLUAPPROVEDATE"  width="150" data-options="formatter:color11">方案批复下达时间</th>
                <th field="SOLUAPPROVEFILE" width="150">方案批复</th>
                <th field="FINALSOLUTIONFILE" width="150" data-options="formatter:finalFileFormatter">最终方案文档</th>
                <th field="DESICONDITIONTABLE" width="150" data-options="formatter:desiConditionTable">设计条件表</th>
				<th field="PNUMBER"  width="100">项目号</th>				
				<th field="PLANINVESMENT"  width="100">计划投资</th>
				<th field="DESICHIEF"  width="100">项目设计负责人</th>
				<th field="MAJORPROOFREADER" width="150">主专业校对及室负责人</th>
				<th field="BUDGETCHIEF"  width="100">概算汇总人</th>
				<th field="MAJORDELEGATEDATE_P" width="150" data-options="formatter: color8">一次委托资料计划时间</th>
				<th field="MAJORDELEGATEDATE_R"  width="150" data-options="formatter: color4">一次委托资料实际时间</th>
				<th field="WORKLOADSUBMITDATE_P"  width="150" data-options="formatter: color15">工程量计划提交时间</th>				
				<th field="WORKLOADSUBMITDATE_R"  width="150" data-options="styler: color5,formatter:formatterdate">工程量实际提交时间</th>
				<th field="BUDGETCOMPDATE_P"  width="150" data-options="formatter:formatterdate">概算计划完成时间</th>
				<th field="BUDGETCOMPDATE_R" width="150" data-options="styler: color6,formatter:formatterdate">概算实际完成时间</th>
				<th field="INITIALDESISUBMITDATE_P"  width="150" data-options="formatter:formatterdate">初设计划上报时间</th>
				<th field="INITIALDESISUBMITDATE_R" width="150" data-options="styler: color7,formatter:formatterdate">初设实际上报时间</th>
				<th field="BUDGETADJUSTDATE_P"  width="150" data-options="formatter:formatterdate">概算计划调整时间</th>
				<th field="BUDGETADJUSTDATE_R" width="150" data-options="formatter: color14">概算实际调整时间</th>
                <th field="FINALBUDGETFILE" width="150">最终概算文档</th>
				<th field="PLANARRIVALFILENUMBER"  width="150">计划下达文件号</th>
				<th field="PLANARRIVALDATE"  width="150" data-options="formatter:color12">计划下达文件批准日期</th>
                <th field="PLANARRIVALFILE" width="150">计划下达文件</th>
				<th field="DESIAPPROVALARRIVALFILENUMBER" width="150">设计批复下达文件号</th>
				<th field="DESIAPPROVALARRIVALDATE"  width="150" data-options="formatter:color13">设计批复文件批准日期</th>
                <th field="DESIAPPRFILE" width="150">设计批复文档</th>
				<th field="WHITEGRAPHCHECKDATE_P"  width="150" data-options="formatter:formatterdate">施工白图计划校审时间</th>				
				<th field="WHITEGRAPHCHECKDATE_R"  width="150" data-options="formatter: color9">施工白图实际校审时间</th>
                <th field="SECONDCOMMISSIONDATE"  width="150" data-options="formatter:color16">二次委托资料结束时间</th>
				<th field="BLUEGRAPHDOCUMENT_P"  width="150"data-options="formatter:color17">蓝图计划存档时间</th>
				<th field="BLUEGRAPHDOCUMENT_R" width="150" data-options="formatter: color10">蓝图实际存档时间</th>
                <th field="BLUEGRAPHFILE" width="150">蓝图</th>
                <th field="BLUEGRAPHARRIVALDATE" width="150"  data-options="formatter:color18">蓝图最终下发时间</th>
				<th field="REMARK"  width="150">备注</th>
                <th field="INITDATE"  width="150" data-options="formatter:formatterdate">发起日期</th>
			
			</tr>
        </thead>
    </table>
    <input type="hidden" value="1" id="userLevel" runat="server"/>
    <input type="hidden" value="1" id="Organization" runat="server"/>
    <input type="hidden" value="1" id="userName" runat="server"/>
    <div id="toolbar">  
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">启动新项目</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a> 
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true"  onclick="return Save_Excel()" >导出</a>
        <label><input name="MessagePrompt" type="radio" value="0"  onclick="doCellTip()"/>显示消息提示</label> 
        <label><input name="MessagePrompt" type="radio"  value="1"  onclick="cancelCellTip()" checked="checked"/>禁止消息提示</label>
        <br />
        <span><label for="PNAME">项目名称:</label></span><input class="easyui-textbox" id="PNAME" value="" size="10" /> 
        <span><label for="SOLUCHIEF">项目方案负责人:</label></span><input class="easyui-textbox" id="SOLUCHIEF" value="" size="10" /> 
        <span><label for="PNUMBER">项目号:</label></span><input class="easyui-textbox" id="PNUMBER" value="" size="10" />
        <input type="radio" name="stage" value="solution" id="solution" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>方案阶段
        <input type="radio" name="stage" value="design" id="design" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>初设阶段
        <input type="radio" name="stage" value="budget" id="budget" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>概算阶段
        <input type="radio" name="stage" value="graph" id="graph" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>施工图阶段
        <input type="radio" name="stage" value="finished" id="finished" onclick= "if(this.c==1){this.c=0;this.checked=0}else{this.c=1}" c="0"/>已完成
 &nbsp; <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_dg()">查询</a>
     </div>
</div>
</div>
    </form>

    <div id="dlg_wl" class="easyui-dialog" style="width: 350px; height: 400px; padding: 10px 20px"
        data-options="closed:true" title="各专业工程量">
        <ul id="tt_wl" data-options="lines:true" style="height:94%;"></ul>
    </div>
   <div id="dlg_fircom" class="easyui-dialog" style="width: 350px; height: 400px; padding: 10px 20px"
        data-options="closed:true" title="一次委托资料">
        <ul id="tt_fircom" data-options="lines:true" style="height:94%;"></ul>
    </div>
    <div id="dlg_seccom" class="easyui-dialog" style="width: 350px; height: 400px; padding: 10px 20px"
        data-options="closed:true" title="二次委托资料">
        <ul id="tt_seccom" data-options="lines:true" style="height:94%;"></ul>
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
                    url: 'get_Tree.ashx?pid='+ pid +'&pname=' + encodeURIComponent(pname) +'&pnumber='+encodeURIComponent(pnum)+'&type=wl',
                    loadFilter: function (data) {
                        return data;
                    }
                });
            }
            else if(type=="fircom"){
                $('#dlg_fircom').dialog('open');
                $('#tt_fircom').tree({
                    url: 'get_Tree.ashx?pid=' + pid + '&pname=' + encodeURIComponent(pname) + '&pnumber=' + encodeURIComponent(pnum) + '&type=fircom',
                    loadFilter: function (data) {
                        return data;
                    }
                });
            }
            else if (type == "seccom") {
                $('#dlg_seccom').dialog('open');
                $('#tt_seccom').tree({
                    url: 'get_Tree.ashx?pid=' + pid + '&pname=' + encodeURIComponent(pname) + '&pnumber=' + encodeURIComponent(pnum) + '&type=seccom',
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

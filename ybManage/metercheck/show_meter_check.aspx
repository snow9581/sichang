<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_meter_check.aspx.cs" Inherits="Instrument_" %>
<!--仪表检定流程界面-->
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
    <input id="userLevel" runat="server" type="hidden"/>
    <input id="dm" runat="server" type="hidden"/>
    <div id="cc" class="easyui-layout">	
    <div data-options="region:'center'">
    <table id="dg" width="100%">
        <thead>
            <tr>
                <th data-options="field:'pic',width:5,align:'center',formatter:picformatter">状态</th>
                <th field="JG" width="10" data-options="formatter:resultformater">检定结果</th>
                <th field="workitem" id="wi" hidden="true">操作</th>
                <th field="sbb" data-options="formatter:sbbformatter">申报表</th>
                <th field="qrd" data-options="formatter:qrdformatter">确认单</th>
				<th field="BM">申报表名</th>				
				<th field="TIME" width="15">开始时间</th>
                <th field="INITIATOR" width="10">发起人</th>              
			</tr>
        </thead>
    </table>
    </div>
    </div>
    <div id="toolbar">
        <a href="#" id="btn_new" style=" visibility:hidden" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">发起申请</a>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <label>月份:</label>     
        <select  id="month" name="month" class="easyui-combobox" style="width:50px;">
                 <option value="0">全部</option> 
				 <option value="1">1</option>        
			     <option value="2">2</option>        		        
			     <option value="3">3</option>
                 <option value="4">4</option>     	     
			     <option value="5">5</option>        
			     <option value="6">6</option>        
			     <option value="7">7</option>
			     <option value="8">8</option>
                 <option value="9">9</option>
                 <option value="10">10</option> 
                 <option value="11">11</option> 
                 <option value="12">12</option>         
        </select>
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
    </div>
</body>
   <script type="text/javascript">       
       function resultformater(val, row) {
           var innerhtml = "";          
           if (val == '1') innerhtml = "合格";
           else if (val == '0') innerhtml = "不合格";
           return innerhtml;
       }
       function sbbformatter(val, row) {
           var innerhtml = "<a href='#' onclick=\"show_sbb('" + row.workitem + "'," + row.ID + ")\">申报表</a>";
           return innerhtml;
       }
       function qrdformatter(val, row) {
           var state = row.STATE;
           var innerhtml;
           //填写确认单阶段和完成阶段可以查看确认单
           if (state == '4' || state == '5')
               innerhtml = "<a href='#' onclick=\"show_qrd('" + row.workitem + "'," + row.ID + ")\">确认单</a>";
           else
               innerhtml = "";
           return innerhtml;
       }
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
           var pp = "<a onclick=\"show_sbb('" + row.workitem + "'," + row.ID + ")\"><img width='20px' height='20px' src='" + pic + "'/></a>";
           return pp;

       }
       function newItem() {
           location.href = "select_meter.aspx";
       }
       function show_sbb(state, hh) {
          
           $('#cc').layout('remove', 'north'); //刷新layout
           $('#cc').layout('add', {
                region: 'north',
                height: 400,
                split: true,
                href: "sbbTable.aspx?FROMID="+hh
            });          
           // $('#cc').layout('expand', 'north');
        }
        function show_qrd(state, hh) {
            $('#cc').layout('remove', 'north'); //刷新layout
           
            $('#cc').layout('add', {
                region: 'north',
                height: 400,
                split: true,
                href: "qrdTable.aspx?FROMID=" +hh
            });
           // $('#cc').layout('expand', 'north');
        }
       $(function () {
           $('#dg').datagrid({
               title: "仪表检定流程总览",
               url: "get_meter_check.ashx",
               fit: true,
               fitColumns: true,
               collapsible: true,
               toolbar: "#toolbar",
               pagination: "true",
               pageSize: 30,
               singleSelect: false,
               remoteSort: false,
               rownumbers: "true"
           });
           var DM = $("#dm").val();
           var userlevel = $("#userLevel").val();
           if (userlevel == '6'&&dm=="仪表室")
               $("#btn_new").css('visibility', 'visible');
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
       function FindData() {
           $('#dg').datagrid('load', {
               BM:$('#month').combobox('getValue')
           });
       } 
    </script>
</html>

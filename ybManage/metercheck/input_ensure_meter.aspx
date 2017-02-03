<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_ensure_meter.aspx.cs" Inherits="Instrument_input_Table" %>
<!--员工发起仪表检定时，手动增加待检定仪表-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script> 
</head>
<body>
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>计量器具名称</td>
			<td><input id="JLQJMC" name="JLQJMC" class="easyui-validatebox" type="text"/></td>
			<td>规格型号</td>
			<td><input id="GGXH" name="GGXH"/></td>
            <td>管理类别</td>
			<td><input id="JLLB" name="JLLB"/></td>
        </tr>
        <tr>
            <td>检定周期</td>
			<td><input id="JDZQ" name="JDZQ"/></td>
            <td>准确度等级</td>
			<td><input id="JDDJ" name="JDDJ"/></td>
            <td>数量</td>
			<td><input id="SL" name="SL"/></td>
        </tr>
		<tr>
            <td>计划检定日期</td>
			<td><input id="JDRQ" name="JDRQ" class="easyui-datebox"/></td>
            <td>计量器具使用单位</td>
			<td><input id="SYDW" name="SYDW"/></td>
            <td>计量器具检定单位</td>
			<td><input id="JDDW" name="JDDW"/></td>
		</tr>
        <tr>
            <td>鉴定单价(元)</td>
			<td><input id="E_JDDJ" name="E_JDDJ"  onchange="computeHJ();"/></td>
            <td>鉴定费用合计(元)</td>
			<td><input id="E_JDFYHJ" name="E_JDFYHJ"/></td>
		</tr>
		<tr>
            <td>申请检定方式</td>
			<td><input id="JDFS" name="JDFS"/></td>
            <td>备注</td>
			<td><input id="SM" name="SM"/></td>
		</tr>
        </table>                                                    
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val(),$('#JLQJMC').val(),$('#GGXH').val(),$('#JLLB').val(),$('#JDZQ').val(),$('#JDDJ').val(),$('#SL').val(),$('#JDRQ').datebox('getValue'),$('#SYDW').val(),$('#JDDW').val(),$('#JDFS').val(),$('#E_JDDJ').val(),$('#E_JDFYHJ').val(),$('#SM').val())">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">Cancel</a>		      	
	</div>
</form>
<script type="text/javascript">
    function computeHJ() {
        var count = parseInt($("#SL").val());
        var price = parseInt($("#E_JDDJ").val());
        $("#E_JDFYHJ").val(count * price);
    }
</script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_qrd2.aspx.cs" Inherits="ybManage_Instrument_input_qrd2" %>
<!--员工填写确认单中手填部分-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
			<td><input id="GGXH" name="GGXH"  class="easyui-validatebox" type="text"/></td>
            <td>安装位置</td>
			<td><input id="JLLB" name="JLLB"  class="easyui-validatebox" type="text"/></td>
        </tr>
        <tr>
            <td>维修更换部件</td>
			<td><input id="JDWCSL" name="JDWCSL"  class="easyui-validatebox" type="text"/></td>
            <td>维修单位</td>
			<td><input id="JDDJ" name="JDDJ"  class="easyui-validatebox" type="text"/></td>
            <td>维修费用</td>
			<td><input id="JDFYHJ" name="JDFYHJ"  class="easyui-validatebox" type="text"/></td>
            <td>备注</td>
			<td><input id="TSQKSM" name="TSQKSM"  class="easyui-validatebox" type="text"/></td>
        </tr>
        </table>                                                    
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save2" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">Cancel</a>		      	
	</div>
</form>
</body>
</html>


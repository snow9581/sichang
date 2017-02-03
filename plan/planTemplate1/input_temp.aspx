<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_temp.aspx.cs" Inherits="temp_input_temp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
   <script src="../../js/export.js" type="text/javascript"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>模板名称</td>
            <td><input name="TEMPNAME" class="easyui-validatebox" size='5' /></td>
			<td>编写方案周期</td>
			<td><input name="WIRTESOLUCYCLE" class="easyui-validatebox" size='5' value='0'/></td>
			<td>所审方案周期</td>
			<td><input name="INSTCHECKSOLUCYCLE" class="easyui-validatebox" size='5' value='0'/></td>
			<td>厂审方案周期</td>
			<td><input name="FACTCHECKSOLUCYCLE" class="easyui-validatebox" size='5' value='0' /></td>
			
		</tr>

        </table>
         <input type="hidden" value=""  id="userLevel"  runat="server"/> 
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>		       	
	</div>
</form>
</body>
</html>

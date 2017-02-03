<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_CommissionInformation.aspx.cs" Inherits="crud_form_archives_input_CommissionInformation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head  runat="server">
    <title></title>
</head>
<body>
    <form method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <input type="hidden" value="1"  id="pre_type"  runat="server"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>项目编号</td>
			<td><input id="PNUMBER" name="PNUMBER" class="easyui-validatebox" runat="server" readonly="readonly"/></td>
			<td>项目名称</td>
			<td><input id="PNAME" name="PNAME" class="easyui-validatebox" runat="server" readonly="readonly"/></td>
		</tr>
        <tr>
			<td>委托者姓名</td>
			<td><input name="CONSIGNER" class="easyui-validatebox"/></td>
			<td>委托者专业</td>
			<td><input name="CONSIGNERMAJOR" class="easyui-validatebox"/></td>
		</tr>
         <tr>
			<td>接收者姓名</td>
			<td><input name="SENDEE" id="SENDEE"  class="easyui-validatebox"/></td>
			<td>接受者专业</td>
			<td><input name="SENDEEMAJOR" id="SENDEEMAJOR" class="easyui-validatebox"/></td>
		</tr>
		<tr>
			<td>文件类型</td>
			<td width="20">
			<select  name="FILETYPE" class="easyui-combobox">
				 <option value="一次委托资料">一次委托资料</option>        
			     <option value="二次委托资料">二次委托资料</option>        
			     <option value="其他">其他</option>
			</select>
			</td>
			<td>备注</td>
			<td colspan="5"><textarea rows="3"   cols="70"name="BZ" class="easyui-validatebox" /></td>			
		</tr>
		<tr>
			<td>委托资料</td>
			<td><input type="file" name="FILES" class="easyui-validatebox" /></td>			
		    <td><input type="hidden" name="ARCHIVES" class="easyui-validatebox" /></td>	
		</tr>
        </table>
         <input type="hidden" value=""  id="userLevel"  runat="server"/> 
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">Cancel</a>
	</div>
</form>
<script type="text/javascript">
    $(function () {       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑
        var userlevel = $('#userLevel').val();
        if (userlevel == "6") {
            $("form :input").attr("readonly", "readonly"); //设置控件为只读
            $("form :input[type='file']").hide(); //隐藏上传文件窗口
            $("form a").hide(); //隐藏保存和撤销按钮    
        }
    }); 
    
   </script>
</body>
</html>

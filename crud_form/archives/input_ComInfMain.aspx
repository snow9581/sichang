<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_ComInfMain.aspx.cs" Inherits="crud_form_archives_input_ComInfMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title></title>
</head>
<body>
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <input type="hidden" value="1"  id="HDflag"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>项目编号</td>
			<td><input name="PNUMBER" class="easyui-validatebox" required="true"/></td>
			<td>项目名称</td>
			<td><input name="PNAME" class="easyui-validatebox"/></td>
            
		</tr>
        <tr class="NewRecord">
			<td>委托者姓名</td>
			<td><input name="CONSIGNER" class="easyui-validatebox" required="true"/></td>
			<td>委托者专业</td>
			<td><input name="CONSIGNERMAJOR" class="easyui-validatebox" required="true"/></td>
		</tr>
         <tr class="NewRecord">
			<td>接收者姓名</td>
			<td><input name="SENDEE" class="easyui-validatebox" required="true"/></td>
			<td>接受者专业</td>
			<td><input name="SENDEEMAJOR" class="easyui-validatebox" required="true"/></td>
		</tr>
		<tr class="NewRecord">
			<td>文件类型</td>
			<td width="20">
			<select  name="FILETYPE" class="easyui-combobox" style="">
				 <option value="一次委托资料">一次委托资料</option>        
			     <option value="二次委托资料">二次委托资料</option>        
			     <option value="其他">其他</option>
			</select>
			</td>
			<td>备注</td>
			<td colspan="5"><textarea rows="3"   cols="70"name="BZ" class="easyui-validatebox" /></td>			
		</tr>
		<tr class="NewRecord">
			<td>委托资料</td>
			<td><input type="file" name="FILES" class="easyui-validatebox" required="true"/></td>			
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
        if ($('#HDflag').val() != "true") {
            $('.NewRecord').remove();
            $("#Table1").css("width", "500px");
        }
    }); 
    
   </script>
</body>
</html>
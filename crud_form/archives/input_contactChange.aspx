<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_contactChange.aspx.cs" Inherits="easyui_crud_demo_show_form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
   
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>项目编号</td>
			<td><input name="PID" class="easyui-validatebox" required="true"/></td>
			<td>项目名称</td>
			<td><input name="PNAME" class="easyui-validatebox" required="true"/></td>
			<td>项目负责人</td>
			<td><input name="PLEADER" class="easyui-validatebox" /></td>
			<td>专业负责人</td>
			<td><input name="SPECIALLEADER" class="easyui-validatebox" /></td>
		</tr>
		<tr>			
			<td>联络变更内容</td>
			<td><input name="CHANGEDETAIL" class="easyui-validatebox" /></td>			
		    <td>联络变更原因</td>
			<td><input name="CHANGEREASON" class="easyui-validatebox" /></td>
			<td>投资增减情况</td>
			<td><input name="INVESTCHANGE" class="easyui-numberbox" precision="2"/></td>	
			<td>文件类型</td>
			<td width="20">
			<select  name="FILETYPE" class="easyui-combobox" style="">
				 <option value="联络">联络</option>        
			     <option value="变更">变更</option>        
			</select>
			</td>	
		</tr>
        <tr>
			<td>备注</td>
			<td colspan="3"><textarea rows="1"   cols="40"name="BZ" class="easyui-validatebox" /></td>	
			<td>联络变更文档</td>
			<td><input type="file" name="FILES" class="easyui-validatebox" /></td>			
		    			
		</tr>
        </table>
        <input type="hidden" value=""  id="userLevel"  runat="server"/> 
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
		       
	
	</div>
</form>
<script type="text/javascript">
     $(function(){       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑
        var userlevel = $('#userLevel').val();
         if (userlevel == "6") {
           $("form :input").attr("readonly","readonly");//设置控件为只读
           $("form :input[type='file']").hide();//隐藏上传文件窗口
           $("form a").hide(); //隐藏保存和撤销按钮    
       }
     }); 
    
   </script>
</body>
</html>

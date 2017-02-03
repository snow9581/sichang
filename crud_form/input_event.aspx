<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_event.aspx.cs" Inherits="easyui_crud_demo_show_form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form method="post" runat="server">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <input name="KM" class="easyui-validatebox"  type="hidden"/>
	<input name="DM" class="easyui-validatebox" type="hidden"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>	    
			<td>时间</td>
			<td><input name="TIME" class="easyui-datebox" required="true"/></td>
			<td>记事人</td>
			<td><input name="RECORDER" class="easyui-validatebox" /></td>
			<td>审核人</td>
			<td><input name="AUDITOR" class="easyui-validatebox" /></td>
		</tr>
		<tr>
		<td>记事内容</td>
		<td colspan="5"><textarea name="CONTENT" rows="5" cols="120"></textarea></td>
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
         if (userlevel == "6"||userlevel == "2") {
           $("form :input").attr("readonly","readonly");//设置控件为只读
           $("form :input[type='file']").hide();//隐藏上传文件窗口
           $("form a").hide(); //隐藏保存和撤销按钮    
       }
     }); 
    
   </script>
</body>
</html>

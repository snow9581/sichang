<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_repair.aspx.cs" Inherits="easyui_crud_demo_show_form" %>

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
			<td>所属站名</td>
			<td><input name="ZM" class="easyui-validatebox" required="true"/></td>
			<td>设备名称</td>
			<td><input name="SBMC" class="easyui-validatebox" required="true"/></td>
			<td>设备型号</td>
			<td><input name="SBXH" class="easyui-validatebox" /></td>
			<td>设备能力</td>
			<td><input name="SBNL" class="easyui-validatebox" /></td>
		</tr>
		<tr>
			
			<td>投产日期</td>
			<td><input name="TCRQ" class="easyui-datebox" /></td>
			
		    <td>维修日期</td>
			<td><input name="WXRQ" class="easyui-datebox" /></td>
			<td>维修内容</td>
			<td><input name="WXNR" class="easyui-validatebox" /></td>
			<td>维修单位</td>
			<td><input name="WXDW" class="easyui-validatebox" />	</td>
		</tr>
		<tr>
			
			<td>负责人</td>
			<td><input name="FZR" class="easyui-validatebox" /></td>
			<td>联系电话</td>
			<td><input name="TELEPHONE" class="easyui-validatebox" /></td>
			<td>备注</td>
			<td><input name="BZ" class="easyui-validatebox" /></td>
			
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












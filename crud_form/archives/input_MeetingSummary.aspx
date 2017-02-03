<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_MeetingSummary.aspx.cs" Inherits="crud_form_archives_input_MeetingSummary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>  
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>名称</td>
			<td><input name="FNAME" class="easyui-validatebox" data-options="required:'true',validType:'CHS'"/></td>
			<td>文件号</td>
			<td><input name="FNUMBER" class="easyui-validatebox" required="true"/></td>
            <td>下发部门</td>
			<td><input name="XFBM" class="easyui-validatebox"/></td>
			<td>上传文档</td>
			<td><input type="file" name="FILES" class="easyui-validatebox" /></td>
            
		</tr>
        </table>
         <input type="hidden" value=""  id="userLevel"  runat="server"/> 
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">Cancel</a>
		       
	
	</div>
</form>
<script type="text/javascript">
    $(function () {

        //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑
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
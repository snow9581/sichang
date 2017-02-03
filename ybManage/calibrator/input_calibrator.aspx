<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_calibrator.aspx.cs" Inherits="ybManage_calibrator_input_calibrator" %>

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
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value=""  id="hd_index"  runat="server"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td style="width:100px">标准器名称</td>
			<td><input name="BZQMC" class="easyui-validatebox" width:15/></td>
			<td style="width:100px">负责(校对)人</td>
			<td><input name="FZR" class="easyui-validatebox" width:15/></td>
			<td style="width:100px">文件</td>
			<td><input name="WJ" type="file" class="easyui-validatebox" width:15/></td>
		</tr>
        </table>
         <input type="hidden" value=""  id="userLevel"  runat="server"/>  
	<div style="padding:5px 0;text-align:right;padding-right:30px">	      
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">Cancel</a>
	</div>
    </form>
  <script type="text/javascript">
      $(function () {       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑S
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

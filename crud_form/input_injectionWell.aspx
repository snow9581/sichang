<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_injectionWell.aspx.cs" Inherits="crud_form_input_injectionWell" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title></title>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <input name="KM" class="easyui-validatebox"  type="hidden"/>
    <input name="DM" class="easyui-validatebox" type="hidden"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr> 
			<td>站名</td>
			<td><input name="ZM" class="easyui-validatebox"/></td>
			<td>井号</td>
			<td><input name="WNUMBER" class="easyui-validatebox" /></td>
            <td>投产日期</td>
			<td><input name="TCRQ" class="easyui-datebox" /></td>
            <td>管线规格    Ф</td>
            <td style="width:50px"><input name="GXGG1" id="GXGG1" class="easyui-validatebox" runat="server" style="width:50px"/></td>
            <td>×</td>
			<td style="width:100px"><input name="GXGG2" id="GXGG2" class="easyui-validatebox" runat ="server" style="width:50px"/></td> 
        </tr>
		<tr>
            <td>长度</td>
			<td><input name="LENGTH" class="easyui-numberbox" min="0.1" max="100000000" precision="1"/></td>
            <td>注入介质</td>
			<td><input name="ZRFS" class="easyui-validatebox" /></td>
            <td>保温方式</td>
			<td><input name="BWFS" class="easyui-validatebox" /></td>  
        </tr>
		<tr>
            <td>地类</td>
			<td><input name="LANDTYPE" class="easyui-validatebox" /></td>
            <td>管线材质</td>
			<td><input name="GXCZ" class="easyui-validatebox" /></td>
		    <td>备注</td>
		    <td colspan=5><textarea name="BZ" style="height:50px;"></textarea></td>
		</tr>
        </table>
        <input type="hidden" value=""  id="userLevel"  runat="server"/>  
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
		      	
	</div>
</form>
  <script type="text/javascript">
      $(function () {       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑
          var userlevel = $('#userLevel').val();
          if (userlevel == "6" || userlevel == "2") {
              $("form :input").attr("readonly", "readonly"); //设置控件为只读
              $("form :input[type='file']").hide(); //隐藏上传文件窗口
              $("form a").hide(); //隐藏保存和撤销按钮    
          }
      }); 
    
   </script>
</body>
</html>

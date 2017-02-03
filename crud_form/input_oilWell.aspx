<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_oilWell.aspx.cs" Inherits="crud_form_input_oilWell" %>

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
			<td>计量间</td>
			<td><input name="JLJ" class="easyui-validatebox" /></td>
			<td>计量间投产日期</td>
			<td><input name="PRODUCTIONDATE" class="easyui-datebox" /></td>
        </tr>
		<tr>   
            <td>计量间结构</td>
			<td><input name="JLJJG" class="easyui-validatebox" /></td>
            <td>分离器型号</td>
			<td><input name="FLQXH" class="easyui-validatebox" /></td>
            <td>井式</td>
			<td><input name="WELLTYPE" class="easyui-validatebox" /></td>
        </tr>
		<tr>
            <td>空头</td>
			<td><input name="KT" class="easyui-validatebox" /></td>
            <td>井号</td>
			<td><input name="WNUMBER" class="easyui-validatebox" /></td>
            <td>集油管线长度</td>
			<td><input name="JYGXLENGTH" class="easyui-numberbox" min="0.1" max="100000000" precision="1"/></td>
            <td>集油管线规格  Ф</td>
			<td style="width:50px"><input name="JYGXGG1" id="JYGXGG1" class="easyui-validatebox" runat="server" style="width:50px"/></td>
            <td>×</td>
            <td style="width:100px"> <input name="JYGXGG2" id="JYGXGG2" class="easyui-validatebox" runat="server" style="width:50px"/></td>
        </tr>
		<tr>
            <td>管线投产日期</td>
			<td><input name="TCRQ" class="easyui-datebox" /></td>
            <td>挂接井号</td>
			<td><input name="GJJH" class="easyui-validatebox" /></td>
            <td>掺水管线长度</td>
			<td><input name="CSGXLENGTH" class="easyui-numberbox" min="0.1" max="100000000" precision="1"/></td>
            <td>掺水管线规格  Ф</td>
			<td style="width:50px"><input name="CSGXGG1" id="CSGXGG1" class="easyui-validatebox" runat="server" style="width:50px"/></td>
            <td>×</td>
            <td style="width:100px"><input name="CSGXGG2" id="CSGXGG2" class="easyui-validatebox" runat="server" style="width:50px"/></td>
        </tr>
		<tr>          
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
﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_heater.aspx.cs" Inherits="easyui_crud_demo_show_form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form method="post" runat="server">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <input name="DM" class="easyui-validatebox" type="hidden"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
		    <td>所属站名</td>
		    <td><input name="ZM" class="easyui-validatebox" /></td>
         </tr>
         <tr>
		    <td>加热炉用途</td>
		    <td><input name="JRLYT"  class="easyui-validatebox" /></td>
            <td>加热炉类型</td>
		    <td><input name="JRLLX" class="easyui-validatebox" /></td>
          </tr>
         <tr>
		    <td>加热炉名称</td>
		    <td><input name="JRLMC"  class="easyui-validatebox" /></td>
            <td>站内编号</td>
		    <td><input name="ZNBH" class="easyui-validatebox" /></td>
            <td>规格型号</td>
		    <td style="width :50px"><input name="GGXH1" id="GGXH1" class="easyui-validatebox"  runat="server" style="width :50px"/></td>
            <td>×</td>
            <td style="width :250px"><input name="GGXH2" id="GGXH2" class="easyui-validatebox" runat="server" style="width :50px"/></td>
          </tr>
          <tr>
            <td>功率</td>
		    <td><input name="JRLGL" class="easyui-validatebox" /></td>
		    <td>投产日期</td>
		    <td><input name="TCRQ"  class="easyui-datebox" /></td>
         </tr>
          <tr>
            <td>安全保护类型</td>
		    <td><input name="AQBHLX"  class="easyui-validatebox" /></td>
            <td>生产厂家</td>
		    <td><input name="SCCJ"  class="easyui-validatebox" /></td>
          </tr>
          <tr>
            <td>加热炉备注</td>
		    <td><input name="LUBZ"  class="easyui-validatebox" /></td>
         </tr>
         <tr>
            <td>燃烧器型号</td>
		    <td><input name="RSQXH"  class="easyui-validatebox" /></td>
            <td>燃烧器功率</td>
		    <td><input name="RSQGL" class="easyui-validatebox" /></td>
            </tr>
          <tr>
            <td>燃烧器厂家</td>
		    <td><input name="RSQCJ"  class="easyui-validatebox" /></td>
          </tr>
          <tr>
            <td>燃烧器备注</td>
		    <td><input name="RSQBZ" class="easyui-validatebox" /></td> 
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

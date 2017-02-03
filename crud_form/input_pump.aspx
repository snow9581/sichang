<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_pump.aspx.cs" Inherits="crud_form_input_pump" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <input name="DM" class="easyui-validatebox" type="hidden"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
		    <td>所属站名</td>
		    <td><input name="ZM" class="easyui-validatebox" /></td>
            </tr>
         <tr>
		    <td>泵名称</td>
		    <td><input name="BMC"  class="easyui-validatebox" /></td>         
            <td>泵设备编号</td>
		    <td><input name="BSBBH" class="easyui-validatebox" /></td>
		    <td>泵型号</td>
		    <td><input name="BXH"  class="easyui-validatebox" /></td>
             </tr>
          <tr>
            <td>泵设备能力</td>
		    <td><input name="BSBNL" class="easyui-validatebox" /></td>		 
            <td>泵投产日期</td>
		    <td><input name="BTCRQ"  class="easyui-datebox" /></td>
           <%-- <td>功率</td>
		    <td><input name="JRLGL" class="easyui-validatebox" /></td>--%>
             </tr>
          <tr>
            <td>泵扬程</td>
		    <td><input name="BYC"  class="easyui-validatebox" /></td>
            <td>泵运行状态</td>
		    <td><input name="BYXZT"  class="easyui-validatebox" /></td>
            <td>泵生产厂家</td>
		    <td><input name="SCCJ"  class="easyui-validatebox" /></td>
          </tr>
          <tr>           
            <td>泵备注</td>
		    <td><input name="BBZ"  class="easyui-validatebox" /></td>
         </tr>
         <tr>
            <td>电机型号</td>
		    <td><input name="DJXH"  class="easyui-validatebox" /></td>
            <td>电机功率</td>
		    <td><input name="DJGL" class="easyui-validatebox" /></td>
            <td>电机投产日期</td>
		    <td><input name="DJTCRQ"  class="easyui-datebox" /></td>
             </tr>
          <tr>
            <td>电机变频器编号</td>
		    <td><input name="DJBPQBH" class="easyui-validatebox" /></td> 
             <td>电机生产厂家</td>
		    <td><input name="DJSCCJ" class="easyui-validatebox" /></td> 
             <td>电机备注</td>
		    <td><input name="DJBZ" class="easyui-validatebox" /></td> 
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
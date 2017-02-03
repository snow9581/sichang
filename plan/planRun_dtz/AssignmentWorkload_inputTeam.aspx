<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignmentWorkload_inputTeam.aspx.cs" Inherits="plan_planRun_dtz_AssignmentWorkload_inputTeam" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value=""  id="hd_index"  runat="server"/>
  	<input type="hidden" value=""  id="hd_pid"  runat="server"/>
    <input type="hidden" value=""  id="userLevel"  runat="server"/>   
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px; text-align:left;">
		<tr>
			<td>接受者</td>
            <td><input id="RECEIVER_team" name="RECEIVER" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../tools/getDM.ashx'"/></td>
		</tr>
        <tr>
            <td class="mine">矿工作量</td>
			<td class="mine"><textarea id="MINECONTENT" name="MINECONTENT" rows="5" cols="50" readonly="readonly"></textarea></td>
            <td>小队工作内容</td>
			<td><textarea id="CONTENT" name="CONTENT" rows="5" cols="50"></textarea></td>
		</tr>
        <tr>
            <td>小队反馈信息</td>
            <td><textarea id="FEEDBACKINFORMATION" name="FEEDBACKINFORMATION" rows="5" cols="50"></textarea></td>
        </tr>
        </table>
        
	<div style="padding:5px 0;text-align:right;padding-right:30px">	      
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
	</div>
</form>
  <script type="text/javascript">
      $(function () {       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑S
          var userlevel = $('#userLevel').val();
          if (userlevel == "3")//地面队长
          {
              $(".mine").hide(); //隐藏矿工作量 
              document.getElementById("FEEDBACKINFORMATION").readOnly = true;
          } 
          else if (userlevel == "1")//小队
          {
              document.getElementById("CONTENT").readOnly = true;
              document.getElementById("MINECONTENT").readOnly = true;
              document.getElementById("RECEIVER_team").readOnly = true;
          }
          else {
              $("form :input,textarea").attr("readonly", "readonly"); //设置控件为只读
              $("form a").hide(); //隐藏保存和撤销按钮    
          }
      });
   </script>
</body>
</html>

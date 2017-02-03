<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignmentWorkload_inputMine.aspx.cs" Inherits="plan_planRun_dtz_AssignmentWorkload_input" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
 <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden"  id="hd_index"  runat="server"/>
  	<input type="hidden"  id="hd_pid"  runat="server"/>
    <input type="hidden"  id="userLevel"  runat="server"/>  
    <input type="hidden"  id="jurisdiction"  runat="server"/>  
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px; text-align:left;">
		<tr>
			<td>接受者</td>
			<td><input id="RECEIVER_mine" name="RECEIVER" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../tools/getKM.ashx'"/></td>
		</tr><tr>
            <td>矿工作量</td>
			<td><textarea  id="CONTENT" name="CONTENT" rows="5" cols="50"></textarea></td>
            <td>矿反馈信息</td>
            <td><textarea id="FEEDBACKINFORMATION" name="FEEDBACKINFORMATION" rows="5" cols="50"></textarea></td>
        </tr>
        </table>
        
	<div style="padding:5px 0;text-align:right;padding-right:30px">	      
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
	</div>
</form>
  <script type="text/javascript">
      $(function () {
          var jurisdiction = $('#jurisdiction').val();
          var userlevel = $('#userLevel').val();
          if (userlevel == "6" && jurisdiction == "1") //方案负责人或设计负责人
          {
              document.getElementById("FEEDBACKINFORMATION").readOnly = true;
          }
          else if (userlevel == "3") //地面队长
          {
              document.getElementById("CONTENT").readOnly = true;
              document.getElementById("RECEIVER_mine").readOnly = true;
          } else {
              $("form :input,textarea").attr("readonly", "readonly"); //设置控件为只读
              $("form a").hide(); //隐藏保存和撤销按钮    
          }

      });
   </script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="planReturn.aspx.cs" Inherits="plan_planRun_dtz_planReturn" %>
<!--方案负责人的方案被退回-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="重新提交方案"style="width:100%;padding:10px;height:100%">
    <form id="ff" method="post" action="planReturn.ashx"  enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_id"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:800px; margin-top :5px;" cellpadding="5" runat="server">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName" name="PName"  class="easyui-textbox" type="text" readonly="readonly" runat="server"/></td>
            <td style=" width:20px"></td>
			<td>项目来源</td>
			<td><input id="PSource" name="PSource" class="easyui-textbox" type="text" readonly="readonly" runat="server"/></td>
            <td style=" width:20px"></td>
			<td>估算投资</td>
			<td><input id="EstiInvestment" name="EstiInvestment" class="easyui-numberbox" min="0.01" max="100000000" precision="2" data-options="required:true" runat="server"/></td>
	    </tr>
		<tr><td>方案文档</td>
			<td><input name="DraftSolutionFile" class="easyui-validatebox textbox" type="file" style="width:170px" data-options="required:true"/></td>
		    <td></td>
            <td>审核意见</td>
			<td colspan="2"><input id="CHECKOPINION" name="CHECKOPINION" class="easyui-textbox" data-options="multiline:true" style="height:80px; width:200px" readonly="readonly" runat="server"/></td>
		</tr>
    </table>
    </form>
    <br />
        <div style="text-align:center;padding:5px">            
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div> 
</div>
<script type="text/javascript">
    $(function() {
        //设定table宽度自动适应窗口大小
        var w = document.body.clientWidth;
        var tw = $('#Table1').width();
        $("#Table1").css("marginLeft", parseInt((w - tw) / 2) + 'px');
       });

  function submitForm() {
      $("#save").removeAttr("onclick");                              
      $('#ff').form('submit',{
      success: function(data)
      {      
         if(data.toString()=='1')
            {
                self.location='show_planRun_dtz.aspx';
                parent.saveurl();
            } else if (data.toString() == "") {
                alert('登陆账号已过期，请重新登录！');
                window.top.location.href = '../../login.aspx';
            }
            else 
            {
                 $.messager.alert('提示框','提交失败');
            }             
      }
   });
}
    function clearForm() {
       $('#ff').form('clear');
    } 

    $.fn.datebox.defaults.formatter = function(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
    };
    $.fn.datebox.defaults.parser = function(s) {
        if (!s) return new Date();
        var ss = s.split('-');
        var y = parseInt(ss[0], 10);
        var m = parseInt(ss[1], 10);
        var d = parseInt(ss[2], 10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
            return new Date(y, m - 1, d);
        } else {
            return new Date();
        }
    };
    
 </script>
</body>
</html>


<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CheckPlanRun_dtz.aspx.cs" Inherits="plan_planRun_dtz_CheckPlanRun_dtz" %>
<!--主管所长审核项目-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="审核项目" style="width:100%;padding:10px;height:100%">
    <form id="ff" method="post" runat="server" action="CheckPlanRun_dtz.ashx" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_id"  runat="server"/>
    <input  type="hidden" id="WORDNAME" readonly="readonly" runat="server"/>
	<table id="Table1" style="width:640px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName" name="PName"  class="easyui-textbox" type="text" readonly="readonly" runat="server"/></td>
            <td style=" width:40px"></td>
			<td>项目来源</td>
			<td><input id="PSource" name="PSource" class="easyui-textbox" type="text" readonly="readonly" runat="server"/></td>
		</tr>
		<tr>
			<td>估算投资</td>
			<td><input id="EstiInvestment" name="EstiInvestment" class="easyui-numberbox" min="0.01" max="100000000" precision="2" readonly="readonly" runat="server"/></td>
            <td></td>   
            <td>方案文档（Word）:</td>                    
            <td>
            <div id="DG" runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:170px" onclick="downloadWord()">下载</div>
            </td>
		</tr>
		<tr>
            <td>是否同意：</td>                   
            <td><label><input name="LEADERCHECK" type="radio" value="0"/>拒绝(请在下面填写理由)</label> 
            <label><input name="LEADERCHECK" type="radio" value="1" checked="checked"/>同意 </label> 
            </td>                
        </tr>                
        <tr>                    
            <td>审批意见:</td>                    
            <td>
            <input name="CHECKOPINION" id="CHECKOPINION"  class="easyui-textbox" data-options="multiline:true" style="width:200px;height:60px" runat="server"/>
            </td>                
        </tr> 
    </table>
    </form>
<div style="text-align:center;padding:5px">            
<a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>  
</div>
</div>
        
<script type="text/javascript">
    $(function () {
        //设定table宽度自动适应窗口大小
        var w = document.body.clientWidth;
        var tw = $('#Table1').width();
        $("#Table1").css("marginLeft", parseInt((w - tw) / 2) + 'px');
       });
    function submitForm() {   
        $("#save").removeAttr("onclick");
        $('#ff').form('submit', {        
          success: function(data)
          {       
             if(data.toString()=='1')
                {
                    var strUrl = window.location.href;
                    var arrUrl = strUrl.split("/");
                    var strPage = arrUrl[arrUrl.length - 1].split("#");
                    var page = strPage[0];
                    self.location = page;
                    parent.saveurl();
                } else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../../login.aspx';
                } else 
                {
                     $.messager.alert('提示框','审核提交失败');
                }             
          }
          });
     }
    
    function clearForm() {
        $('#ff').form('clear');
    }  
     function downloadWord() {
         var wordname = document.getElementById("WORDNAME").value;
         var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname+"&package=ftp_planfile";
         self.location.href = url;
     }   
</script>
</body>
</html>

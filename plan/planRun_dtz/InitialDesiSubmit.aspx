<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InitialDesiSubmit.aspx.cs" Inherits="plan_planRun_dtz_InitialDesiSubmit" %>
<!--综合室主任纪录初设上报时间-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script> 
</head>
<body>
<div id="p" class="easyui-panel" title="初设上报" style="width:100%;padding:10px;height:100%">  
    <form id="ff" method="post" action="InitialDesiSubmit.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
    <input value="1" type="hidden" id="hd_planflag"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:560px; margin-top :5px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			<td style="width:50px"></td>
			<td class ="num">项目号</td>
			<td class ="num"><input id="PNumber"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
		</tr>
		<tr>
			<td>概算文档</td>
			<td><div id="Div2" runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer; width:160px" onclick="downloadWord('DraftBudgetFile')">下载</div></td>
			<td><input  type="hidden" id="DraftBudgetFile" style="width:100%"  runat="server"/> </td>
			<td>初设上报时间</td>
            <td><input name="InitialDesiSubmitDate_R" id="InitialDesiSubmitDate_R" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser,required:true"/></td>
		</tr>
        <tr>
            <td>备注</td>
            <td><textarea  rows="3" cols="20" id="Remark" name="Remark" class="easyui-textbox" data-options="multiline:true" style="width:160px;height:80px"  runat="server"></textarea></td>
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
        if ($('#hd_planflag').val() == '1') {
            $('.num').remove();
        }
     });
    function submitForm() {
      $("#save").removeAttr("onclick");                          
      $('#ff').form('submit',{
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
    function downloadWord(file) {
               var wordname = document.getElementById(file).value;
               var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname+"&package=ftp_planfile";
               self.location.href = url;
           }
    </script> 
</body>
</html>

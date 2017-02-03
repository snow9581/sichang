<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkloadFile.aspx.cs" Inherits="plan_planRun_dtz_WorkloadFile" %>
<!--项目设计负责人提交工程量文档-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="工程量提交" style="width:100%;padding:10px;height:100%">
    <form id="ff" method="post" action="WorkloadFile.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
    <input value="1" type="hidden" id="planflag"  runat="server"/>
    <input value="" type="hidden" id="hd_WorkloadFile"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:600px; margin-top :5px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
            <td style="width:50px"></td>
            <td class="PNumber">项目号</td>
			<td class="PNumber"><input id="PNumber"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
        </tr>
        <tr> 
            <td class="finish">已提交的工程量</td>
            <td class="finish"><div runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;"  onclick="downloadWord()">下载</div></td>
            <td class="finish"></td>
            <td><span class="finish">重新</span>提交工程量</td>
            <td><input id="W_FILE" name="W_FILE" class="easyui-validatebox textbox" type="file" style="width:150px;" runat ="server"/></td>
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
        if ($('#planflag').val() == '1')
            $('.PNumber').hide();
        if ($("#hd_WorkloadFile").val() == "")
            $('.finish').hide();
        if ($('#planflag').val() == '1' && $("#hd_WorkloadFile").val() == "")
            $("#Table1").css("width", "300px");
        //设定table宽度自动适应窗口大小
        var w = document.body.clientWidth;
        var tw = $('#Table1').width();
        $("#Table1").css("marginLeft", parseInt((w - tw) / 2) + 'px');
    });
    function downloadWord() {
        var wordname = document.getElementById("hd_WorkloadFile").value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
        self.location.href = url;
    }    
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
    </script> 
</body>
</html>

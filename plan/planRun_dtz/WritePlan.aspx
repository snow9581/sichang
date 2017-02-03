<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WritePlan.aspx.cs" Inherits="plan_planRun_dtz_WritePlan" %>
<!--方案负责人估算设计-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="估算设计" style="width:100%;padding:10px;height:100%">
    <form id="ff" method="post" action="writePlan.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
    <input value="1" type="hidden" id="H_PName"  runat="server"/>
    <input value="1"  type="hidden" id="H_PSource"  runat="server"/>
    <input value=""  type="hidden" id="hd_DraftSolutionFile"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:650px; margin-top :20px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" readonly="readonly" style="height:20px"/></td>
            <td style="width:30px"></td>
			<td>项目来源</td>
			<td><input id="PSource" class="easyui-validatebox textbox" type="text" readonly="readonly" style="height:20px"/></td>
        </tr>
        <tr>
			<td>估算投资</td>
			<td><input id="EstiInvestment" name="EstiInvestment" class="easyui-numberbox" min="0.01" max="100000000" precision="2" data-options="required:true" runat="server" /></td>
			<td style="width:30px"></td>
            <td>方案文档</td>
			<td><input id="DraftSolutionFile" name="DraftSolutionFile" class="easyui-validatebox textbox" type="file" style="width:170px" runat ="server"/>
            <div id="Div1"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('hd_DraftSolutionFile')">下载</div></td>
            <td style="width:30px"></td>
            <td class="R_DraftSolutionFile"  style="display:none">重新上传方案文档</td>
            <td class="R_DraftSolutionFile" style="display:none"><input type="file" id="renewDraftSolutionFile" name="renewDraftSolutionFile" class="easyui-validatebox textbox" style=" width:150px"/></td>
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
    $(function () {
        //设定table宽度自动适应窗口大小
        var w = document.body.clientWidth;
        var tw = $('#Table1').width();
        $("#Table1").css("marginLeft", parseInt((w - tw) / 2) + 'px');

        var vPName = document.getElementById("H_PName").value;
        var vPSource = document.getElementById("H_PSource").value;
        $('#PName').val(vPName);
        $('#PSource').val(vPSource);
        if ($("#hd_DraftSolutionFile").val() != "#" && $("#hd_DraftSolutionFile").val() != "") {
            document.getElementById("Div1").style.display = "block";
            document.getElementById("DraftSolutionFile").style.display = "none";
            $(".R_DraftSolutionFile").show();
        }
    });
    function downloadWord(name) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
        self.location.href = url;
    }
    function submitForm() {
        $("#save").removeAttr("onclick");
        $('#ff').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
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
                else {
                    $.messager.alert('提示框', '计划提交失败');
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

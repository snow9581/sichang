<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BudgetAdjust.aspx.cs" Inherits="plan_planRun_dtz_BudgetAdjust" %>
<!--综合室主任进行概算调整-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="概算调整" style="width:100%;padding:10px;height:100%">
    <form id="ff" method="post" action="BudgetAdjust.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
    <input value="" type="hidden" id="planflag"  runat="server"/>
    <input value="" type="hidden" id="hd_FinalBudgetFile"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:580px; margin-top :5px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			<td style="width:50px"></td>
			<td class="PNumber">项目号</td>
			<td class="PNumber"><input id="PNumber"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
        </tr>
        <tr>       
            <td>设计批复</td>
	        <td><div id="Div1" runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer; width:170px" onclick="downloadWord('DESIAPPRFILE','archives')">下载</div></td>
            <td><input  type="hidden" value="" id="DESIAPPRFILE" runat="server"/></td>    
            <td>调整后概算</td>
			<td><input id="FinalBudgetFile" name="FinalBudgetFile" class="easyui-validatebox textbox" type="file" style="width:170px" runat ="server"/>
            <div id="Div2"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('hd_FinalBudgetFile','archives')">下载</div></td>
		</tr>
        <tr>
            <td class="R_FinalBudgetFile"  style="display:none">重新提交调整后概算</td>
            <td class="R_FinalBudgetFile" style="display:none"><input type="file" id="renewFinalBudgetFile" name="renewFinalBudgetFile" class="easyui-validatebox textbox" style=" width:150px"/></td>
            <td class="R_FinalBudgetFile" style="display:none"></td>
            <td>备注</td>
            <td><textarea  rows="3" cols="20" id="Remark" name="Remark" class="easyui-textbox" data-options="multiline:true" style="width:100%;height:80px"  runat="server"></textarea></td>
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

        if ($('#planflag').val() == '1')
            $('.PNumber').css('visibility', 'hidden');
        if ($("#hd_FinalBudgetFile").val() != "#" && $("#hd_FinalBudgetFile").val() != "") {
            document.getElementById("Div2").style.display = "block";
            document.getElementById("FinalBudgetFile").style.display = "none";
            $(".R_FinalBudgetFile").show();
        }
    });
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
                    $.messager.alert('提示框', '提交失败');
                }
            }
        });
    }
    function clearForm() {
       $('#ff').form('clear');
    }
    function downloadWord(name, package) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=" + package;
        self.location.href = url;
    }
    </script> 
</body>
</html>

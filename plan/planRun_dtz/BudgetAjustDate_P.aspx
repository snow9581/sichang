<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BudgetAjustDate_P.aspx.cs" Inherits="plan_planRun_dtz_BudgetAjustDate_P" %>
<!--综合室主任确定概算计划调整时间-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="调整时间" style="width:100%;padding:10px;height:100%">
    <form id="ff" method="post" action="BudgetAjustDate_P.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
    <input value="" type="hidden" id="planflag"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:620px; margin-top :5px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			<td style="width:50px"></td>
            <td class="PNumber">项目号</td>
			<td class="PNumber"><input id="PNumber"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>   
            <td></td>
        </tr>
        <tr>
            <td>概算计划调整时间</td>
			<td><input name="BUDGETADJUSTDATE_P" id="BUDGETADJUSTDATE_P" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser,required:true" /></td>
            <td></td>
            <td>备注</td>
            <td colspan="2"><textarea  rows="3" cols="20" id="Remark" name="Remark" class="easyui-textbox" data-options="multiline:true" style="width:100%;height:80px"  runat="server"></textarea></td>
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

        if ($('#planflag').val() == '1')
            $('.PNumber').css('visibility', 'hidden');
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
    function myformatter(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();

        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
    }
    function myparser(s) {
        if (!s)
            return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0], 10);
        var m = parseInt(ss[1], 10);
        var d = parseInt(ss[2], 10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
            return new Date(y, m - 1, d);
        } else {
            return new Date();
        }
    }  
    </script> 
</body>
</html>

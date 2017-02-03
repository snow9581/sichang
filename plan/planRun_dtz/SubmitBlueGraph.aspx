<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubmitBlueGraph.aspx.cs" Inherits="plan_planRun_dtz_SubmitBlueGraph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="提交蓝图" style="width:100%;height:100%;">
    <form id="ff" method="post" action="SubmitBlueGraph.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="planDesigner"  runat="server"/>
    <input value="" type="hidden" id="planflag"  runat="server"/>
    <input value="" type="hidden" id="hd_BlueGraph"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:550px; margin-top :5px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName" name="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>

            <td  class="PNumber">项目号</td>
			<td  class="PNumber"><input id="PNumber" name="PNumber" class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>   
        </tr>
        <tr>
            <td class="finish">已提交的蓝图</td>
			<td class="finish"><div runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:160px;" onclick="downloadWord('hd_BlueGraph')">下载</div></td>

            <td><span class="finish">重新</span>上传蓝图</td>
            <td><input type="file"  id="B_FILE" name="B_FILE" class="easyui-validatebox textbox" style=" width:150px"/></td>
        </tr>
        <tr>
            <td>备注</td>
            <td><textarea  rows="2" cols="20" id="B_BZ" name="B_BZ" class="easyui-textbox" data-options="multiline:true" style="width:160px;height:80px"  runat="server"></textarea></td>
         </tr>
    </table>
    <br />
        <div style="text-align:center;padding:5px">            
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div>    
    </form>
    
</div>
<script type="text/javascript">
    $(function () {
        if ($('#planflag').val() == '1')
            $('.PNumber').hide();
        if ($("#hd_BlueGraph").val() == "")
            $('.finish').hide();
        if ($('#planflag').val() == '1' && $("#hd_BlueGraph").val() == "")
            $("#Table1").css("width", "250px");
        //设定table宽度自动适应窗口大小
        var w = document.body.clientWidth;
        var tw = $('#Table1').width();
        $("#Table1").css("marginLeft", parseInt((w - tw) / 2) + 'px');
    });
    function downloadWord(name) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=archives";
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
                    $.messager.alert('提示框', '提交失败');
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

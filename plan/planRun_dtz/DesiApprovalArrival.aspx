<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DesiApprovalArrival.aspx.cs" Inherits="plan_planRun_dtz_DesiApprovalArrival" %>
<!--设计室主任上传设计批复-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="设计批复下达" style="width:100%;padding:10px;height:100%"> 
    <form id="ff" method="post" action="DesiApprovalArrival.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
    <input value="1" type="hidden" id="hd_planflag"  runat="server"/>
    <input value="1" type="hidden" id="hd_DesiApprFile"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:580px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			<td style="width:60px"></td>
            <td class ="num">项目号</td>
			<td class ="num"><input id="PNumber"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
        </tr>
        <tr>
            <td>下达文件号</td>
			<td><input id="DESIAPPROVALARRIVALFILENUMBER" name="DESIAPPROVALARRIVALFILENUMBER" runat="server" class="easyui-validatebox textbox" type="text" style="height:20px"/></td>
			<td></td>
            <td>批准日期</td>
			<td><input name="DESIAPPROVALARRIVALDATE" id="DESIAPPROVALARRIVALDATE" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser" /></td>
        </tr>
        <tr>
            <td>设计批复文档</td>
			<td><input id="DesiApprFile" name="DesiApprFile" class="easyui-validatebox textbox" type="file" style="width:150px" runat ="server"/>
            <div id="Div2"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('hd_DesiApprFile','archives')">下载</div></td>
            <td class="R_DesiApprFile" style="display:none"></td>
            <td class="R_DesiApprFile"  style="display:none">重新提交设计批复</td>
            <td class="R_DesiApprFile" style="display:none"><input type="file" id="renewDesiApprFile" name="renewDesiApprFile" class="easyui-validatebox textbox" style=" width:150px"/></td>
        </tr>
        <tr>
            <td>备注</td>
            <td colspan="2"><textarea  rows="3" cols="20" id="Remark" name="Remark" class="easyui-textbox" data-options="multiline:true" style="width:220px;height:70px"  runat="server"></textarea></td>
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
        if ($("#hd_DesiApprFile").val() != "#" && $("#hd_DesiApprFile").val() != "") {
            document.getElementById("Div2").style.display = "block";
            document.getElementById("DesiApprFile").style.display = "none";
            $(".R_DesiApprFile").show();
        }
    });
    function downloadWord(name, package) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=" + package;
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
     function myformatter(date) {
          var y = date.getFullYear();
          var m = date.getMonth() + 1;
          var d = date.getDate();
         
          return y + '-' + (m < 10 ? ('0' + m) : m) + '-'+ (d < 10 ? ('0' + d) : d);
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

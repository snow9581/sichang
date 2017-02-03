<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlueGraphArrival.aspx.cs" Inherits="plan_planRun_dtz_BlueGraphArrival" %>
<%--记录蓝图下发时间--%>
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
   <div id="p" class="easyui-panel" title="下发蓝图" style="width:100%;padding:10px;">
  <div style="padding:10px 300px 20px 300px">  
    <form id="ff" method="post" action="BlueGraphArrival.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:100%; margin-top :5px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
            <td style=" width:30px"></td>
            <td>项目号</td>
			<td><input id="PNumber"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
        </tr>
        <tr>
            <td>蓝图</td>
			<td><div runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer; width:180px" onclick="downloadWord()">下载</div>
            <input value="1" type="hidden" id="BLUEGRAPHFIL"  runat="server"/></td>
            
        </tr>

    </table>
    </form>
        <br/>
        <div style="text-align:center;padding:5px">            
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">下发蓝图</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div>
        <br />  
        </div>  
</div>
<script type="text/javascript">
   
    function submitForm() {
        $("#save").removeAttr("onclick");
        $('#ff').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
                    self.location = 'show_planrun_bdtz.aspx';
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
    function downloadWord() {
        var wordname = document.getElementById("BLUEGRAPHFIL").value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=archives";
        self.location.href = url;
    }
    </script> 
</body>
</html>

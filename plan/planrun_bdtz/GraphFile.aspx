<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GraphFile.aspx.cs" Inherits="plan_planRun_bdtz_GraphFile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script> 
</head>
<body>
<div id="p" class="easyui-panel" title="上传蓝图文档" style="width:100%;padding:10px;">
  <div style="padding:10px 40px 20px 40px">  
    <form id="ff" method="post" action="GraphFile.ashx" enctype="multipart/form-data">
   <input value="1" type="hidden" id="hd_id"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:100%; margin-top :5px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName" name="PName" class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			<td style="width:40px"></td>
			<td>项目号</td>
			<td><input id="PNumber" name="PNumber" class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			<td style="width:40px"></td>
            <td>项目方案负责人</td>
			<td><input id="SOLUCHIEF" name="SOLUCHIEF" class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			<td style="width:40px"></td>
		</tr>
        <tr>
          <td>初设文档下载</td>
			<td><div id="Div3" runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer; width:180px" onclick="downloadWord('WorkloadFile')">下载</div></td>
			<td><input  type="hidden" id="WorkloadFile" style="width:100%"  runat="server"/> </td>
			<td>蓝图文档</td>
			<td><input type="file"  id="BLUEGRAPHFIL" name="BLUEGRAPHFIL" class="easyui-validatebox textbox" runat="server" data-options="required:true"/></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			
		</tr>

    </table>
    </form>
  		<br/>
        <div style="text-align:center;padding:5px">            
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div>   
        </div>  
</div>
<script type="text/javascript">

    function submitForm() {
        $("#save").removeAttr("onclick");
        $('#ff').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
                    self.location = 'show_planRun_bdtz.aspx';
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
    function downloadWord(file) {
        var wordname = document.getElementById(file).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=archives";
        self.location.href = url;
    }
    </script> 
</body>
</html>

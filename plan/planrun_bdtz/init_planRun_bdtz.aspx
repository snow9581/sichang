<%@ Page Language="C#" AutoEventWireup="true" CodeFile="init_planRun_bdtz.aspx.cs" Inherits="plan_planrun_bdtz_init_planRun_bdtz" %>
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
 <div id="p" class="easyui-panel" title="新建项目" style="width:100%;padding:10px;" >
 <div style="padding:10px 100px 20px 100px">  
	<form id="ff" method="post" action="init_planRun_bdtz.ashx" enctype="multipart/form-data" style="text-align: center">
    <table id="Table1" style="width:100%;  margin-top :5px;" cellpadding="5" runat="server">
		<tr>
		    <td>项目名称</td>
			<td><input name="PName" class="easyui-textbox" type="text" data-options="required:true"/></td>
            <td style=" width:50px"></td>
			<td>项目方案负责人</td>
            <td><input name="SoluChief" class="easyui-textbox" type="text" data-options="required:true"/></td>
			<%--<td><input name="SoluChief" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../plan/getOfficeStaff/get_planOfficeStaff.ashx',required:true"/></td>--%>
            <td style=" width:50px"></td>
            <td>项目号</td>
			<td><input name="PNUMBER" class="easyui-textbox"  data-options="required:true"/></td>
		</tr>
    </table>
    </form>
    <br />
    <br />
        <div style="text-align:center;padding:5px">            
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div> 
        <br />
        <br />
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
                    $.messager.alert('提示框', '计划运行失败');
                }
            }
        });
    }
    </script>

</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_share.aspx.cs" Inherits="crud_form_input_share" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
    <link href="../themes/default/textbox.css" rel="stylesheet" />
    <link href="../themes/color.css" rel="stylesheet" />
</head>
<body>
    <script>
        $(function Bind() {
            var xz_project = $('#SH_PROJECT').combobox({
                valueField: 'text', //值字段
                textField: 'text', //显示的字段
                url: '../tools/get_new_lan.ashx',
                editable: true,
                onChange: function (newValue, oldValue) {
                    $.get('../tools/get_new_lan.ashx', { ZYQ: newValue },'json');
                }
            });
            var name = $('#xz_project').combobox('getValue');
            //alert(name);            
        })
        var userlevel = $('#userlevel').val();
        if (userlevel != 2) {
            $('#save').remove();
        }
    </script>
    <form id="for_tb" method="post" runat="server" enctype="multipart/form-data">
        <input type="hidden" value="1"  id="hd_index"  runat="server"/>
        <input type="hidden" value="1"  id="hd_ID" runat="server" />
        <input type="hidden" id="userlevel" runat="server" />
        <table>
            <tr>
                <td>名称</td>
                <td><input name="SH_NAME"  class="easyui-textbox" /></td>
                <td>栏目</td>
                <td><input id="SH_PROJECT" name="SH_PROJECT" class="easyui-combobox" runat="server" data-options="required:true"  /></td>
                <td>简介</td>
                <td><input name="SH_INFOR"  class="easyui-textbox" /></td>
            </tr>
            <tr>
                <td>作者</td>
                <td><input name="SH_AUTHOR"  class="easyui-textbox" /></td>
                <td>上传者</td>
                <td><input name="SH_CHAIRMAN"  class="easyui-textbox" /></td>
                <td>上传日期</td>            
                <td><input name="SH_DATE" class="easyui-datebox" data-options="sharedCalendar:'#cc'"  /></td>
            </tr>
            <tr>
                <td>共享文档</td>
			    <td><input type="file" id="FILES" name="FILES" class="easyui-validatebox" /></td>			
		        <td><input type="hidden" name="ARCHIVES" class="easyui-validatebox" /></td>
            </tr>
        </table>
        <div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>	
	</div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_NewLan.aspx.cs" Inherits="crud_form_input_NewLan" %>

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
    <form id="for_tb">
        <input type="hidden" value="1"  id="hd_index"  runat="server"/>
        <input type="hidden" value="1"  id="hd_ID" runat="server" />
        <table>
            <tr>                
                <td>栏目</td>
                <td><input name="LANMU"  class="easyui-textbox" /></td>
            </tr>
        </table>
        <div style="padding:5px 0;text-align:right;padding-right:30px">        
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>	
	</div>
    </form>
</body>
</html>

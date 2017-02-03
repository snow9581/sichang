<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_Repair.aspx.cs" Inherits="ybManage_repair_input_Repair" %>

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
    <input type="hidden" value="1"  id="hd_state"  runat="server"/>
    <input type="hidden" value=""  id="azwz1"  runat="server"/>
    <input type="hidden" value=""  id="yqybmc1"  runat="server"/>
    <input type="hidden" value=""  id="ggxh1"  runat="server"/>
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>单位：</td>
			<td><input id="DW" class="easyui-validatebox" name="DW" runat="server" disabled="disabled" type="text"/></td>
			<td>维修类型</td>
			<td><input id="WXLB" runat="server" class="easyui-validatebox" name="WXLX"/></td>
            <td>安装位置</td>
			<td>
                <input id="AZWZ" runat="server"/>
            </td>
        </tr>
        <tr>
            <td>仪器仪表名称</td>
			<td>
                <input id="YQYBMC" runat="server"/>
            </td>
            <td>规格型号</td>
			<td>
                <input id="GGXH" runat="server"/>
            </td>
            <td>日期</td>
			<td><input id="RQ" name="RQ" runat="server" class="easyui-datebox"/></td>
        </tr>
        <tr>
        <td>故障现象</td>
        <td>
            <asp:TextBox ID="TextBox1" runat="server" Rows="4" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
        <td><label id="SHR" runat="server">审核人：</label></td>
        <td></td>
        <td><label id="SPR" runat="server">审批人：</label></td>
        </tr>
        </table>                                                    
	<div style="padding:5px 0;text-align:right;padding-right:30px">	      	
	    <asp:Label ID="Label1" runat="server" Text="指定维修人：" Visible="False"></asp:Label>
        <input id="WXR" runat="server" visible="false"/>
        <button id="Record" runat="server" onclick="Record2()" visible="false">填单</button> 
	    <asp:Button ID="Button1" runat="server" Text="清空" onclick="Button1_Click" />
	    <asp:Button ID="Button2" runat="server" Text="提交" onclick="Button2_Click" />
        <asp:Button ID="Button3" runat="server" Text="关闭" onclick="Button3_Click" />
	</div>
    </form>
    <script type="text/javascript">
        $(function () {
            $('#AZWZ').combobox({
                valueField: 'text',
                textField: 'text',
                url: 'get_AZWZ.ashx',
                onSelect: function (rec) {
                    var url = "get_YQYBMC.ashx?AZWZ='" + rec.text + "'";
                    $('#YQYBMC').combobox('reload', url);
                }
            });
            $('#YQYBMC').combobox({
                valueField: 'text',
                textField: 'text',
                url: 'get_YQYBMC.ashx',
                onSelect: function (rec) {
                    var url = "get_GGXH.ashx?YQYBMC='" + rec.text + "'&AZWZ='" + $('#AZWZ').combobox('getValue') + "'";
                    $('#GGXH').combobox('reload', url);
                }
            });
            $('#GGXH').combobox({
                valueField: 'text',
                textField: 'text',
                url: 'get_GGXH.ashx'
            });
            $('#WXR').combobox({
                valueField: 'text',
                textField: 'text',
                url: 'get_WXR.ashx'
            });
            if ($("#azwz1").val() != "")
                $("#AZWZ").combobox('setValue', $("#azwz1").val());
            if ($("#yqybmc1").val() != "")
                $("#YQYBMC").combobox('setValue', $("#yqybmc1").val());
            if ($("#ggxh1").val() != "")
                $("#GGXH").combobox('setValue', $("#ggxh1").val());
        });
      </script> 
</body>
</html>
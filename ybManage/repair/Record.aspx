<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Record.aspx.cs" Inherits="ybManage_repair_Record" %>

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
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <table class="dv-table" runat="server" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>单位：</td>
			<td><input id="DW" class="easyui-validatebox" name="DW" runat="server"  type="text"/></td>
			<td>仪器仪表名称：</td>
			<td><input id="YQYBMC" class="easyui-validatebox" name="YQYBMC" runat="server"  type="text"/></td>
            <td>规格型号：</td>
			<td><input id="GGXH" class="easyui-validatebox" name="GGXH" runat="server"  type="text"/></td>
        </tr>
        <tr>
            <td>安装岗位：</td>
			<td><input id="AZWZ" class="easyui-validatebox" name="AZWZ" runat="server"  type="text"/></td>
            <td>仪器仪表编号：</td>
			<td><input id="BH" class="easyui-validatebox" name="BH" runat="server"  type="text"/></td>
            <td>维修类别：</td>
			<td><input id="WXLB" class="easyui-validatebox" name="WXLB" runat="server"  type="text"/></td>
        </tr>
        <tr>
        <td>故障现象</td>
        <td colspan="5" runat="server">
            <asp:TextBox ID="GZXX" runat="server" Rows="2" TextMode="MultiLine" 
               Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
        <td>维修内容</td>
        <td colspan="5">
            <asp:TextBox ID="WXNR" runat="server" Rows="2" TextMode="MultiLine" 
                Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
        <td>配件应用情况</td>
        <td colspan="5">
            <asp:TextBox ID="PJYYQK" runat="server" Rows="2" TextMode="MultiLine" 
                Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
        <td>维修结果</td>
        <td colspan="5">
            <asp:TextBox ID="WXJG" runat="server" Rows="2" TextMode="MultiLine" 
                Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
			<td>维修单位：</td>
			<td><input id="WXDW" class="easyui-validatebox" name="WXDW" runat="server"  type="text"/></td>
			<td>维修人签字：</td>
			<td><input id="WXR2" class="easyui-validatebox" name="WXR2" runat="server"  type="text"/></td>
            <td>生产单位签字：</td>
			<td><input id="JSY" class="easyui-validatebox" name="JSY" runat="server"  type="text"/></td>
        </tr>
        </table>
        <div style="padding:5px 0;text-align:right;padding-right:30px">	
        <label>维修时间：</label>      	
        <input id="RQ" name="RQ" runat="server" class="easyui-datebox"/>
	    <asp:Button ID="Button1" runat="server" Text="提交" onclick="Button1_Click" />
        <asp:Button ID="Button3" runat="server" Text="报废" onclick="Button3_Click" />
        <asp:Button ID="Button2" runat="server" Text="关闭" onclick="Button2_Click" />
	</div>
    </form>                                                 
</body>
</html>

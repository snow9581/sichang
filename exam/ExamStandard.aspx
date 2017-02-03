<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExamStandard.aspx.cs" Inherits="exam_ExamStandard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>

</head>
<body>
    <form id="FStandard" method="post" runat="server" action="ExamStandard.ashx">
    <input type="hidden" id="Standard" runat="server"/>
	<table style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
    <tr>
    <td class="title" colspan="3">选择题</td>
    </tr>
		<tr>
            <td><span>难题：</span></td>
            <td><input class="easyui-textbox" id="X_dif" style=" width:50px" runat="server"/>道</td>
            <td style=" width:50px"></td>
            <td>中等题：</td>
			<td><input class="easyui-textbox" id="X_med" style=" width:50px" runat="server"/>道</td>
            <td style=" width:50px"></td>
            <td>简单题：</td>
            <td><input class="easyui-textbox" id="X_easy" style=" width:50px" runat="server"/>道</td>
        </tr>
        <tr>
			<td>每题：</td>
            <td><input class="easyui-textbox" id="X_score" style=" width:50px" runat="server"/>分</td>
		</tr>
    <tr>
    <td class="title" colspan="3">判断题</td>
    </tr>
        <tr>
            <td><span>难题：</span></td>
            <td><input class="easyui-textbox" id="P_dif" style=" width:50px" runat="server"/>道</td>
            <td style=" width:50px"></td>
            <td>中等题：</td>
			<td><input class="easyui-textbox" id="P_med" style=" width:50px" runat="server"/>道</td>
            <td style=" width:50px"></td>
            <td>简单题：</td>
            <td><input class="easyui-textbox" id="P_easy" style=" width:50px" runat="server"/>道</td>
        </tr>
        <tr>
			<td>每题：</td>
            <td><input class="easyui-textbox" id="P_score" style=" width:50px" runat="server"/>分</td>
		</tr>
        <tr>
            <td>考试时长：</td>
            <td><input class="easyui-textbox" id="TIME" style=" width:50px" runat="server"/>分钟</td>
            <td style=" width:50px"></td>
            <td>开始时间：</td>
			<td><input class="easyui-datebox" id="STARTDATE" style=" width:100px" runat="server"/></td>
            <td style=" width:50px"></td>
            <td>结束时间：</td>
            <td><input class="easyui-datebox" id="ENDDATE" style=" width:100px" runat="server"/></td>
        </tr>
        <tr>
            <td class="title" colspan="5">总分：<asp:Label ID="totalScore" runat="server" Text="0"></asp:Label>分</td>
        </tr>
        </table>
    </form>
    <script type="text/javascript">
        $.fn.datebox.defaults.formatter = function (date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
        };
        $.fn.datebox.defaults.parser = function (s) {
            if (!s) return new Date();
            var ss = s.split('-');
            var y = parseInt(ss[0], 10);
            var m = parseInt(ss[1], 10);
            var d = parseInt(ss[2], 10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                return new Date(y, m - 1, d);
            } else {
                return new Date();
            }
        };
 </script>
</body>
</html>

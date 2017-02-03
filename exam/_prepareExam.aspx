<%@ Page Language="C#" AutoEventWireup="true" CodeFile="_prepareExam.aspx.cs" Inherits="exam_prepareExam" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <style type="text/css">
        #startExam
        {
            text-align: center;
        }
        .style1
        {
            text-align: center;
        }
        tr
        {
            height:40px;
        }
    </style>
</head>
<body>
<input id="HDvisible" type="hidden" runat="server" />
    <form id="form1" runat="server">
    <div id="Meg">
    <table style="width:18%;" align="center">
    <tr>
        <td>考生姓名：</td>
        <td><asp:Label ID="username" runat="server" Text=""></asp:Label> </td>
    </tr>
    <tr>
        <td>专业：</td>
        <td><asp:Label ID="major" runat="server" Text=""></asp:Label> </td>
    </tr>
    <tr>
        <td>总分：</td>
        <td><asp:Label ID="totalScore" runat="server" Text=""></asp:Label>分</td>
    </tr>
    <tr>
        <td>选择题：</td>
        <td><asp:Label ID="CountX" runat="server" Text=""></asp:Label>道
        <asp:Label ID="ScoreX" runat="server" Text=""></asp:Label>分/题</td>
    </tr>
    <tr>
        <td>判断题：</td>
        <td><asp:Label ID="CountP" runat="server" Text=""></asp:Label>道
        <asp:Label ID="ScoreP" runat="server" Text=""></asp:Label>分/题</td>
    </tr>
    <tr>
        <td>考试时长：</td>
        <td><asp:Label ID="time" runat="server" Text=""></asp:Label>分钟</td>
    </tr>
    <tr>
        <td>考试开始时间：</td>
        <td><asp:Label ID="startTime" runat="server" Text=""></asp:Label> </td>
    </tr>
    <tr>
        <td>考试截止时间：</td>
        <td><asp:Label ID="endTime" runat="server" Text=""></asp:Label> </td>
    </tr>
    </table>
        <div class="style1">
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="startExam" onclick="exam()">开始考试</a>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        $(function () {
            if ($('#HDvisible').val() != "1") {
                $('#startExam').remove();
                alert($('#HDvisible').val());
            }
        })
        function exam() {
            self.location = "_examination.aspx?scoreX=" + $('#ScoreX').text() + "&scoreP=" + $('#ScoreP').text() + "&time=" + $('#time').text();
        }
    </script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="alterPsw.aspx.cs" Inherits="Manage_AlterPsw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>修改密码</title>
</head>
<body>
    <form id="form1" runat="server">
    <center>
      
        <asp:Panel ID="Panel1" runat="server" GroupingText="修改密码" style="width:350px;margin-top:150px;">
        <div style="padding:12px">
         
            <asp:Label  runat="server" Text="原密码："></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label  runat="server" Text="新密码："></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label runat="server" Text="确认新密码："></asp:Label>
            &nbsp;<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Text="修改" Width="70px" onclick="Button1_Click"/>     
        
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="关闭"   Width="70px" />
           
        
         
        
        </div>
        
        </asp:Panel>
    </center>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>用户登录</title>
<style type="text/css">

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(images/login_01.gif);
	overflow:hidden;
}
.STYLE3 {font-size: 12px; color: #FFFFFF; }
.STYLE4 {
	color: #FFFFFF;
	font-family: "方正大黑简体";
	font-size: 50px;
}

</style></head>

<body>
 <form id="form1" runat="server">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td background="images/login_03.gif">&nbsp;</td>
        <td width="876"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="299" valign="top" background="images/login_01.jpg">&nbsp;</td>
          </tr>
          <tr>
            <td height="54"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="394" height="69" background="images/login_02.jpg">&nbsp;</td>
                <td width="199" background="images/login_03.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="22%" height="22"><div align="center"><span class="STYLE3">用户名</span></div></td>
                    <td width="51%" height="22">
                     <asp:TextBox ID="TextBox1" runat="server" size="12" 
                            style="height:20px;background-color:#032e49; color:#88b5d1; border:solid 1px #88b5d1;" 
                            Width="96px"></asp:TextBox>
                   </td>
                    <td width="27%" height="22">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="22" valign="middle"><div align="center"><span class="STYLE3">密&nbsp; 码</span></div></td>
                    <td height="22" valign="bottom">
                  <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" size="13" 
                            style="height:20px;background-color:#032e49; color:#88b5d1; border:solid 1px #88b5d1;" 
                            Width="96px"></asp:TextBox>
                    
                    </td>
                    <td height="22" valign="bottom">&nbsp;</td>
                  </tr>
                 <%-- <tr><td colspan="3" height="1"></td></tr>--%>
                  <tr>
                   <td height="22" valign="middle"></td>
                    <td height="22"  colspan="2" valign="middle" class="STYLE3">
                     <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="登录" Width="55px" />
                         <asp:Button ID="Button2" runat="server" Text="重置" Width="55px" OnClick="Button2_Click" />                  
                    </td>
                  
                   
                  </tr>
                </table></td>
                <td width="283" background="images/login_04.jpg">&nbsp;</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="225" background="images/login_05.jpg">&nbsp;</td>
          </tr>
        </table></td>
        <td background="images/login_03.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
<script type="text/javascript">
    if (window != top)
        top.location.href = location.href; 
</script>
</body>
</html>

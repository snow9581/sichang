<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TableShow.aspx.cs" Inherits="Instrument_TableShow" %>
<!--暂不使用-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <base target="_self"/>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="Panel1" runat="server" Height="450px" Width="1120px" 
        BackColor="#F0F0F0">
        <div style=" margin:0px auto; text-align:center">
        <br />
        <br />
        <asp:Label ID="BM" runat="server" Font-Size="22pt" style=" text-align:center" Text="我是申请表"></asp:Label>
        </div>
        <br />
        <asp:Label ID="DEPARTMENT" runat="server" Text="单位:" style="position:relative;left:30px"></asp:Label>
        <asp:Label ID="Label3" runat="server" Text="填报单位公章" style="position:relative;left:800px"></asp:Label>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" Width="1000px"  
            style="position:relative;left:20px" AutoGenerateColumns="False" 
            AllowPaging="True" 
            onpageindexchanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="XH" HeaderText="序号">
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JLQJMC" HeaderText="计量器具名称">
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="GGXH" HeaderText="规格型号" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JLLB" HeaderText="计量类别" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JDZQ" HeaderText="检定周期" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JDDJ" HeaderText="精度等级" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="SL" HeaderText="数量" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JDRQ" HeaderText="检定日期" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="SYDW" HeaderText="计量器具使用单位" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JDDW" HeaderText="计量器具检定单位" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="JDFS" HeaderText="申请检定方式" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="SM" HeaderText="特殊情况说明" >
                <FooterStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <br />
        <asp:Label ID="TIME" runat="server" Text="填报日期:" style="position:relative;left:30px;top:10px"></asp:Label>
        <asp:Label ID="Label5" runat="server" Text="审核人:" style="position:relative;left:280px;top:10px"></asp:Label>
        <asp:Label ID="Label6" runat="server" Text="批准人:" style="position:relative;left:590px;top:10px"></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="通过"  style="position:relative;left:370px"/>
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="关闭"  style="position:relative;left:470px"/>
        <asp:Button ID="Button3" runat="server" onclick="Button3_Click" Text="不通过"  style="position:relative;left:570px"/>
    </asp:Panel>
    </form>
</body>
</html>

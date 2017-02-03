<%@ Page Language="C#" AutoEventWireup="true" CodeFile="minerCheckList.aspx.cs" Inherits="datasubmit_minerCheckList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--工艺队待处理调查，包括新到调查和地面矿长返回的调查-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>待处理调查</title>
</head>
<body>
 <div class="easyui-accordion" style="width: 198px; height: 350px;">
   <iframe id="f1" title="新到调查" src="minerCheckMain.aspx"></iframe>
   <%--<iframe id="f2" title="返回调查" src="minerCheckReturnMain.aspx"></iframe>--%>
   </div>
</body>
</html>

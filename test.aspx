<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="login" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>js¡∑œ∞</title>
</head>

<body>
 <form id="form1" runat="server">

<script type="text/javascript">
    var a1 = "5" + 4;
    var a2 = void (0);
    var a3 = NaN * 3;
    var a4 = null * 4.5;
    var a5 = 5 * 015===5.075;
    var a6 = 13 >> 2;
    var a7 = -13 >> 2;
    var a8 = 13 | 5;
    var a9 = 13 & 5;


    var date = new Date;
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    month = (month < 10 ? "0" + month : month);
    var mydate = (year.toString() + month.toString());

    var isChrome = navigator.userAgent.toUpperCase().indexOf("CHROME") == -1 ? false : true;
    var isIE = navigator.userAgent.toUpperCase().indexOf("MSIE") == -1 ? false : true;
    var isFirefox = navigator.userAgent.toUpperCase().indexOf("FIREFOX") == -1 ? false : true;
    var f0 = navigator.userAgent;
    var f1 = navigator.userAgent.toUpperCase();

    var b = " hello";
    var a = b;

    function tenToSecond(aaa) { 
    var str="";
    var a=aaa;
    while(a>1){
       str=a%2+str;
       a=parseInt(a/2);
       }
       str=a+str;
        alert(str);
    }
   
    
    alert(123.toString());
    //alert(f1);
</script>
</form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="long_plan2.aspx.cs" Inherits="long_plan_long_plan2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
</head>
<body>     
    <div id="p" class="easyui-panel" title="信息填写" style="width:100%;padding:10px;"> 
    <div style="padding:10px 200px 20px 200px"> 
    <form id="ff" method="post" runat="server" enctype="multipart/form-data" action="long_plan2.ashx">
    <input type="hidden" id="ID" value='1' runat="server"/>
    <input type="hidden" id="in_DraftSolutionFile" value='1' runat="server"/>
    <input type="hidden" id="in_InstApprSolutionFile" value='1' runat="server"/>
    <input type="hidden" id="in_FactAppSolutionFile" value='1' runat="server"/>
    <table id="Table1" style="width:100%;  margin-top :5px;" cellpadding="5">
    <tr><td><font size="2" color="blue">基本信息</font></td></tr>
    <tr>
        <td>项目名称</td>
	    <td><input name="PName" id="PName" class="easyui-validatebox textbox" style=" height:20px"  runat="server" readonly="readonly"/></td>
	    <td>项目方案负责人</td>
	    <td><input name="SoluChief" id="SoluChief" class="easyui-validatebox textbox" style=" height:20px" runat="server" readonly="readonly"/></td>
	</tr>
	<tr>   
        <td>编写完成方案</td>
	    <td id="Td1"><input type="file" id="DraftSolutionFile"  name="DraftSolutionFile" class="easyui-validatebox textbox" runat="server"/> </td>
	    <td id="F1" style="display:none"><div id="Div2"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:200px"  onclick="downloadWord1()">下载</div></td>
    </tr>
    <tr>
        <td>所审通过方案</td>
	    <td id="Td2"><input type="file" id="InstApprSolutionFile"  name="InstApprSolutionFile" class="easyui-validatebox textbox" runat="server"/> </td>
	    <td id="F2" style="display:none"><div id="Div4"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:200px"  onclick="downloadWord2()">下载</div></td>
	</tr>
	<tr>   
        <td>厂审通过方案</td>
	    <td id="Td3"><input type="file" id="FactAppSolutionFile"  name="FactAppSolutionFile" class="easyui-validatebox textbox" runat="server"/> </td>
	    <td id="F3" style="display:none"><div id="Div5"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:200px"  onclick="downloadWord3()">下载</div></td>
	</tr>
	</table>
	</form>
    <br />
	<div style="text-align:center;padding:5px">            
    <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>
    </div> 
</div> 
</div>
   <script type="text/javascript"> 
    $(function()
    { 
        if($("#in_DraftSolutionFile").val()!="#"&&$("#in_DraftSolutionFile").val()!="1"&&$("#in_DraftSolutionFile").val()!="")
        {  
            document.getElementById("Td1").style.display = "none"; 
            document.getElementById("F1").style.display = "block";

            
         }
        if($("#in_InstApprSolutionFile").val()!="#"&&$("#in_InstApprSolutionFile").val()!="1"&&$("#in_InstApprSolutionFile").val()!="")
        {
            document.getElementById("Td2").style.display = "none";
            document.getElementById("F2").style.display = "block";
        }
        if ($("#in_FactAppSolutionFile").val() != "#" && $("#in_FactAppSolutionFile").val() != "1"&&$("#in_FactAppSolutionFile").val()!="") {
            document.getElementById("Td3").style.display = "none";
            document.getElementById("F3").style.display = "block";
        }
//        $("#DraftSolutionFile").on('input',function(e){  
//            alert(havetime());  
//        });  改变事件
    });
    function havetime(){
            var mydate = new Date();
            var str = "" + mydate.getFullYear() + "-";
            str += (mydate.getMonth()+1) + "-";
            str += mydate.getDate();
            return str;
    }

    function downloadWord1() {
               var wordname = document.getElementById("in_DraftSolutionFile").value;
               var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
               self.location.href = url;

           }
    function downloadWord2() {
               var wordname = document.getElementById("in_InstApprSolutionFile").value;
               var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
               self.location.href = url;   
           }
    function downloadWord3() {
               var wordname = document.getElementById("in_FactAppSolutionFile").value;
               var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
               self.location.href = url;
           }
    function submitForm() {
        $("#save").removeAttr("onclick");
        $('#ff').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
                    self.location = 'show_long_plan.aspx';
                    parent.saveurl();
                } else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../../login.aspx';
                }
                else {
                    alert('提交失败');
                }
            }
        });
    }
    function clearForm() {
       // $('#ff').form('clear');
       alert($("#FactCheckDate_R").datebox('getValue'));
       $("#FactCheckDate_R").disabled=true;

    }  
    
    function myformatter(date) {
          var y = date.getFullYear();
          var m = date.getMonth() + 1;
          var d = date.getDate();
         
          return y + '-' + (m < 10 ? ('0' + m) : m) + '-'+ (d < 10 ? ('0' + d) : d);
        }
        function myparser(s) {          
          if (!s)
          return new Date();          
          var ss = (s.split('-'));
          var y = parseInt(ss[0], 10);
          var m = parseInt(ss[1], 10);
          var d = parseInt(ss[2], 10);
          if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {          
          return new Date(y, m - 1, d);
          } else {         
          return new Date();
          }
        }            
    </script>
</body>
</html>
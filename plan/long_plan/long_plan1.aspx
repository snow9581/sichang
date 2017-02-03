<%@ Page Language="C#" AutoEventWireup="true" CodeFile="long_plan1.aspx.cs" Inherits="long_plan_long_plan1" %>

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
    <div style="padding:0px 20px 0px 20px"> 
    <form id="ff" method="post" runat="server" enctype="multipart/form-data" action="long_plan1.ashx">
    <input type="hidden" id="ID" value='1' runat="server"/>
    <input type="hidden" id="in_FinalSolutionFile" value='1' runat="server"/>
    <input type="hidden" id="in_APPROVEFILE" value='1' runat="server"/> 
    <table id="Table1" style="width:100%;  margin-top :5px;" cellpadding="5">
    <tr><td><font size="2" color="blue">基本信息</font></td></tr>
    <tr>
        <td>项目名称</td>
	    <td><input name="PName" id="PName" class="easyui-validatebox textbox" style=" height:20px"  runat="server" readonly="readonly"/></td>
	    <td>项目方案负责人</td>
	    <td><input name="SoluChief" id="SoluChief" class="easyui-validatebox textbox" style=" height:20px" runat="server" readonly="readonly"/></td>
	</tr>
    <tr>
        <td>方案上报时间</td> 
	    <td><input name="SoluSubmitDate" id="SoluSubmitDate" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser" /></td>
        <td>审查时间</td> 
	    <td><input name="SoluCheckDate" id="SoluCheckDate" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser" /></td>
	</tr>
	<tr>
	    <td>审查意见答复时间</td>
	    <td><input name="SoluAdviceReplyDate" id="SoluAdviceReplyDate" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser" /></td>
        <td>批复文件</td>
	    <td id="Td1"><input type="file" id="APPROVEFILE"  name="FinalSolutionFile" class="easyui-validatebox textbox" runat="server"/> </td>
	    <td id="F1" style="display:none"><div id="Div2"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:200px"  onclick="downloadWord1()">下载</div></td>
        <td>最终方案</td>
	    <td id="Td4"><input type="file" id="FinalSolutionFile"  name="FinalSolutionFile" class="easyui-validatebox textbox" runat="server"/> </td>
	    <td id="F4" style="display:none"><div id="Div1"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:200px"  onclick="downloadWord4()">下载</div></td>
	</tr>
	</table>
	</form>
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
 
        if($("#SoluSubmitDate").val()!="")
            document.getElementById("SoluSubmitDate").disabled = true;
        if($("#SoluCheckDate").val()!="")
            document.getElementById("SoluCheckDate").disabled = true;
        if($("#SoluAdviceReplyDate").val()!="")
            document.getElementById("SoluAdviceReplyDate").disabled = true;
        if ($("#in_FinalSolutionFile").val() != "#" && $("#in_FinalSolutionFile").val() != "1"&&$("#in_FinalSolutionFile").val()!="") {
            document.getElementById("Td4").style.display = "none";
            document.getElementById("F4").style.display = "block";
        }
        if($("#in_APPROVEFILE").val()!="#"&&$("#in_APPROVEFILE").val()!="1"&&$("#in_APPROVEFILE").val()!=""){
            document.getElementById("Td1").style.display="none";
            document.getElementById("F1").style.display="block";
        }
    });
   function downloadWord1(){
       var wordname=document.getElementById("in_APPROVEFILE").value;
       var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=archives";
       self.location.href=url;
   }  
   function downloadWord4() {
       var wordname = document.getElementById("in_FinalSolutionFile").value;
       var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=archives";
       self.location.href = url;
   }
   function submitForm() {
       $("#save").removeAttr("onclick");
        $('#ff').form('submit',{
          success: function(data)
          {
             if(data.toString()=='1')
                {
                    self.location = 'show_long_plan.aspx';
                    parent.saveurl();
                } else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../../login.aspx';
                }
                else 
                {
                    alert('提交失败');
                }
             
          }
        });
//        $('#ff').submit();
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

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="planrun_part.aspx.cs" Inherits="new_plan_planrun_part" %>
<!--规划室主任进行方案上报-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>     
    <div id="p" class="easyui-panel" title="方案上报" style="width:100%;padding:10px;height:100%"> 
    <form id="ff" method="post" runat="server" enctype="multipart/form-data" action="planrun_part.ashx">
    <input type="hidden" id="ID" value='1' runat="server"/> 
    <input type="hidden" id="in_FactApprSolutionFile" value='' runat="server"/>
    <input type="hidden" id="in_FinalSolutionFile" value='' runat="server"/>
    <input type="hidden" id="in_SoluApproveFile" value='' runat="server"/>
    <input type="hidden" id="IN_DESICONDITIONTABLE" value='' runat="server"/>
    <table id="Table1" class="border-table" style="width:600px;  margin-top :5px;" cellpadding="5">
    <tr><td class="top" style="text-align:center"><font size="3" color="blue" >方案信息</font></td></tr>
    <tr class="center">
        <td>项目名称</td>
	    <td><input name="PName" id="PName" class="easyui-validatebox textbox" style=" height:20px"  runat="server" readonly="readonly"/></td>
	    <td>项目来源</td>
	    <td><input name="PSource" id="PSource" class="easyui-validatebox textbox" style=" height:20px" runat="server" readonly="readonly"/></td>
	    <td></td>
    </tr>
	<tr class="bottom">   
        <td>项目方案负责人</td>
	    <td><input name="SoluChief" id="SoluChief" class="easyui-validatebox textbox" style=" height:20px" runat="server" readonly="readonly"/></td>
        <td>所审通过方案</td>
	    <td><div id="Div1" runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer; width:150px" onclick="downloadWord('INSTFILENAME','ftp_planfile')">下载</div></td>
        <td style="width:30px"><input  type="hidden" id="INSTFILENAME"  readonly="readonly" style="width:100%"  runat="server"/></td>    
    </tr>
    <tr style="height:20px"></tr>
    <tr><td class="top" style="text-align:center"><font size="3" color="blue">厂审</font></td></tr>
    <tr class="only">
	    <td>厂审通过方案</td>
	    <td id="FASF"><input type="file"  id="FactApprSolutionFile" name="FactApprSolutionFile" class="easyui-validatebox textbox" runat="server" style="width:150px"/></td>
	    <td style="display:none" id="Div2"><div  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px"  onclick="downloadWord('in_FactApprSolutionFile','ftp_planfile')">下载</div></td>
	    <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr style="height:20px"></tr>
    <tr><td class="top" style="text-align:center"><font size="3" color="blue">上报油公司</font></td></tr>
	<tr class="center">   
        <td>方案上报时间</td>
	    <td><input name="SoluSubmitDate" id="SoluSubmitDate" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser" /></td>
	    <td>审查时间</td>
	    <td><input name="SoluCheckDate" id="SoluCheckDate" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser" /></td>
	    <td></td>
    </tr>
     <tr class="bottom">    
        <td>意见答复时间</td>
	    <td><input name="SoluAdviceReplyDate" id="SoluAdviceReplyDate" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser" /></td>  
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr style="height:20px"></tr>
    <tr><td class="top" style="text-align:center"><font size="3" color="blue">批复下达</font></td></tr>
    <tr class="only">
        <td>批复下达时间</td>
	    <td><input name="SoluApproveDate" id="SoluApproveDate" class="easyui-datebox" runat="server" data-options="formatter:myformatter,parser:myparser" /></td>
        <td>批复文件</td>
	    <td id="SAF"><input type="file" id="SoluApproveFile"  name="SoluApproveFile" class="easyui-validatebox textbox" runat="server" style="width:150px"/> </td>
		<td id="Div4" style="display:none"><div runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px"  onclick="downloadWord('in_SoluApproveFile','archives')">下载</div></td>
	    <td></td>
    </tr>
    <tr style="height:20px"></tr>
    <tr><td class="top" style="text-align:center"><font size="3" color="blue">最终方案</font></td></tr>
    <tr class="center">
        <td>最终方案文档</td>
	    <td id="FSF"><input type="file" id="FinalSolutionFile"  name="FinalSolutionFile" class="easyui-validatebox textbox" runat="server" style="width:150px"/> </td>
		<td id="Div3" style="display:none"><div  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px"  onclick="downloadWord('in_FinalSolutionFile','archives')">下载</div></td>
        <td>设计条件表</td>
	    <td id="DCT"><input type="file" id="DESICONDITIONTABLE"  name="DESICONDITIONTABLE" class="easyui-validatebox textbox" runat="server" style="width:150px"/> </td>
		<td id="Div5" style="display:none"><div  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px"  onclick="downloadWord('IN_DESICONDITIONTABLE','archives')">下载</div></td>
        <td></td>
    </tr>
    <tr class="bottom"> 
        <td>项目号</td>
	    <td><input name="PNumber" id="PNumber" class="easyui-validatebox textbox" style=" height:20px" runat="server"/></td>
        <td>计划投资</td>
	    <td><input name="PLANINVESMENT" id="PLANINVESMENT" class="easyui-numberbox" min="0.01" max="100000000" precision="2" style=" height:20px" runat="server"/></td>
        <td></td>
    </tr>
    <tr style="height:20px"></tr>
    <tr>   
        <td>备注</td>
        <td><input name="Remark" id="Remark" class="easyui-textbox" data-options="multiline:true" style="width:200px;height:60px" runat="server"/></td>
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

   <script type="text/javascript"> 
    $(function()
    {
        //设定table宽度自动适应窗口大小
        var w = document.body.clientWidth;
        var tw = $('#Table1').width();
        $("#Table1").css("marginLeft", parseInt((w - tw) / 2) + 'px');

        if($("#SoluAdviceReplyDate").val()!="")
            document.getElementById("SoluAdviceReplyDate").readOnly = true;
        if($("#SoluApproveDate").val()!="")
            document.getElementById("SoluApproveDate").readOnly = true;
        if($("#SoluCheckDate").val()!="")
            document.getElementById("SoluCheckDate").readOnly = true;
        if($("#PLANINVESMENT").val()!="")
            document.getElementById("PLANINVESMENT").readOnly = true;
        if($("#SoluSubmitDate").val()!="")
            document.getElementById("SoluSubmitDate").readOnly = true;
        if($("#in_FactApprSolutionFile").val()!="#"&&$("#in_FactApprSolutionFile").val()!="")
        {  
            document.getElementById("FASF").style.display = "none"; 
            document.getElementById("Div2").style.display = "block";
            //$("#FactApprSolutionFile").validatebox({display: "none"});
            
         }
        if($("#in_FinalSolutionFile").val()!="#"&&$("#in_FinalSolutionFile").val()!="")
        {
            document.getElementById("Div3").style.display = "block";
            document.getElementById("FSF").style.display = "none";
        }
        if ($("#in_SoluApproveFile").val() != "#" && $("#in_SoluApproveFile").val() != "") {
            document.getElementById("Div4").style.display = "block";
            document.getElementById("SAF").style.display = "none";
        }
        if ($("#IN_DESICONDITIONTABLE").val() != "#" && $("#IN_DESICONDITIONTABLE").val() != "") {
            document.getElementById("Div5").style.display = "block";
            document.getElementById("DCT").style.display = "none";
        }
    });

    function downloadWord(name, package) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=" + package;
        self.location.href = url;
    }

   function submitForm() {
        $("#save").removeAttr("onclick");
        $('#ff').form('submit',{
          success: function(data)
          {
             if(data.toString()=='1')
                {
                    var strUrl = window.location.href;
                    var arrUrl = strUrl.split("/");
                    var strPage = arrUrl[arrUrl.length - 1].split("#");
                    var page = strPage[0];
                    self.location = page;
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
    }
    function clearForm() {
        $('#ff').form('clear');
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

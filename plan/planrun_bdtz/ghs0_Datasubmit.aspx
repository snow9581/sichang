<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ghs0_Datasubmit.aspx.cs" Inherits="plan_planrun_bdtz_ghs0_Datasubmit" %>

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
 <div id="p" class="easyui-panel" title="资料上传及时间记录" style="width:100%;" >
 <div style="padding:10px 0px 20px 0px">  
	<form id="ff" method="post" action="ghs0_Datasubmit.ashx" enctype="multipart/form-data" style="text-align: center">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
     <input type="hidden" id="in_YCZLFILE" value='1' runat="server"/>
    <input type="hidden" id="in_CYZLFILE" value='1' runat="server"/>
     <input type="hidden" id="in_DMZLFILE" value='1' runat="server"/>
	<table id="Table1" style="width:100%;  margin-top :5px;" cellpadding="5" runat="server">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			
			<td>项目号</td>
			<td><input id="PNumber"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			
            <td>项目方案负责人</td>
			<td><input id="SOLUCHIEF"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			
			<td><input  type="hidden" id="FinalSolutionFile" style="width:100%"  runat="server"/> </td>
		</tr>
        
		 <tr>
		    <td>油藏资料提交时间</td>
			<td><input id="YCZLSubmitDate" name="YCZLSubmitDate" class="easyui-datebox"  value="" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
            
            	    
		    <td>采油资料提交时间</td>
			<td><input id="CYZLSubmitDate" name="CYZLSubmitDate" class="easyui-datebox"   value="" data-options="formatter:myformatter,parser:myparser" runat="server" /></td>
			<td>地面委托资料时间</td>
			<td><input id="DMZLDelegateDate" name="DMZLDelegateDate" class="easyui-datebox"   value="" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>        
		</tr>
        <tr>
            <td>油藏资料</td>
		    <td id="a"><input type="file"  id="YCZLFILE" name="YCZLFILE" class="easyui-validatebox textbox" runat="server" /></td> 
            <td style="display:none" id="e"><div id="Div1"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:200px"  onclick="downloadWord1()">下载</div></td> 
            <td>采油资料</td>        
		    <td id="b"><input type="file"  id="CYZLFILE" name="CYZLFILE" class="easyui-validatebox textbox" runat="server" /></td>
            <td style="display:none" id="f"><div id="Div2"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:200px"  onclick="downloadWord2()">下载</div></td>
            <td>地面委托资料</td>
	        <td id="c"><input type="file"  id="DMZLFILE" name="DMZLFILE" class="easyui-validatebox textbox" runat="server" /></td>
            <td id="g" style="display:none"><div id="Div3"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:200px"  onclick="downloadWord3()">下载</div></td>
        </tr>
    </table>
    </form>
        <div style="text-align:center;">            
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div> 
</div>      
</div>
        
<script type="text/javascript">
    function submitForm() {
        $("#save").removeAttr("onclick");
        $('#ff').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
                    //                var result=$.messager.alert('提示框','计划开始运行');
                    //                if(result) 
                    self.location = 'show_planRun_bdtz.aspx';
                    parent.saveurl();
                } else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../../login.aspx';
                }
                else {
                    $.messager.alert('提示框', '计划运行失败');
                }
            }
        });
    }
    function downloadWord1() {
        var wordname = document.getElementById("in_YCZLFILE").value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
        self.location.href = url;
    }
    function downloadWord2() {
        var wordname = document.getElementById("in_CYZLFILE").value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
        self.location.href = url;
    }
    function downloadWord3() {
        var wordname = document.getElementById("in_DMZLFILE").value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
        self.location.href = url;
    }
    function clearForm() {
        $('#ff').form('clear');
    }

    function myformatter(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
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


    function changeDate(dateIDA, dateIDB, offset) {
        if (dateIDA == "") {
            var d = new Date();
            var year = d.getFullYear();
            var month = (d.getMonth() + 1);
            var date = d.getDate() + offset;
        }
        else {
            var dateStrA = $('#' + dateIDA).datebox('getValue');
            var year = dateStrA.substring(0, 4);
            var month = Number(dateStrA.substring(5, 7));
            var date = Number(dateStrA.substring(8, 10)) + offset;
        }
        var dateB = new Date();
        dateB.setFullYear(year, month, date);
        var year2 = dateB.getFullYear();
        var month2 = dateB.getMonth() + "";
        var date2 = dateB.getDate() + "";
        if (month2.length == 1) month2 = "0" + month2;
        if (date2.length == 1) date2 = "0" + date2;
        var DD = year2 + "-" + month2 + "-" + date2;
        $('#' + dateIDB).datebox('setValue', DD);
    }
    $(function () {

        if ($("#YCZLSubmitDate").val() != "") {
            $("#YCZLSubmitDate").datebox({ readonly: true });

        }
        if ($("#CYZLSubmitDate").val() != "")
            document.getElementById("CYZLSubmitDate").readonly = true;
        if ($("#DMZLDelegateDate").val() != "")
            document.getElementById("DMZLDelegateDate").readonly = true;

        if ($("#in_YCZLFILE").val() != "#" && $("#in_YCZLFILE").val() != "") {
            document.getElementById("a").style.display = "none";
            document.getElementById("e").style.display = "block";
             }
        if ($("#in_CYZLFILE").val() != "#" && $("#in_CYZLFILE").val() != "") {
            document.getElementById("f").style.display = "block";
            document.getElementById("b").style.display  = "none";
        }
        if ($("#in_DMZLFILE").val() != "#" && $("#in_DMZLFILE").val() != "") {
             document.getElementById("g").style.display = "block";
             document.getElementById("c").style.display = "none";
        }
    });
    </script>

</body>
</html>
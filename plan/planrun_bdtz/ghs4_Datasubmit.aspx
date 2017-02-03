<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ghs4_Datasubmit.aspx.cs" Inherits="plan_planrun_bdtz_ghs4_Datasubmit" %>

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
 <div id="p" class="easyui-panel" title="方案计划时间" style="width:100%;padding:10px;" >
 <div style="padding:10px 30px 20px 30px">  
	<form id="ff" method="post" action="ghs4_Datasubmit.ashx" enctype="multipart/form-data" style="text-align: center">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
	<table id="Table1" style="width:100%;  margin-top :5px;" cellpadding="5" runat="server">
		<tr>
		    <td>项目名称</td>
			
            <td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			 <td>项目号</td>
			<td><input id="PNumber"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
           <td>项目方案负责人</td>
			<td><input id="SOLUCHIEF"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
		</tr>
		 
		<tr>
            <td>地面方案完成计划时间</td>
			<td><input id="SoluCompDate_P" name="SoluCompDate_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser"/></td>
		    <td>方案审查计划时间</td>
            <td><input id="SoluCheckDate_P" name="SoluCheckDate_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser"/></td>
           
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

    function submitForm() {
      $("#save").removeAttr("onclick");
         $('#ff').form('submit', {
             success: function (data) {
                 if (data.toString() == '1') {
                     self.location = 'show_planRun_bdtz.aspx';
                     parent.saveurl();
                 } else if (data.toString() == "") {
                     alert('登陆账号已过期，请重新登录！');
                     window.top.location.href = '../../login.aspx';
                 }
                 else {
                     $.messager.alert('提示框', '提交失败');
                 }
             }
         });
     }
     function clearForm() {
         $('#ff').form('clear');
     }
     function downloadWord(file) {
         var wordname = document.getElementById(file).value;
         var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
         self.location.href = url;
     }
     function clearForm() {
         
         alert($("#FactCheckDate_R").datebox('getValue'));
         $("#FactCheckDate_R").disabled = true;

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
    </script>

</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DesignatedDesignPerson.aspx.cs" Inherits="plan_planRun_dtz_DesignatedDesignPerson" %>
<!--设计室主任指定负责人-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="指定负责人" style="width:100%;padding:10px;height:100%">
    <form id="ff" method="post" action="DesignatedDesignPerson.ashx" enctype="multipart/form-data">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:930px; margin-top :5px; text-align:center" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName"  class="easyui-validatebox textbox" type="text" style="height:20px" readonly="readonly" runat="server"/></td>
			<td style="width:20px"></td>
			<td>项目设计负责人</td>
            <td><input id="DESICHIEF"  name="DESICHIEF" class="easyui-textbox" type="text" data-options="required:true" runat="server"/></td>
			<%--<td><input id="DESICHIEF" name="DESICHIEF" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../plan/getOfficeStaff/get_designOfficeStaff.ashx',required:true"/></td>--%>
			<td  style="width:20px"></td>
			<td>主专业校审及室负责人</td>
            <td><input id="MAJORPROOFREADER" name="MAJORPROOFREADER" class="easyui-textbox" type="text" runat="server"/></td>
			<%--<td><input id="MAJORPROOFREADER" name="MAJORPROOFREADER" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../plan/getOfficeStaff/get_designOfficeStaff.ashx',required:true"/></td>--%>
		</tr>
        <tr>
		    <td>计划模板</td>
		    <td><input id="PTemplate" name="PTemplate"  class="easyui-combobox" runat="server" data-options="required:true,valueField:'text',textField:'text',url: '../../plan/planTemplate2/get_planTemplate.ashx',onSelect:function(rec){ planTemplate(rec.text);}"/></td>
		    <td style="width:20px"></td>
		    <td>一次委托资料截止时间</td>
			<td><input id="MAJORDELEGATEDATE_P" name="MAJORDELEGATEDATE_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
			<td style="width:20px"></td>
			<td>工程量提交截止时间</td>
			<td><input id="WORKLOADSUBMITDATE_P" name="WORKLOADSUBMITDATE_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
		</tr>
		<tr> 
            <td>备注</td>
            <td><textarea  rows="3" cols="20" id="Remark" name="Remark" class="easyui-textbox" data-options="multiline:true" style="width:150px;height:50px"  runat="server"></textarea></td>
        </tr>
    </table>
    </form>
        <div style="text-align:center;padding:5px">            
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div>   
</div>
<script type="text/javascript">
    $(function () {
        //设定table宽度自动适应窗口大小
        var w = document.body.clientWidth;
        var tw = $('#Table1').width();
        $("#Table1").css("marginLeft", parseInt((w - tw) / 2) + 'px');
    });
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
                 $.messager.alert('提示框','提交失败');
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
        
        function changeDate(dateIDA,dateIDB,offset) {
           if(dateIDA=="")
           {
                var d = new Date();
                var year = d.getFullYear();
                var month = (d.getMonth()+1);
                var date = d.getDate()+offset;
           }
           else
           {
                var dateStrA = $('#'+dateIDA).datebox('getValue');
                var year = dateStrA.substring(0,4);
                var month = Number(dateStrA.substring(5,7));
                var date = Number(dateStrA.substring(8,10))+offset;
            }
            var dateB = new Date();
            dateB.setFullYear(year,month,date);
            var year2 = dateB.getFullYear();
            var month2 = dateB.getMonth()+"";
            var date2 = dateB.getDate()+"";
            if (month2.length == 1) month2 = "0"+month2;
            if (date2.length == 1) date2 = "0"+date2;
            var DD = year2 + "-" + month2 + "-" + date2;
            $('#'+dateIDB).datebox('setValue',DD);
      }

      function planTemplate(name) {
          //alert(name);
          $.ajax({
              type: "post",
              url: "../planTemplate2/get_SOLUCYCLE.ashx",
              data: "name=" + name,
              success: function (result) {
                  //alert(result.MAJORDELEGATECYCLE);
                  changeDate("", "MAJORDELEGATEDATE_P", result.MAJORDELEGATECYCLE);
                  changeDate("MAJORDELEGATEDATE_P", "WORKLOADSUBMITDATE_P", result.WORKLOADSUBMITCYCLE);
              }
          }); 
        }
    </script> 
</body>
</html>

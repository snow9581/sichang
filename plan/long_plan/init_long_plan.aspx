<%@ Page Language="C#" AutoEventWireup="true" CodeFile="init_long_plan.aspx.cs" Inherits="long_plan_init_long_plan" %>

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
 <div id="p" class="easyui-panel" title="规划设计" style="width:100%;padding:10px;" >
 <div style="padding:10px 30px 20px 30px">  
	<form id="ff" method="post" action="init_long_plan.ashx" enctype="multipart/form-data" style="text-align: center">
    <input id="dm" value="" runat="server" type="hidden"/>
	<table id="Table1" style="width:100%;  margin-top :5px;" cellpadding="5" runat="server">
		<tr>
		    <td>项目名称</td>
			<td><input name="PName" class="easyui-textbox" type="text" data-options="required:true"/></td>
			<td>项目方案负责人</td>
            <td><input name="SoluChief" class="easyui-textbox" type="text" data-options="required:true"/></td>
			<%--<td id="x1"><input name="SoluChief" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../plan/getOfficeStaff/get_planOfficeStaff.ashx'"/></td>
            <td id="x2"><input name="SoluChief" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../plan/getOfficeStaff/get_mining_areaOfficeStaff.ashx'"/></td>--%>
			<td>估算投资</td>
			<td><input name="EstiInvestment" class="easyui-textbox" min="0.01" max="100000000" precision="2"  data-options="required:true"/></td>
		</tr>
		<tr>	    
		    <td>方案计划完成时间</td>
			<td><input id="SOLUCOMPDATE_P" name="SOLUCOMPDATE_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser" /></td>
			<td>所内计划审查时间</td>
			<td><input id="INSTCHECKDATE_P" name="INSTCHECKDATE_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser" /></td>        
            <td>厂内计划审查时间</td>
			<td><input id="FACTCHECKDATE_P" name="FACTCHECKDATE_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser"/></td>
        </tr>	
        <%--<tr>
            <td>备注</td>
            <td colspan="2"><input id="BZ" name="BZ" class="easyui-textbox" data-options="multiline:true" style="width:100%;height:50px" runat="server"/></td>
        </tr>--%>		
    </table>
    </form>
    <br />
        <div style="text-align:center;padding:5px">            
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div> 
        <br />
</div>      
</div>
        
<script type="text/javascript">
    
//    $(function () {
//        if ($("#dm").val() == "矿区室") {
//            document.getElementById("x1").style.display = "none";
//        }
//        else {
//            document.getElementById("x2").style.display = "none";
//        }

//    });
  function submitForm() {
      $("#save").removeAttr("onclick");                               
      $('#ff').form('submit',{
      success: function(data)
      {       
         if(data.toString()=='1')
            {
                self.location='show_long_plan.aspx';
                parent.saveurl();
            } else if (data.toString() == "") {
                alert('登陆账号已过期，请重新登录！');
                window.top.location.href = '../../login.aspx';
            }
            else 
            {
                 $.messager.alert('提示框','计划运行失败');
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
      
        function planTemplate(name){
            $.ajax({
                    type: "post",
                    url: "../planTemplate1/get_SOLUCYCLE.ashx",
                    data: "name=" +name,
                    success: function (result) {
                        changeDate("","SOLUCOMPDATE_P",result.WIRTESOLUCYCLE);
                        changeDate("SOLUCOMPDATE_P","INSTCHECKDATE_P",result.INSTCHECKSOLUCYCLE);
                        changeDate("INSTCHECKDATE_P","FACTCHECKDATE_P",result.FACTCHECKSOLUCYCLE);
                    }
                }); 
        }
                    
                    
     
    </script>

</body>
</html>

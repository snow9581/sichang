<%@ Page Language="C#" AutoEventWireup="true" CodeFile="init_planRun_dtz.aspx.cs" Inherits="crud_tables_plan_init_planRun_dtz" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--规划室/矿区室（常规流程）室主任发起项目计划--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
</head>
<body>
 <div id="p" class="easyui-panel" title="规划设计" style="width:100%;padding:10px;height:100%" > 
	<form id="ff" method="post" action="init_planRun_dtz.ashx" enctype="multipart/form-data">
    <input type="hidden" value="" id="hd_id" runat="server"/>          
    <input type="hidden" value="1" id="Organization" runat="server"/>
	<table id="Table1" style="width:950px; margin-top :5px; text-align:right;" cellpadding="5">
		<tr>
		    <td>项目名称</td>
			<td><input id="PName" name="PName" class="easyui-textbox" type="text" data-options="required:true" runat="server"/></td>
            <td style=" width:30px"></td>
			<td>项目来源</td>
			<td><input id="PSource" name="PSource" class="easyui-textbox" type="text" runat="server"/></td>
            <td style=" width:30px"></td>
			<td>项目方案负责人</td>
            <td><input id="SoluChief" name="SoluChief" class="easyui-textbox" type="text" runat="server"/></td>
			<%--<td id="plan" style="display:none"><input id="sc_plan" name="SoluChief" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../plan/getOfficeStaff/get_planOfficeStaff.ashx',required:true"/></td>
            <td id="mini" style="display:none"><input id="sc_mini" name="SoluChief" class="easyui-combobox"  data-options="valueField:'text',textField:'text',url: '../../plan/getOfficeStaff/get_mining_areaOfficeStaff.ashx',required:true"/></td>--%>
		</tr>
		<tr>
		    <td>计划模板</td>
			<td><input id="PTemplate"  name="PTemplate"  class="easyui-combobox" data-options="valueField:'text',textField:'text',url: '../../plan/planTemplate1/get_planTemplate.ashx',onSelect:function(rec){ planTemplate(rec.text);}"/></td>		    
		    <td></td>
            <td>方案计划完成时间</td>
			<td><input id="SOLUCOMPDATE_P" name="SOLUCOMPDATE_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
			<td></td>
            <td>所内计划审查时间</td>
			<td><input id="INSTCHECKDATE_P" name="INSTCHECKDATE_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser" runat="server"/></td>        
		</tr>
		<tr>
            <td>厂内计划审查时间</td>
			<td><input id="FACTCHECKDATE_P" name="FACTCHECKDATE_P" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
		    <td></td>
            <td>负责设计的科室</td>
            <td><select id="PLANFLAG_DESIGN" name="PLANFLAG_DESIGN" class="easyui-combobox" runat="server" style="width:150px">
				 <option value="0">设计室</option>        
			     <option value="1">矿区室</option>
                 </select>
            </td>
            <td></td>
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
        $("#Table1").css("marginLeft", parseInt((w - tw) / 3) + 'px');
    });
    function submitForm() {
        $("#save").removeAttr("onclick");
        $('#ff').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
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
                else {
                    $.messager.alert('提示框', '提交失败');
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

//项目方案负责人来源：规划室or矿区室
//    $(function () {
//        if ($('#Organization').val() == "规划室") {
//            document.getElementById("plan").style.display = "block";
//            document.getElementById("sc_mini").removeAttribute("data-options");
//        }
//        if ($('#Organization').val() == "矿区室") {
//            document.getElementById("mini").style.display = "block";
//            document.getElementById("sc_plan").removeAttribute("data-options");
//        }
//    });        
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
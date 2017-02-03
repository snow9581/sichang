<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FullBudget.aspx.cs" Inherits="plan_planRun_dtz_changeform_FullBudget" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
       <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script> 
    <script type="text/javascript">
        $.fn.datebox.defaults.formatter = function (date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
        };
        $.fn.datebox.defaults.parser = function (s) {
            if (!s) return new Date();
            var ss = s.split('-');
            var y = parseInt(ss[0], 10);
            var m = parseInt(ss[1], 10);
            var d = parseInt(ss[2], 10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                return new Date(y, m - 1, d);
            } else {
                return new Date();
            }
        };
 </script>
</head>
<body id="fullbudget">
    <div id="p" class="easyui-panel" title="综合阶段阶段全部信息 " style="width:1000px;padding:10px;height:100%">
        <form id="form1" method="post" action="FullBudget.ashx" enctype="multipart/form-data" runat="server">
        <input type="hidden" value="1"  id="hd_index"  runat="server"/>
        <input type="hidden" value=""  id="userLevel"  runat="server"/> 
        <input type="hidden" id="IN_FINALBUDGETFILE" value='' runat="server"/> 
        <table class="dv-table" style="width:100%;margin-top :5px; padding-left:150px; padding-right:150px; text-align:center; " cellpadding="5">
            <tr>
                <td>概算汇总人</td>
                <td><input id="BUDGETCHIEF" name="BUDGETCHIEF" class="easyui-validatebox textbox" runat="server"/></td>
                <td style="width:75px;"></td>
            </tr>
            <tr>
                <td>工程量计划提交时间</td>
                <td><input id="WORKLOADSUBMITDATE_P" name="WORKLOADSUBMITDATE_P" class="easyui-datebox" runat="server"/></td>
                <td></td>
                <td>工程量实际提交时间</td>
                <td><input id="WORKLOADSUBMITDATE_R" name="WORKLOADSUBMITDATE_R" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>概算计划完成时间</td>
                <td><input id="BUDGETCOMPDATE_P" name="BUDGETCOMPDATE_P" class="easyui-datebox" runat="server"/></td>
                <td></td>
                <td>概算实际完成时间</td>
                <td><input id="BUDGETCOMPDATE_R" name="BUDGETCOMPDATE_R" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>初设计划上报时间</td>
                <td><input id="INITIALDESISUBMITDATE_P" name="INITIALDESISUBMITDATE_P" class="easyui-datebox" runat="server"/></td>
                <td></td>
                <td>初设实际上报时间</td>
                <td><input id="INITIALDESISUBMITDATE_R" name="INITIALDESISUBMITDATE_R" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>概算计划调整时间</td>
                <td><input id="BUDGETADJUSTDATE_P" name="BUDGETADJUSTDATE_P" class="easyui-datebox" runat="server"/></td>
                <td></td>
                <td>概算实际调整时间</td>
                <td><input id="BUDGETADJUSTDATE_R" name="BUDGETADJUSTDATE_R" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>最终概算文档</td>
                <td><input type="file" id="FINALBUDGETFILE" name="FINALBUDGETFILE" class="easyui-validatebox textbox" runat="server"  style=" width:150px;"/>
                <div id="Div1"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_FINALBUDGETFILE')">下载</div></td>
                <td></td>
                <td class="R_FINALBUDGETFILE"  style="display:none">重新上传最终概算</td>
                <td class="R_FINALBUDGETFILE" style="display:none"><input type="file" id="FINALBUDGETFILE_N" name="FINALBUDGETFILE_N" class="easyui-validatebox textbox" style=" width:150px"/></td>
            </tr>
            <tr>
                <td>备注</td>
                <td><input id="Remark" name="Remark" class="easyui-textbox" data-options="multiline:true" style="width:100%;height:60px" runat="server"/></td>
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
        var width = ($(window).width() - 1000) * 0.5;
        $("#fullbudget").css("margin-left", width); //使表单居中

        if ($('#planflag').val() == '1')
            $('.PNumber').css('visibility', 'hidden');
    });
    function submitForm() {
        $("#save").removeAttr("onclick");
        $('#form1').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
                    window.close();
                    self.opener.location.reload();
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
        $('#form1').form('clear');
    }
    $(function () {
        if ($("#IN_FINALBUDGETFILE").val() != "#" && $("#IN_FINALBUDGETFILE").val() != "") {
            document.getElementById("Div1").style.display = "block";
            document.getElementById("FINALBUDGETFILE").style.display = "none";
            $(".R_FINALBUDGETFILE").show();
        }
    });
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

    function downloadWord(name) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=archives";
        self.location.href = url;
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
    </script>
 </body>
</html>

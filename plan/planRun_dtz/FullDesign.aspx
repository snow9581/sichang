<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FullDesign.aspx.cs" Inherits="plan_planRun_dtz_changeform_FullDesign" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
<body id="fulldesign">
    <div id="p" class="easyui-panel" title="设计阶段全部信息 " style="width:1000px;padding:10px;height:100%">
        <form id="form1" method="post" action="FullDesign.ashx" enctype="multipart/form-data" runat="server">
        <input type="hidden" value="1"  id="hd_index"  runat="server"/>
        <input type="hidden" value=""  id="userLevel"  runat="server"/> 
        <input type="hidden" id="IN_DESIAPPRFILE" value='' runat="server"/>
        <input type="hidden" id="IN_PLANARRIVALFILE" value='' runat="server"/>
        <table class="dv-table" style="width:100%; margin-top :5px; padding-left:120px; padding-right:120px; text-align:center" cellpadding="5">
            <tr>
                <td>项目设计负责人</td>
                <td><input id="DESICHIEF" name="DESICHIEF" class="easyui-validatebox textbox"  runat="server"/></td>
                <td style="width:50px;"></td>
                <td>主专业校对及室负责人</td>
                <td><input id="MAJORPROOFREADER" name="MAJORPROOFREADER" class="easyui-validatebox textbox" runat="server"/></td>
            </tr>
            <tr>
                <td>一次委托资料计划时间</td>
                <td><input id="MAJORDELEGATEDATE_P" name="MAJORDELEGATEDATE_P" class="easyui-datebox" runat="server"/></td>
                <td></td>
                <td>一次委托资料实际时间</td>
                <td><input id="MAJORDELEGATEDATE_R" name="MAJORDELEGATEDATE_R" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>计划下达文件号</td>
                <td><input id="PLANARRIVALFILENUMBER" name="PLANARRIVALFILENUMBER" class="easyui-validatebox textbox" runat="server"/></td>
                <td></td>
                <td>计划下达文件批准日期</td>
                <td><input id="PLANARRIVALDATE" name="PLANARRIVALDATE" class="easyui-datebox textbox" runat="server"/></td>
            </tr>
            <tr>
                <td>设计批复下达文件号</td>
                <td><input id="DESIAPPROVALARRIVALFILENUMBER" name="DESIAPPROVALARRIVALFILENUMBER" class="easyui-validatebox textbox" runat="server"/></td>
                <td></td>
                <td>设计批复文件批准日期</td>
                <td><input id="DESIAPPROVALARRIVALDATE" name="DESIAPPROVALARRIVALDATE" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>施工图白图计划校审时间</td>
                <td><input id="WHITEGRAPHCHECKDATE_P" name="WHITEGRAPHCHECKDATE_P" class="easyui-datebox" runat="server"/></td>
                <td></td>
                <td>施工图白图实际校审时间</td>
                <td><input id="WHITEGRAPHCHECKDATE_R" name="WHITEGRAPHCHECKDATE_R" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>二次委托资料实际时间</td>
                <td><input id="SECONDCOMMISSIONDATE" name="SECONDCOMMISSIONDATE" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>蓝图计划存档时间</td>
                <td><input id="BLUEGRAPHDOCUMENT_P" name="BLUEGRAPHDOCUMENT_P" class="easyui-datebox" runat="server"/></td>
                <td></td>
                <td>蓝图实际存档时间</td>
                <td><input id="BLUEGRAPHDOCUMENT_R" name="BLUEGRAPHDOCUMENT_R" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>设计批复下达</td>
                <td><input type="file" id="DESIAPPRFILE" name="DESIAPPRFILE" class="easyui-validatebox textbox" runat="server" style="width:150px"/>
                <div id="Div1"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_DESIAPPRFILE','archives')">下载</div></td>
                <td></td>
                <td class="R_DESIAPPRFILE"  style="display:none">重新上传设计批复下达</td>
                <td class="R_DESIAPPRFILE" style="display:none"><input type="file" id="DESIAPPRFILE_N" name="DESIAPPRFILE_N" class="easyui-validatebox textbox" style=" width:150px"/></td>      
            </tr>
            <tr>
                <td>计划下达文件</td>
                <td><input type="file" id="PLANARRIVALFILE" name="PLANARRIVALFILE" class="easyui-validatebox textbox" runat="server" style="width:150px"/>
                <div id="Div2"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_PLANARRIVALFILE','archives')">下载</div></td>
                <td></td>
                <td class="R_PLANARRIVALFILE"  style="display:none">重新上传计划下达文件</td>
                <td class="R_PLANARRIVALFILE" style="display:none"><input type="file" id="PLANARRIVALFILE_N" name="PLANARRIVALFILE_N" class="easyui-validatebox textbox" style=" width:150px"/></td>
                
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
    function downloadWord(name, package) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=" + package;
        self.location.href = url;
    }
    $(function () {
        var width = ($(window).width() - 1000) * 0.5;
        $("#fulldesign").css("margin-left", width); //使表单居中

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
        if ($("#IN_DESIAPPRFILE").val() != "#" && $("#IN_DESIAPPRFILE").val() != "") {
            document.getElementById("Div1").style.display = "block";
            document.getElementById("DESIAPPRFILE").style.display = "none";
            $(".R_DESIAPPRFILE").show();
        }
        if ($("#IN_PLANARRIVALFILE").val() != "#" && $("#IN_PLANARRIVALFILE").val() != "") {
            document.getElementById("Div2").style.display = "block";
            document.getElementById("PLANARRIVALFILE").style.display = "none";
            $(".R_PLANARRIVALFILE").show();
        }
    });
    </script>
    </body>
</html>

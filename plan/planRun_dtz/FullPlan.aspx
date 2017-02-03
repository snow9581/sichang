<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FullPlan.aspx.cs" Inherits="plan_planRun_dtz_changeform_FullPlan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script> 
</head>
<body id="fullplan">
    <div id="p" class="easyui-panel" title="规划阶段全部信息 " style="width:1000px;padding:10px;height:100%"> 
        <form id="form1" method="post" action="FullPlan.ashx" enctype="multipart/form-data" runat="server">
        <input type="hidden" value="1"  id="hd_index"  runat="server"/>
        <input type="hidden" value=""  id="userLevel"  runat="server"/>
        <input type="hidden" id="IN_FINALSOLUTIONFILE" value='' runat="server"/>
        <input type="hidden" id="IN_SOLUAPPROVEFILE" value='' runat="server"/>
        <input type="hidden" id="IN_DESICONDITIONTABLE" value='' runat="server"/> 
        <input type="hidden" id="IN_DESICONDITIONTABLE_N" value='' runat="server"/> 
        <table class="dv-table" style="width:100%;margin-top :5px;text-align:center"cellpadding="5">
            <tr>
                <td>项目名称</td>
                <td><input id="PNAME" name="PNAME" class="easyui-validatebox textbox"  runat="server" readonly="readonly"/></td>
                <td style=" width:20px"></td>
                <td>项目来源</td>
                <td><input id="PSOURCE" name="PSOURCE" class="easyui-validatebox textbox" runat="server"/></td>
                <td style=" width:20px"></td>
                <td>项目方案负责人</td>
                <td><input id="SOLUCHIEF" name="SOLUCHIEF" class="easyui-validatebox textbox" runat="server"/></td>
            </tr>
            <tr>
                <td>估算投资</td>
                <td><input id="ESTIINVESTMENT" name="ESTIINVESTMENT" class="easyui-validatebox textbox" runat="server"/></td>
                <td></td>
                <td>方案计划完成时间</td>
                <td><input id="SOLUCOMPDATE_P" name="SOLUCOMPDATE_P" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
                <td></td>
                <td>方案实际完成时间</td>
                <td><input id="SOLUCOMPDATE_R" name="SOLUCOMPDATE_R" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
            </tr>
            <tr>
                <td>所内计划完成时间</td>
                <td><input id="INSTCHECKDATE_P" name="INSTCHECKDATE_P" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
                <td></td>
                <td>所内实际完成时间</td>
                <td><input id="INSTCHECKDATE_R" name="INSTCHECKDATE_R" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
            </tr>
            <tr>
                <td>厂内计划完成时间</td>
                <td><input id="FACTCHECKDATE_P" name="FACTCHECKDATE_P" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
                <td></td>
                <td>厂内实际完成时间</td>
                <td><input id="FACTCHECKDATE_R" name="FACTCHECKDATE_R" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
            </tr>
            <tr>
                <td>方案上报时间</td>
                <td><input id="SOLUSUBMITDATE" name="SOLUSUBMITDATE" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
                <td></td>
                <td>审查时间</td>
                <td><input id="SOLUCHECKDATE" name="SOLUCHECKDATE" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
            </tr>
            <tr>
                <td>审查意见答复时间</td>
                <td><input id="SOLUADVICEREPLYDATE" name="SOLUADVICEREPLYDATE" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
                <td></td>
                <td>方案批复下达时间</td>
                <td><input id="SOLUAPPROVEDATE" name="SOLUAPPROVEDATE" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" runat="server"/></td>
            </tr>
            <tr>
               <td>最终方案文档</td>
	            <td><input type="file" id="FinalSolutionFile"  name="FinalSolutionFile" class="easyui-validatebox textbox" runat="server" style=" width:150px"/>
                <div id="Div1"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_FINALSOLUTIONFILE','archives')">下载</div></td>
                <td></td>
                <td class="R_FinalSolutionFile"  style="display:none">重新上传最终方案</td>
                <td class="R_FinalSolutionFile" style="display:none"><input type="file" id="renewFINALSOLUTIONFILE" name="renewFINALSOLUTIONFILE" class="easyui-validatebox textbox" style=" width:150px" runat="server"/></td>
            </tr>
            <tr>
                <td>设计条件表</td>  
                <td><input type="file" id="DESICONDITIONTABLE"  name="DESICONDITIONTABLE" class="easyui-validatebox textbox" runat="server" style=" width:150px"/>
                <div id="Div2" runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_DESICONDITIONTABLE','archives')">下载</div></td>
            </tr>
            <tr>
                <td>设计条件表(最终)</td>  
                <td><input type="file" id="DESICONDITIONTABLE_N"  name="DESICONDITIONTABLE_N" class="easyui-validatebox textbox" runat="server" style=" width:150px"/>
                <div id="Div4" runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_DESICONDITIONTABLE_N','archives')">下载</div></td>
                <td></td>
                <td class="R_DESICONDITIONTABLE_N" style="display:none">重新上传设计条件表(最终)</td>
                <td class="R_DESICONDITIONTABLE_N" style="display:none"><input type="file" id="renewDESICONDITIONTABLE_N" name="renewDESICONDITIONTABLE_N" class="easyui-validatebox textbox" style=" width:150px"/></td>
            </tr>
            <tr>
                <td>方案批复</td>
                <td><input type="file" id="SoluApproveFile"  name="SoluApproveFile" class="easyui-validatebox textbox" runat="server" style=" width:150px"/> 
                <div id="Div3" runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_SOLUAPPROVEFILE','archives')">下载</div></td>
                <td></td>
                <td class="R_SoluApproveFile" style="display:none">重新上传方案批复</td>
                <td class="R_SoluApproveFile" style="display:none"><input type="file" id="renewSOLUAPPROVEFILE" name="renewSOLUAPPROVEFILE" class="easyui-validatebox textbox" style=" width:150px"/></td>
            </tr>
            <tr>
                <td>项目号</td>
                <td><input id="PNUMBER" name="PNUMBER" class="easyui-validatebox textbox" runat="server"/></td>
                <td></td>
                <td>计划投资</td>
                <td><input id="PLANINVESMENT" name="PLANINVESMENT" class="easyui-validatebox textbox" runat="server"/></td>
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
        var width=($(window).width() - 1000) * 0.5;
        $("#fullplan").css("margin-left", width);//使表单居中

        if ($("#IN_DESICONDITIONTABLE").val() != "#" && $("#IN_DESICONDITIONTABLE").val() != "") {
            document.getElementById("Div2").style.display = "block";
            document.getElementById("DESICONDITIONTABLE").style.display = "none";
        }
        if ($("#IN_DESICONDITIONTABLE_N").val() != "#" && $("#IN_DESICONDITIONTABLE_N").val() != "") {
            document.getElementById("Div4").style.display = "block";
            document.getElementById("DESICONDITIONTABLE_N").style.display = "none";
            $(".R_DESICONDITIONTABLE_N").show();
        }
        if ($("#IN_SOLUAPPROVEFILE").val() != "#" && $("#IN_SOLUAPPROVEFILE").val() != "") {
            document.getElementById("Div3").style.display = "block";
            document.getElementById("SoluApproveFile").style.display = "none";
            $(".R_SoluApproveFile").show();
        }
        if ($("#IN_FINALSOLUTIONFILE").val() != "#" && $("#IN_FINALSOLUTIONFILE").val() != "") {
            document.getElementById("Div1").style.display = "block";
            document.getElementById("FinalSolutionFile").style.display = "none";
            $(".R_FinalSolutionFile").show();
        }
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
    function downloadWord(name, package) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=" + package;
        self.location.href = url;
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

    </script>
   
</body>
</html>

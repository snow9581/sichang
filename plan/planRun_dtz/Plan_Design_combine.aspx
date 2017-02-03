<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Plan_Design_combine.aspx.cs" Inherits="plan_planRun_dtz_changeform_Plan_Design_combine" %>

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
<body id="fullplan_design">
    <div id="p" class="easyui-panel" title="规划和设计阶段全部信息 " style="width:1000px;padding:10px;">
        <form id="form1" method="post" action="Plan_Design_combine.ashx" enctype="multipart/form-data" runat="server">
        <input type="hidden" value="1"  id="hd_index"  runat="server"/>
        <input type="hidden" value=""  id="userLevel"  runat="server"/>
        <input type="hidden" id="IN_FINALSOLUTIONFILE" value='' runat="server"/>
        <input type="hidden" id="IN_SOLUAPPROVEFILE" value='' runat="server"/>
        <input type="hidden" id="IN_DESICONDITIONTABLE" value='' runat="server"/> 
        <input type="hidden" id="IN_DESICONDITIONTABLE_N" value='' runat="server"/>
        <input type="hidden" id="IN_DESIAPPRFILE" value='' runat="server"/>
        <input type="hidden" id="IN_PLANARRIVALFILE" value='' runat="server"/>
        <input type="hidden" id="IN_BLUEGRAPHFILE" value='' runat="server"/> 
       
        <table class="dv-table" style="width:100%;margin-top :5px;text-align:center"cellpadding="5">
        <tr><td style="text-align:center"><font size="3" color="blue" >规划阶段</font></td></tr>
     <tr>
                <td>项目名称</td>
                <td><input id="PNAME" name="PNAME" class="easyui-validatebox textbox"  runat="server"/></td>
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
                <div id="Div1"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_FINALSOLUTIONFILE')">下载</div></td>
                <td></td>
                <td class="R_FinalSolutionFile"  style="display:none">重新上传最终方案</td>
                <td class="R_FinalSolutionFile" style="display:none"><input type="file" id="renewFINALSOLUTIONFILE" name="renewFINALSOLUTIONFILE" class="easyui-validatebox textbox" style=" width:150px" runat="server"/></td>
            </tr>
            <tr>
                <td>设计条件表</td>  
                <td><input type="file" id="DESICONDITIONTABLE"  name="DESICONDITIONTABLE" class="easyui-validatebox textbox" runat="server" style=" width:150px"/>
                <div id="Div2" runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_DESICONDITIONTABLE')">下载</div></td>
            </tr>
            <tr>
                <td>设计条件表(最后一次)</td>  
                <td><input type="file" id="DESICONDITIONTABLE_N"  name="DESICONDITIONTABLE_N" class="easyui-validatebox textbox" runat="server" style=" width:150px"/>
                <div id="Div4" runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_DESICONDITIONTABLE_N')">下载</div></td>
                <td></td>
                <td class="R_DESICONDITIONTABLE_N" style="display:none">重新上传设计条件表(最后一次)</td>
                <td class="R_DESICONDITIONTABLE_N" style="display:none"><input type="file" id="renewDESICONDITIONTABLE_N" name="renewDESICONDITIONTABLE_N" class="easyui-validatebox textbox" style=" width:150px"/></td>
            </tr>
            <tr>
                <td>方案批复</td>
                <td><input type="file" id="SoluApproveFile"  name="SoluApproveFile" class="easyui-validatebox textbox" runat="server" style=" width:150px"/> 
                <div id="Div3" runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_SOLUAPPROVEFILE')">下载</div></td>
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
           <%-- ////////以下为设计部分//////////--%>
           <tr><td style="text-align:center"><font size="3" color="blue" >设计阶段</font></td></tr>
            <tr>
                <td>项目设计负责人</td>
                <td><input id="DESICHIEF" name="DESICHIEF" class="easyui-validatebox textbox"  runat="server"/></td>
                <td></td>
                <td>主专业校对及室负责人</td>
                <td><input id="MAJORPROOFREADER" name="MAJORPROOFREADER" class="easyui-validatebox textbox" runat="server"/></td>
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
                <td>二次委托资料实际时间</td>
                <td><input id="SECONDCOMMISSIONDATE" name="SECONDCOMMISSIONDATE" class="easyui-datebox" runat="server"/></td>
            </tr>
            <tr>
                <td>施工图白图计划校审时间</td>
                <td><input id="WHITEGRAPHCHECKDATE_P" name="WHITEGRAPHCHECKDATE_P" class="easyui-datebox" runat="server"/></td>
                <td></td>
                <td>施工图白图实际校审时间</td>
                <td><input id="WHITEGRAPHCHECKDATE_R" name="WHITEGRAPHCHECKDATE_R" class="easyui-datebox" runat="server"/></td>
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
                <div id="Div5"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_DESIAPPRFILE')">下载</div></td>
                <td></td>
                <td class="R_DESIAPPRFILE"  style="display:none">重新上传设计批复下达</td>
                <td class="R_DESIAPPRFILE" style="display:none"><input type="file" id="DESIAPPRFILE_N" name="DESIAPPRFILE_N" class="easyui-validatebox textbox" style=" width:150px"/></td>      
            </tr>
            <tr>
                <td>计划下达文件</td>
                <td><input type="file" id="PLANARRIVALFILE" name="PLANARRIVALFILE" class="easyui-validatebox textbox" runat="server" style="width:150px"/>
                <div id="Div6"  runat="server"  style="text-align:center;border-bottom:1px solid #000;cursor:pointer;width:150px;display:none"  onclick="downloadWord('IN_PLANARRIVALFILE')">下载</div></td>
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
    $(function () {
        var width = ($(window).width() - 1000) * 0.5;
        $("#fullplan_design").css("margin-left", width); //使表单居中

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
    function downloadWord(name) {
        var wordname = document.getElementById(name).value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=archives";
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

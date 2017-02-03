<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DraftBudgetFile.aspx.cs" Inherits="plan_planRun_dtz_DraftBudgetFile" %>
<!--概算负责人进行概算编制-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div class="easyui-panel" title="概算编制" style="height:100%">
    <form id="ff" method="post" action="DraftBudgetFile.ashx" enctype="multipart/form-data" style="width:100%; height:95%">
    <input type="hidden" id="w_pid" runat="server"/>
    <input  type="hidden" id="WorkloadFlag"  runat="server"/>
     <input  type="hidden" id="hd_DraftBudgetFile" runat="server"/>
     <input id="PName" type="hidden" runat="server"/>
     <div class="MessageEnd" style=" display:none;padding:10px">
	    <span class="finish" style=" display:none">已提交的概算：<a href="#" onclick="downloadWord('hd_DraftBudgetFile')">下载</a></span>&nbsp;&nbsp;&nbsp;
        <span class="finish" style=" display:none">重新</span>提交概算：<input id="DraftBudgetFile" name="DraftBudgetFile" class="easyui-validatebox textbox" type="file" style="width:170px;" runat ="server"/>
        &nbsp;&nbsp;&nbsp;<a id="save" href="#" class="easyui-linkbutton" onclick="submitForm()">提交</a>
    </div>
    <table id="wl">
    <thead>    
        <tr>
            <th field="W_MAJOR"  width="200" sortable="true">专业单位</th>
            <th field="W_NAME"  width="200" sortable="true">姓名</th>
			<th data-options="field:'W_FILE',formatter:go" width="200">工作量提交</th>
			<th field="W_DATE"  width="200" sortable="true">提交时间</th>
		</tr>
    </thead>
    </table> 

    <div id="toolbar_wl">
        <span><label for="w_major">专业：</label></span><input class="easyui-textbox" id="w_major" value="" size='10'/>&nbsp;&nbsp;
        <span><label for="w_name">姓名：</label></span><input class="easyui-textbox" id="w_name" value="" size='10'/>&nbsp;&nbsp;
        <span>提交时间：</span><input name="KSRQ" id="KSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <span>--</span><input name="JSRQ" id="JSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_wl()">查询</a>
        <span style=" position:absolute; right:5px;"> 
        <label class="MessageNow" style=" display:none; color:Green; font-weight:bold; font-size:large;">正在提交工程量！</label>
        <label class="MessageEnd" style=" display:none; color:Red; font-weight:bold; font-size:large;">已结束提交工程量！</label>
        </span>
    </div> 
    </form>
</div>
<script type="text/javascript">
    $(function () {
        $('#wl').datagrid({
            title: $('#PName').val() + "->工程量",
            url: "./get_workLoad.ashx?w_pid=" + $('#w_pid').val(),
             fit: true,
             fitColumns: false,
             showFooters: true,
             collapsible: true,
             toolbar: "#toolbar_wl",
             pagination: "true",
             pageSize: 10,
             remoteSort: false,
             rownumbers: "true",
        });
        if ($("#hd_DraftBudgetFile").val() != "#" && $("#hd_DraftBudgetFile").val() != "" && $("#hd_DraftBudgetFile").val() != "undefined") {
            $(".finish").show();
        }
        if($('#WorkloadFlag').val()=="1")
            $(".MessageEnd").show();
        else
            $(".MessageNow").show();
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
    function downloadWord(file) {
               var wordname = document.getElementById(file).value;
               var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname+"&package=ftp_planfile";
               self.location.href = url;
           }
    function go(val, row) {
        if (row.W_FILE != '#' && row.W_FILE != '' && row.W_FILE != 'undefined')
            return '<a  href="../../crud_tables/downloadPic.aspx?picName=' + escape(row.W_FILE) + '&package=ftp_planfile" target="_blank">' + '下载' + '</a>  '
        else
            return ''
    }
    function FindData_wl() {
        $('#wl').datagrid('load', {
            w_major: $('#w_major').val(),
            w_name: $('#w_name').val(),
            KSRQ: $('#KSRQ').datebox('getValue'),
            JSRQ: $('#JSRQ').datebox('getValue')
        });
    }
    </script> 
</body>
</html>

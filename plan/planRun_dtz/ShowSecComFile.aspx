<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowSecComFile.aspx.cs" Inherits="plan_planRun_dtz_SubmitSecComFile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--显示二次委托资料--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div id="p" class="easyui-panel" title="二次委托资料" style="width:100%;height:100%;">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
    <input value="1" type="hidden" id="H_PName"  runat="server"/>
    <input value="1" type="hidden" id="userName"  runat="server"/>
    <div id="tool" style=" padding:10px">  
        <a id="Btn_submitCom" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="SubmitCom()">发送委托</a>
    </div>
	<table class="easyui-datagrid" style="width:100%;height:80%" data-options="title:$('#H_PName').val()+'->委托资料',url:'getCommission.ashx?PID='+$('#hd_id').val()+'&type=2',showFooters: true,pagination:true,pageSize: 10,fitColumns:true,singleSelect:true,remoteSort: false,rownumbers:true,sortName: 'RELEASERQ',sortOrder: 'desc'">
    <thead>    
        <tr>
            <th data-options="field:'CONSIGNERMAJOR',width:80">委托人专业</th>
			<th data-options="field:'CONSIGNER',width:150">委托人</th>
            <th data-options="field:'SENDEEMAJOR',width:80">接收人专业</th>
			<th data-options="field:'SENDEE',styler:SendeeColor,width:150">接收人</th>
            <th data-options="field:'FILES',formatter:download,width:150">委托资料文档</th>
			<th data-options="field:'RELEASERQ',width:150">委托时间</th>				
		</tr>
    </thead>
    </table>
</div>
<script type="text/javascript">
    function FindData_wt() {
        $('#wt').datagrid('load', {
            Find_SENDEE: $('#Find_SENDEE').val()
        });

    }
    function SubmitCom() {
            working('提交委托资料', 'SubmitCommission.aspx', $('#hd_id').val() + '&principal=0&type=2');
    }
    function download(val, row) {
        if (row.FILES != '#' && row.FILES != '' && row.FILES != undefined)
            return '<a href="../../datasubmit/downloadPic.aspx?picName=' + escape(row.FILES) + '&package=archives" target="_blank">' + '下载' + '</a>  '
        else
            return ''
    }
    function SendeeColor(val, row) {
        if (row.SENDEE == $("#userName").val()) {
            return 'color:green;'
        }
        else
            return ''
    }
    </script> 
</body>
</html>

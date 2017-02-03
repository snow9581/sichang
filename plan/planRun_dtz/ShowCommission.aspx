<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowCommission.aspx.cs" Inherits="plan_planRun_dtz_ShowCommission" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--显示委托资料--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

<form id="ff" runat="server" style="width:100%;height:80%" >
<input value="1" type="hidden" id="hd_id"  runat="server"/>
<input value="1" type="hidden" id="userName"  runat="server"/>
<input type="hidden" id="firstComFlag"  runat="server"/>
<input type="hidden" id="secondComFlag"  runat="server"/>
<input id="hd_type" type="hidden"  runat="server"/>
<table id="wt" class="easyui-datagrid" style="width:100%;height:100%" data-options="title:'委托资料',fit:true,url:'getCommission.ashx?PID='+$('#hd_id').val()+'&type='+$('#hd_type').val(),fitColumns:true,singleSelect:true,toolbar:'#tool',showFooters: true,pagination:true,pageSize: 10,remoteSort: false,rownumbers:true,sortName:'RELEASERQ',sortOrder:'desc'">
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
    
<div id="tool">  
    <span><label for="Find_SENDEE">接收人:</label></span><input class="easyui-textbox" id="Find_SENDEE" value="" size="10" /> 
    <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_wt()">查询</a>
    <span style=" position:absolute; right:5px;">
    <a id="Btn_endCommission" style=" display:none;" class="easyui-linkbutton" data-options="iconCls:'icon-no'" runat="server" onclick="Btn_endCommission_Click()">结束委托资料提交</a>
    <label id="Message" style=" display:none; color:Blue; font-weight:bold; font-size:large;">委托资料已结束提交！</label>
    </span>
</div> 
</form>

<script type="text/javascript">
    $(function () {
        if ($('#hd_type').val() == "1" && $('#firstComFlag').val() == "1") {
            $('#Message').show();
        }
        else if ($('#hd_type').val() == "2" && $('#secondComFlag').val() == "1") {
            $('#Message').show();
        }
        else {
            $('#Btn_endCommission').show();
        }
    });
    function Btn_endCommission_Click() {
        $.ajax({
            type: 'post',
            url: 'endSubmit.ashx',
            data: "HD_ID=" + $('#hd_id').val() + "&commissionflag=1&type=" + $('#hd_type').val(),
            success: function (msg) {
                $('#Message').show();
                $('#Btn_endCommission').hide();
            }
        });

    }
        ///方法说明：查询 
        /// <summary>     
        function FindData_wt() {
            $('#wt').datagrid('load', {
                Find_SENDEE: $('#Find_SENDEE').val()
            });

        }

        function SendeeColor(val, row) {
            if (row.SENDEE == $("#userName").val()) {
                return 'color:green;'
            }
            else
                return ''
        }
        function download(val, row) {
            if (row.FILES != '#' && row.FILES != '' && row.FILES != undefined)
                return '<a href="../../datasubmit/downloadPic.aspx?picName=' + escape(row.FILES) + '&package=archives" target="_blank">' + '下载' + '</a>  '
            else
                return ''
        }
    </script>
</body>
</html>

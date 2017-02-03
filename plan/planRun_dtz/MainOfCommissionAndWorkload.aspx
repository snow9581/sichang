<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainOfCommissionAndWorkload.aspx.cs" Inherits="plan_planRun_dtz_MainOfCommissionAndWorkload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div class="easyui-panel" title="委托资料&工程量 " style="height:100%" >
    <input type="hidden" value="1" id="hd_id" runat="server"/>
    <input type="hidden" value="1" id="commissionFlag" runat="server"/>
    <input type="hidden" value="1" id="selfWorkload" runat="server"/>
    <div style="padding:10px;">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('SubmitCommission.aspx','&type=1')">发送委托</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('ShowCommission.aspx','&type=1')">查看委托</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('WorkloadFile.aspx','')">提交工程量</a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('table_WorkLoadSubmit.aspx','')">查看工程量</a>
     </div>
     <div id="panel" class="easyui-panel" >
     </div>
</div>
<script type="text/javascript">
    $(function () {
        if ($('#commissionFlag').val() == "") {
            Jump('SubmitCommission.aspx','&type=1');
        }
        else if ($('#selfWorkload').val() == "0") {
            Jump('WorkloadFile.aspx','');
        }
        else {
            Jump('table_WorkLoadSubmit.aspx','');
        }
    });
    function Jump(url,data) {
        $('#panel').panel({
            fit:true,
            href: url+'?id='+$('#hd_id').val()+data
        });
    }
    
</script>
</body>
</html>

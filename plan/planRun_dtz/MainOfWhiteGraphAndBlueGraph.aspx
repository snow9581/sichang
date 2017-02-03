<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainOfWhiteGraphAndBlueGraph.aspx.cs" Inherits="plan_planRun_dtz_MainOfWhiteGraphAndBlueGraph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div class="easyui-panel" style="height:100%;" >
    <input type="hidden" value="1" id="hd_id" runat="server"/>
    <input type="hidden" value="1" id="SECONDCOMMISSIONDATE" runat="server"/>
    <input type="hidden" value="1" id="WHITEGRAPHCHECKDATE_R" runat="server"/>
    <div style="padding:10px;">
         <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('WhiteGraphCheck.aspx','')">白图校审</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('SubmitCommission.aspx','&type=2')">发送二次委托</a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('ShowCommission.aspx','&type=2')">查看二次委托</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('SubmitBlueGraph.aspx','')">提交蓝图</a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-application_view_list'" onclick="Jump('ShowBlueGraph.aspx','')">查看蓝图</a>
     </div>
     <div id="panel" class="easyui-panel" >
     </div>
</div>
<script type="text/javascript">
    $(function () {
        if ($('#WHITEGRAPHCHECKDATE_R').val() == "") {
            Jump('WhiteGraphCheck.aspx','');
        }
        else if ($('#SECONDCOMMISSIONDATE').val() == "") {
            Jump('ShowCommission.aspx','&type=2');
        }
        else {
            Jump('ShowBlueGraph.aspx','');
        }
    });
    function Jump(url,data) {
        $('#panel').panel({
            fit: true,
            href: url + '?id=' + $('#hd_id').val()+data
        });
    }
</script>
</body>
</html>

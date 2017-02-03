<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_measure_repair.aspx.cs" Inherits="show_calibrator_repair" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/export.js" type="text/javascript"></script>
</head>
<body>
    <input id="userLevel" runat="server" type="hidden"/>
    <div id="cc" class="easyui-layout">	
    <div data-options="region:'center'">
    <table id="dg" width="100%">
        <thead>
            <tr>
                <th data-options="field:'pic',width:9,align:'center',formatter:picformatter">状态</th>
                <th field="sbb" data-options="formatter:sqdformatter">查看申请单</th>
                <th field="wxd" data-options="formatter:wxdformatter">查看记录单</th>
				<th field="DW">申请单位</th>				
				<th field="CPUXH" width="30">CPU型号</th>
                <th field="XTLX" width="30">系统类别</th>
				<th field="GW" width="30">安装岗位</th>
                <th field="RQ" width="30" data-options="formatter:rqformatter">申请日期</th>               
                <th field="WXR" width="30">维修班组</th>
                <th field="WXJG" width="30">维修结果</th>
                <th field="CONTENT" width="30">拒绝原因</th>
			</tr>
        </thead>
    </table>
    </div>
    </div>
    <div id="toolbar">
        <a href="#" id="btn_new" runat="server" style=" visibility:hidden" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">发起</a>             
        <div id="searchtoolbar" runat="server">
            <span>矿名:</span><input name="KM" class="easyui-combobox"type="text" id="KM" value="" size=20/>       
            <span>时间：</span><input name="KSRQ" id="KSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
            <span>--</span><input name="JSRQ" id="JSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
            <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
            <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true"  onclick="return Save_Excel()" >导出</a> 
        </div>
    </div>
   
    
   

</body>
<script type="text/javascript">

    function wxdformatter(val, row) {
        var innerhtml = "<a href='#' onclick=\"show_wxd(" + row.ID + ")\">记录单</a>";
        return innerhtml;
    }
    function sqdformatter(val, row) {
        var innerhtml = "<a href='#' onclick=\"show_sqd(" + row.ID + "," + row.STATE + ")\">申请单</a>";
        return innerhtml;
    }

    function rqformatter(val, row) {
        var index = val.indexOf(' ');
        var innerhtml = val.substring(0, index);
        return innerhtml;
    }

    function picformatter(val, row) {
        var pp;
        if (row.workitem == '等待中') {
            pic = "../images/run.png";
            pp = "<a><img width='20px' height='20px' src='" + pic + "'/></a>";
        }
        else if (row.workitem == '通过') {
            pic = "../images/over.png";
            pp = "<a><img width='20px' height='20px' src='" + pic + "'/></a>";
        }
        else if (row.workitem == '不通过') {
            pic = "../themes/icons/cancel.png";
            pp = "<a><img width='20px' height='20px' src='" + pic + "'/></a>";
        }
        else {
            //当需要当前用户处理时，要么在申请单上操作，要么在记录单上操作。
            pic = "../images/work.png";
            //当状态为1或2时，在申请单上工作。
            if (row.STATE == '1' || row.STATE == '2')
                pp = "<a onclick=\"show_sqd('" + row.ID + "'," + row.STATE + ")\"><img width='20px' height='20px' src='" + pic + "'/></a>";
            //当状态为3或6时，在记录单上工作。
            if (row.STATE == '3' || row.STATE == '6')
                pp = "<a onclick=\"show_wxd(" + row.ID + ")\"><img width='20px' height='20px' src='" + pic + "'/></a>";
        }
        return pp;

    }
    function newItem() {
        $('#cc').layout('remove', 'north'); //刷新layout
        $('#cc').layout('add', {
            region: 'north',
            height: $(window).height() - 120,
            split: true,
            href: "select_measure.aspx"
        });
        //   $('#cc').layout('expand', 'north');
    }
    function show_wxd(hh) {
        $('#cc').layout('remove', 'north'); //刷新layout
        $('#cc').layout('add', {
            region: 'north',
            height: 290,
            split: true,
            href: "jldTable.aspx?ID=" + hh
        });
        //  $('#cc').layout('expand', 'north');
    }
    function show_sqd(state, hh) {

        $('#cc').layout('remove', 'north'); //刷新layout

        if (($("#userLevel").val() == "9" && hh == "1") || ($("#userLevel").val() == "2" && hh == "2")) {
            $('#cc').layout('add', {
                region: 'north',
                height: 210,
                split: true,
                href: "ensure_wxd.aspx?ID=s" + state
            });
        }
        else {
            $('#cc').layout('add', {
                region: 'north',
                height: 210,
                split: true,
                href: "ensure_wxd.aspx?ID=d" + state
            });
        }
        // $('#cc').layout('expand', 'north');
    }
    $(function Bind() {
        $('#KM').combobox({
            valueField: 'text', //值字段
            textField: 'text', //显示的字段
            url: '../tools/getKM.ashx',
            editable: true
        });
    });
    $(function () {
        $('#dg').datagrid({
            title: "现场故障维修流程总览",
            url: "get_measure_repair.ashx",
            fit: true,
            fitColumns: true,
            collapsible: true,
            toolbar: "#toolbar",
            pagination: "true",
            pageSize: 30,
            singleSelect: false,
            remoteSort: false,
            rownumbers: "true"
        });
        var userlevel = $("#userLevel").val();
        if (userlevel == '1')
            $("#btn_new").css('visibility', 'visible');
    });
    $(document).ready(function () {
        var height1 = $(window).height() - 20;
        $("#cc").attr("style", "width:100%;height:" + height1 + "px");
        $("#cc").layout("resize", {
            width: "100%",
            height: height1 + "px"
        });
    });
    $(window).resize(function () {
        var height1 = $(window).height() - 30;
        $("#cc").attr("style", "width:100%;height:" + height1 + "px");
        $("#cc").layout("resize", {
            width: "100%",
            height: height1 + "px"
        });
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
    ///方法说明：查询 
    /// </summary>     
    function FindData() {
        $('#dg').datagrid('load', {
            KM: $('#KM').combobox('getValue'), ///下拉框的获取数值方法*王钧泽学长1月14日            
            KSRQ: $('#KSRQ').datebox('getValue'),
            JSRQ: $('#JSRQ').datebox('getValue')
        });
    }
    ///<summary>
    ///方法说明:导出EXCEL功能
    ///2014.11.2  修复了传输数据时编码不一致导致参数出错的问题
    ///暂无创建时间查询方式
    ///</summary>  
    function Save_Excel() {
        var dwKM = $('#KM').combobox('getValue');
        window.open('ExportRepair.ashx?KM=' + dwKM + '&KSRQ=' + $('#KSRQ').datebox('getValue') + '&JSRQ=' + $('#JSRQ').datebox('getValue'));
    }
</script>
</html>
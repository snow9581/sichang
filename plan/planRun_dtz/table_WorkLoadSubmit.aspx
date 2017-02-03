<%@ Page Language="C#" AutoEventWireup="true" CodeFile="table_WorkLoadSubmit.aspx.cs" Inherits="plan_planRun_dtz_WorkLoadSubmit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--显示各专业提交的工程量--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title></title>
</head>
<body>
<form id="ff" runat="server" style="width:100%; height:80%">
  <table id="wl"  style="width:100%; height:100%">
        <thead>    
            <tr>
                <th field="W_MAJOR"  width="200" sortable="true">专业单位</th>
                <th field="W_NAME"  width="200" sortable="true">姓名</th>
				<th data-options="field:'W_FILE',formatter:go" width="200">工作量提交</th>
				<th field="W_DATE"  width="200" sortable="true">提交时间</th>
			</tr>
        </thead>
    </table>
    <input type="hidden" value="1" id="w_pid" runat="server"/>
    <div id="toolbar_wl">
        <span><label for="w_major">专业：</label></span><input class="easyui-textbox" id="w_major" value="" size='10'/>&nbsp;&nbsp;
        <span><label for="w_name">姓名:</label></span><input class="easyui-textbox" id="w_name" value="" size='10'/>&nbsp;&nbsp;
        <span>提交时间：</span><input name="KSRQ" id="KSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <span>--</span><input name="JSRQ" id="JSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_wl()">查询</a>
        <span style=" position:absolute; right:5px;">
        <a id="Btn_endWorkload" class="easyui-linkbutton" data-options="iconCls:'icon-no'" runat="server" onclick="Btn_endWorkload_Click()">结束工程量提交</a>
        </span>
     </div>
</form>
<script type="text/javascript">
    $(function () {
        $('#wl').datagrid({
            title: "查看工程量",
            url: "./get_workLoad.ashx?w_pid=" + $('#w_pid').val(),
            fit: true,
            fitColumns: false,
            showFooters: true,
            collapsible: true,
            toolbar: "#toolbar_wl",
            pagination: "true",
            pageSize: 10,
            sortName: 'W_DATE',               //排序字段
            sortOrder: 'asc',
            remoteSort: false,
            //multiSort:true,
            rownumbers: "true"
        });
    });

    ///方法说明：查询 
    /// </summary>     
    function FindData_wl() {
        $('#wl').datagrid('load', {
            w_major: $('#w_major').val(),
            w_name: $('#w_name').val(),
            KSRQ: $('#KSRQ').datebox('getValue'),
            JSRQ: $('#JSRQ').datebox('getValue')
        });
    }
    function go(val, row) {
        if (row.W_FILE != '#' && row.W_FILE != '' && row.W_FILE != undefined)
            return '<a  href="../../crud_tables/downloadPic.aspx?picName=' + escape(row.W_FILE) + '&package=ftp_planfile" target="_blank">' + '下载' + '</a>  '
        else
            return ''
    }
    function Btn_endWorkload_Click() {
        $.ajax({
            type: 'post',
            url: 'endSubmit.ashx',
            data: "HD_ID=" + $('#w_pid').val() + "&workloadflag=1",
            success: function (msg) {
                var strUrl = window.location.href;
                var arrUrl = strUrl.split("/");
                var strPage = arrUrl[arrUrl.length - 1].split("#");
                var page = strPage[0];
                self.location = page;
                parent.saveurl();
            }
        });

    }
    </script>
</body>
</html>

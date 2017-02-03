<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowBlueGraph.aspx.cs" Inherits="plan_planRun_dtz_ShowBlueGraph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--设计负责人提交蓝图--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
 <form id="ff" action="" style="width:100%; height:80%">
  <table id="wl"  style="width:100%; height:100%">
        <thead>    
            <tr>
                <th field="DESIGNSPECIAL"  width="200" sortable="true">专业单位</th>
                <th field="SPECIALPERSON"  width="200" sortable="true">姓名</th>
				<th data-options="field:'FILES',formatter:go" width="200">蓝图</th>
				<th field="DESIGNRQ"  width="200" sortable="true">提交时间</th>
                <th field="BZ"  width="200">备注</th>
			</tr>
        </thead>
    </table>
    <input id="PName" type="hidden" runat="server"/>
    <input id="b_pid" type="hidden" runat="server"/>
    <input type="hidden" id="blueGraphFlag"  runat="server"/>

    <div id="toolbar_wl">
        <span><label for="b_major">专业：</label></span><input class="easyui-textbox" id="b_major" value="" size='10'/>&nbsp;&nbsp;
        <span><label for="b_name">姓名:</label></span><input class="easyui-textbox" id="b_name" value="" size='10'/>&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_wl()">查询</a>
        <span style=" position:absolute; right:5px;">
       
        <a id="Btn_BlueGraph" style=" display:none;" class="easyui-linkbutton" data-options="iconCls:'icon-no'" runat="server" onclick="Btn_endWorkload_Click()">结束蓝图提交</a>
        <label id="Message" style=" display:none; color:Blue; font-weight:bold; font-size:large;">蓝图已结束提交！</label>
        </span>
     </div>
</form>
<script type="text/javascript">
    $(function () {
        $('#wl').datagrid({
            title:$('#PName').val()+"->蓝图",
            url: "./get_blueGraph.ashx?b_pname=" + $('#PName').val(),
            fit: true,
            fitColumns: false,
            showFooters: true,
            collapsible: true,
            toolbar: "#toolbar_wl",
            pagination: "true",
            pageSize: 10,
            sortName: 'DESIGNRQ',               //排序字段
            sortOrder: 'asc',
            remoteSort: false,
            //multiSort:true,
            rownumbers: "true"
        });

        if ($('#blueGraphFlag').val() == "1") {
            $('#Message').show();
        }
        else {
            $('#Btn_BlueGraph').show();
        }
    });

    ///方法说明：查询 
    /// </summary>     
    function FindData_wl() {
        $('#wl').datagrid('load', {
            b_major: $('#b_major').val(),
            b_name: $('#b_name').val()
        });
    }
    function go(val, row) {
        // 高俊涛修改 2014-09-07 将文件名隐藏为下载
        if (row.FILES != '#' && row.FILES != '' && row.FILES != undefined)
            return '<a  href="../../crud_tables/downloadPic.aspx?picName=' + escape(row.FILES) + '&package=archives" target="_blank">' + '下载' + '</a>  '
        else
            return ''
    }
    function Btn_endWorkload_Click() {
        //alert("11");
        $.ajax({
            type: 'post',
            url: 'endSubmit.ashx',
            data: "HD_ID=" + $('#b_pid').val() + "&blueGraphflag=1",
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
    </script>
</body>
</html>

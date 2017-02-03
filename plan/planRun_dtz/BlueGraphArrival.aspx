<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlueGraphArrival.aspx.cs" Inherits="plan_planRun_dtz_BlueGraphArrival" %>
<%--记录蓝图下发时间--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
 <form id="ff" runat="server" style="width:100%; height:100%">
  <table id="wl"  style="width:100%; height:100%">
        <thead>    
            <tr>
                <th field="DESIGNSPECIAL"  width="150" sortable="true">专业单位</th>
                <th field="SPECIALPERSON"  width="150" sortable="true">姓名</th>
				<th data-options="field:'FILES',formatter:go" width="100">蓝图</th>
				<th field="DESIGNRQ"  width="200" sortable="true">提交时间</th>
                <th field="BZ"  width="200">备注</th>
                <th field="ARRIVALDATE"  width="200" data-options="formatter:formatterArrivalDate">蓝图下发时间</th>
			</tr>
        </thead>
    </table>
    <input id="PName" type="hidden" runat="server"/>
    <input type="hidden" id="blueGraphFlag"  runat="server"/>
    <input id="PID" type="hidden" runat="server"/>
    <div id="toolbar_wl">
        <span><label for="b_major">专业：</label></span><input class="easyui-textbox" id="b_major" value="" size='10'/>&nbsp;&nbsp;
        <span><label for="b_name">姓名:</label></span><input class="easyui-textbox" id="b_name" value="" size='10'/>&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData_wl()">查询</a>
        <span style=" position:absolute; right:5px;">

        <label id="start_Message" style=" display:none; color:Blue; font-weight:bold; font-size:medium;">蓝图正在提交！</label>
        <label id="end_Message" style=" display:none; color:Blue; font-weight:bold; font-size:medium;">蓝图已结束提交！</label>
        </span>
     </div>
</form>
<script type="text/javascript">
    $(function () {
        $('#wl').datagrid({
            title: $('#PName').val() + "->蓝图",
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
            $('#end_Message').show();
        }
        else {
            $('#start_Message').show();
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

    function ArrivalBlueGraph(rowIndex, ID) {
        $("#BtnArrivalBlue" + rowIndex).removeAttr("onclick");//防止多次点击事件
        var rowNum = 0;
        var flag = false;//判断是否只剩一条记录
        var rows = $('#wl').datagrid('getRows');
        for (var i = 0; i < rows.length ; i++) {
            if (rows[i].ARRIVALDATE != undefined && rows[i].ARRIVALDATE != "" && rows[i].ARRIVALDATE != null && i != rowIndex)//统计所有已下发的蓝图数
                rowNum++;
        }
        if (rowNum == rows.length - 1)
            flag = true;
        $.ajax({
            type: "post",
            url: "BlueGraphArrival.ashx",
            data: { BID: ID, endFlag: flag ,PID:$("#PID").val()},
            dataType: 'text',
            success: function (data) {
                if (data != "0") {
                    $('#wl').datagrid('updateRow', {
                        index: rowIndex,
                        row: {
                            ARRIVALDATE: data
                        }
                    });
                    if (flag == true) {
                        var strUrl = window.location.href;
                        var arrUrl = strUrl.split("/");
                        var strPage = arrUrl[arrUrl.length - 1].split("#");
                        var page = strPage[0];
                        self.location = page;
                        parent.saveurl();
                    }
                }
                else
                    alert("提交失败！");
            }
        });
        
    }
    function formatterArrivalDate(val, row) {
        var index = parseInt($('#wl').datagrid("getRowIndex", row));
        if (row.ARRIVALDATE != '' && row.ARRIVALDATE != undefined && row.ARRIVALDATE != null)
            return row.ARRIVALDATE;
        else
            return '<input id="BtnArrivalBlue' + index + '" type="button" value="下发蓝图" onclick="ArrivalBlueGraph(' + index + ',' + row.ID + ')" />';
    }
    </script>
</body>
</html>

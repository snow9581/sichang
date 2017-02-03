<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ensure_meter.aspx.cs" Inherits="Instrument_Table" %>
<!--发起仪表检定时，确认需要检定的仪表信息操作界面-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../../js/export.js" type="text/javascript"></script>
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

        $(function () {
            var p = $("#url").val();
            var url_p = "get_selected_meter.ashx?ID=" + p;
            $('#dg').datagrid({
                title: "填写外送仪表检定申报表-确认仪表信息",
                url: url_p,
                fit: true,
                fitColumns: true,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar",
                remoteSort: false,
                //multiSort:true,
                rownumbers: "true",
                view: detailview,

                detailFormatter: function (index, row) {
                    return '<div class="ddv"></div>';
                },
                onExpandRow: function (index, row) {
                    var id = "";
                    if (row.ID != null)
                        id = row.ID;
                    var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                    ddv.panel({
                        border: false,
                        cache: true,
                        href: 'input_ensure_meter.aspx?index=' + index + '&JDRQ=' + $("#dg").datagrid('getRows')[index].JDRQ,
                        onLoad: function () {
                            $('#dg').datagrid('fixDetailRowHeight', index);
                            $('#dg').datagrid('selectRow', index);
                            $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                        }
                    });
                    $('#dg').datagrid('fixDetailRowHeight', index);
                }
            });
        });
        function saveItem(index, JLQJMC, GGXH, JLLB, JDZQ, JDDJ, SL, JDRQ, SYDW, JDDW, JDFS, E_JDDJ , E_JDFYHJ, SM) {
            $('#dg').datagrid('collapseRow', index);
            $('#dg').datagrid('updateRow', {
                index: index,
                row: { JLQJMC: JLQJMC,
                       GGXH: GGXH,
                       JLLB: JLLB,
                       JDZQ: JDZQ,
                       JDDJ: JDDJ,
                       SL: SL,
                       JDRQ: JDRQ,
                       SYDW: SYDW,
                       JDDW: JDDW,
                       JDFS: JDFS,
                       E_JDDJ: E_JDDJ,
                       E_JDFYHJ: E_JDFYHJ,
                       SM: SM }
            });
        }
        function submitItem() {
            var item = "";
            var rows = $("#dg").datagrid("getRows");
            if (rows.length == 0)
            {
                alert('请输入数据');
                return;
            }
            if ($("#BM").val() == "") {
                alert('申请表表名填写不完全');
                return;
            }
            for (var i = 0; i < rows.length; i++) {
                item += rows[i].JLQJMC + ",";
                item += rows[i].GGXH + ",";
                item += rows[i].JLLB + ",";
                item += rows[i].JDZQ + ",";
                item += rows[i].JDDJ + ",";
                item += rows[i].SL + ",";
                item += rows[i].JDRQ + ",";
                item += rows[i].SYDW + ",";
                item += rows[i].JDDW + ",";
                item += rows[i].JDFS + ",";
                item += rows[i].E_JDDJ + ",";
                item += rows[i].E_JDFYHJ + ",";
                item += rows[i].SM + ",";
            }
            item += $("#BM").val();
            var aj = $.ajax({
                url: encodeURI(encodeURI("submit_meter_information.ashx?Item=" + item)), // 跳转到 action  
                type: 'post',
                success: function (data) {
                    if (data == "1")
                        alert("操作成功！");
                    else
                        alert("操作失败，请稍后再试！");
                    self.location.href = "show_meter_check.aspx";
                },
                error: function () {
                    alert("操作失败，请稍后再试！");
                }
            });
        }
        function judge() {
            if ($("#BM").val() == "请输入申报表名")
                $("#BM").val("");
        }
        function cancelItem(index) {
            var row = $('#dg').datagrid('getRows')[index];
            if (row.isNewRecord) {
                $('#dg').datagrid('deleteRow', index);
            } else {
                $('#dg').datagrid('collapseRow', index);
            }
        }
        function destroyItem() {
            var rows = $('#dg').datagrid("getChecked");
            for (var i = 0; i < rows.length; i++) {
                var x=$('#dg').datagrid('getRowIndex', rows[i])
                $('#dg').datagrid('deleteRow', x);  //在删除数据成功后清空所有的已选择项
            }
        }
        function goBack() {
            location.href = "select_meter.aspx?id=" + $("#url").val();
        }
        function newItem() {
            $('#dg').datagrid('appendRow', { isNewRecord: true });
            var index = $('#dg').datagrid('getRows').length - 1;
            $('#dg').datagrid('expandRow', index);
            $('#dg').datagrid('selectRow', index);
        }
    </script>
    <style type="text/css">
        #BM
        {
            width: 237px;
        }
    </style>
</head>
<body>
    <input id="fromid" runat="server" type="hidden"/>
    <input id="url" runat="server" type="hidden"/>
    <input id="userLevel" runat="server" type="hidden"/>
    <input id="dm" runat="server" type="hidden"/>
    <table id="dg" style=" width:100%">
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="JLQJMC"   width="13" >计量器具名称</th>
				<th field="GGXH"   width="10">规格型号</th>
				<th field="JLLB"  width="10" >管理类别</th>				
				<th field="JDZQ"   width="10" >检定周期</th>
				<th field="JDDJ"  width="10" >准确度等级</th>
                <th field="SL"  width="8" >数量</th>
                <th field="JDRQ"  width="15" >计划检定日期</th>
                <th field="SYDW"  width="20" >计量器具使用单位</th>
                <th field="JDDW"  width="20" >计量器具检定单位</th>
                <th field="E_JDDJ"  width="15" >鉴定单价(元)</th>
                <th field="E_JDFYHJ"  width="15" >检定费用合计(元)</th>
                <th field="SM"  width="10" >备注</th>
			</tr>
        </thead>
    </table>
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">增添仪表</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">移除仪表</a>
        <a href="#" id="btn_submit" class="easyui-linkbutton" iconcls="icon-ok" plain="true" onclick="submitItem()">确定</a>
        <a href="#" id="btn_back" class="easyui-linkbutton" iconcls="icon-back" plain="true" onclick="goBack()">返回</a>
        <div style=" text-align:center;">
        <label>第四采油厂</label>
        <input id="BM" name="BM" style=" width:15px; text-align:center" value="" class="easyui-validatebox"/>
        <label>月份外送仪表检定申请表</label>
        </div>
    </div>
</body>
</html>

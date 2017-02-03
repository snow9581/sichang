<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qrdTable.aspx.cs" Inherits="ybManage_Instrument_FinishStateTable" %>
<!--确认单操作界面-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
</head>
<body>
    <input id="userLevel" runat="server" type="hidden"/>
    <input id="dm" runat="server" type="hidden"/>
    <input id="fromid" runat="server" type="hidden"/>
    <input id="TITLE" runat="server" type="hidden"/>
    <input id="BM" runat="server" type="hidden"/>
    <input id="STATE" runat="server" type="hidden"/>
    <table id="dg2">
        <thead>
            <tr>
			</tr>
        </thead>
    </table>
    <div id="toolbar2">
        <a href="#" id="save" runat="server" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>        
        <a href="#" id="add" runat="server" class="easyui-linkbutton" iconCls="icon-add" onclick="newItem()" plain="true">新建</a>
        <a href="#" id="cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">关闭</a>            
    </div>
    <script type="text/javascript"> 
        function computeHJ(index)
        {
            var count = parseInt($("#JDHGSL" + index).val());
            var price = parseInt($("#dj" + index).val());
            $("#hj"+index).val(count*price);
        }
        $(function () {
            var width = document.body.clientWidth - 2;
            var colwidth = width / 10;
            var x = $('#dg2').datagrid({
                title: "完成情况确认单",
                url: "get_qrdTable.ashx?FROMID=" + $('#fromid').val(),
                fit: true,
                fitColumns: true,
                toolbar: "#toolbar2",
                rownumbers: "true",
                view: detailview,
                detailFormatter: function (index, row) {
                    return '<div class="ddv"></div>';
                },
                columns: [[
                { title: $('#BM').val(), colspan: 10 }
                ], [
                { title: $('#TITLE').val(), colspan: 10 }
                ], [
                    { align: 'center', field: 'JLQJMC', title: '计量器具名称', width: colwidth, styler: function (val, row) {
                        if (row.TYPE == '3')
                            return 'background-color:#F1F1F1';
                    }
                    },
                    { align: 'center', field: 'GGXH', title: '规格型号', width: colwidth, styler: function (val, row) {
                        if (row.TYPE == '3')
                            return 'background-color:#F1F1F1';
                    }
                    },
                    { align: 'center', field: 'JLLB', title: '管理类别', width: colwidth, styler: function (val, row) {
                        if (row.TYPE == '3')
                            return 'background-color:#F1F1F1';
                    }
                    },
                    { align: 'center', field: 'JDWCSL', title: '检定完成数量', width: colwidth, styler: function (val, row) {
                        if (row.TYPE == '3')
                            return 'background-color:#F1F1F1';
                    }
                    },
                    {
                        align: 'center', field: 'JDHGSL', title: '检定合格数量', width: colwidth, formatter: function (val, row, index) {
                            if ($('#STATE').val() != "5")
                                return "<input style=\"width:80px;\" id=\"JDHGSL" + index + "\"  value=\"" + val + "\" class=\"easyui-validatebox\"/>";
                            else
                                return val;
                        }
                    },
                    { align: 'center', field: 'JLQJSYDW', title: '计量器具使用单位', width: colwidth },
                    { align: 'center', field: 'JLQJJDDW', title: '计量器具检定单位', width: colwidth },
                    { align: 'center', field: 'JDDJ', title: '检定单价(元)', width: colwidth, formatter: function (val, row, index) {
                        if ($('#STATE').val() != "5"&&(($('#userLevel').val() == '6') || $('#userLevel').val() == '1'))
                            return "<input style=\"width:80px;\" onchange=\"computeHJ('" + index + "');\"  value=\"" + val + "\" id=\"dj" + index + "\" class=\"easyui-validatebox\"/>";
                        else
                            return val;
                    }, styler: function (val, row) {
                        if (row.TYPE == '3')
                            return 'background-color:#F1F1F1';
                    }
                    },
                    { align: 'center', field: 'JDFYHJ', title: '检定费用合计(元)', width: colwidth, formatter: function (val, row, index) {
                        if ($('#STATE').val() != "5" && (($('#userLevel').val() == '6') || $('#userLevel').val() == '1'))
                            return "<input style=\"width:80px;\" id=\"hj" + index + "\" value=\"" + val + "\" class=\"easyui-validatebox\"/>";
                        else
                            return val;
                    }, styler: function (val, row) {
                        if (row.TYPE == '3')
                            return 'background-color:#F1F1F1';
                    }
                    },
                    { align: 'center', field: 'TSQKSM', title: '特殊情况说明', width: colwidth, formatter: function (val, row, index) {
                        if ($('#STATE').val() != "5")
                            return "<input style=\"width:80px;\" id=\"TSQKSM" + index + "\"  value=\"" + val + "\" class=\"easyui-validatebox\"/>";
                        else
                            return val;
                    }, styler: function (val, row) {
                        if (row.TYPE == '3')
                            return 'background-color:#F1F1F1';
                    }
                    }
                ]],
                onLoadSuccess: function () {
                    setTimeout("move()", 500);
                    merge();
                },
                onResizeColumn: function () {
                    merge();
                }
            });

            $("#cancel").click(function () {
                $('#cc').layout('remove', 'north');
            });
            $("#save").click(function () {
                var rows = $('#dg2').datagrid('getRows');
                var length = rows.length;
                var IDs = '';
                var dj = '';
                var hj = '';
                var JDHGSL = '';
                var TSQKSM = '';
                for (var i = 0; i < length; i++) {
                    IDs += rows[i].ID + ',';
                    dj += $("#dj" + i.toString()).val() + ',';
                    hj += $("#hj" + i.toString()).val() + ',';
                    JDHGSL += $("#JDHGSL" + i.toString()).val() + ',';
                    TSQKSM += $("#TSQKSM" + i.toString()).val() + ',';
                }
                dj = dj.substring(0, dj.length - 1);
                hj = hj.substring(0, hj.length - 1);
                JDHGSL = JDHGSL.substring(0, JDHGSL.length - 1);
                TSQKSM = TSQKSM.substring(0, TSQKSM.length - 1);
                IDs = IDs.substring(0, IDs.length - 1);
                var aj = $.ajax({
                    url: encodeURI("submitPrice.ashx?fromid=" + $("#fromid").val() + "&id=" + IDs + "&dj=" + dj + "&hj=" + hj + "&JDHGSL=" + JDHGSL + "&TSQKSM=" + TSQKSM), // 跳转到 action  
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
            });
        });

        function merge() {
            var location = -1;
            var rows = $('#dg2').datagrid('getRows');
            for (var i = 0; i < rows.length; i++)
                if (rows[i].TYPE == '3')
                    location = i;
            for (var i = location; i < rows.length; i++) {
                $('#dg2').datagrid('mergeCells', {
                    index: i,
                    field: 'JDWCSL'
                });
            }
        }
        function move() {
            $("div[class='datagrid-view1']").css("width", $("div[class='datagrid-view1']").css("width"));
            $("div[class='datagrid-view2']").css("width", $("div[class='datagrid-view2']").css("width"));
            $("div[class='datagrid-header']").css("width", $("div[class='datagrid-view2']").css("width"));
            $("div[class='datagrid-body']").css("width", $("div[class='datagrid-view2']").css("width"));
            $("div[class='datagrid-footer']").css("width", $("div[class='datagrid-view2']").css("width"));
        }
        function newItem() {
            $("#add").removeAttr("onclick");
            $('#dg2').datagrid('appendRow', { isNewRecord: true });
            var index = $('#dg2').datagrid('getRows').length - 1;
            $('#dg2').datagrid('expandRow', index);
            $('#dg2').datagrid('selectRow', index);
            var ddv = $('#dg2').datagrid('getRowDetail', index).find('div.ddv');
            ddv.panel({
                border: false,
                cache: true,
                href: 'input_qrd2.aspx?index=' + index,
                onLoad: function () {
                    $('#dg2').datagrid('fixDetailRowHeight', index);
                    $('#dg2').datagrid('selectRow', index);
                    $('#dg2').datagrid('getRowDetail', index).find('form').form('load', row);
                }
            });
            $('#dg2').datagrid('fixDetailRowHeight', index);
            move();
        }
        function cancelItem(index) {
            var row = $('#dg2').datagrid('getRows')[index];
            $('#dg2').datagrid('deleteRow', index);
            $('#add').attr("onclick", "newItem()");
        }
        function saveItem(index) {
            var JLQJMC = $('#JLQJMC').val();
            var GGXH = $('#GGXH').val();
            var JLLB = $('#JLLB').val();
            var JDWCSL = $('#JDWCSL').val();
            var JDDJ = $('#JDDJ').val();
            var JDFYHJ = $('#JDFYHJ').val();
            var TSQKSM = $('#TSQKSM').val();
            var FROMID = $('#fromid').val();
            $('#add').attr("onclick", "newItem()");
            var row = $('#dg2').datagrid('getRows')[index];
            var url = 'insert_qrd2.ashx?FROMID=' + FROMID;
//            var url = 'insert_qrd2.ashx?FROMID=' + FROMID + '&JLQJMC=' + JLQJMC + '&GGXH=' + GGXH + '&JLLB=' + JLLB + '&JDWCSL=' + JDWCSL + '&JDDJ=' + JDDJ + '&JDFYHJ=' + JDFYHJ + '&TSQKSM=' + TSQKSM;
            $('#dg2').datagrid('getRowDetail', index).find('form').form('submit', {
                url: url,
                onSubmit: function () {
                    $("#save2").removeAttr("onclick");
                    return $(this).form('validate');
                },
                success: function (data) {
                    if (data == "0")
                        $('#dg2').datagrid('deleteRow', index);
                    else {
                        $('#dg2').datagrid('collapseRow', index);
                        $('#dg2').datagrid('updateRow', {
                            index: index,
                            row: {
                                JLQJMC: JLQJMC,
                                GGXH: GGXH,
                                JLLB: JLLB,
                                JDWCSL: JDWCSL,
                                JDDJ: JDDJ,
                                JDFYHJ: JDFYHJ,
                                TSQKSM: TSQKSM
                            }
                        });
                        merge();
                        move();
                    }
                }
            });
        }
    </script>
</body>
</html>

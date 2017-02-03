<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ensure_wxd.aspx.cs" Inherits="ensure_wxd" %>

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
    <input id="ID" runat="server" type="hidden"/>
    <input id="USERLEVEL" runat="server" type="hidden"/>
    <table id="dg2">
    </table>
    <div id="toolbar2">
        <a href="#" id="ok" class="easyui-linkbutton" iconCls="icon-ok" plain="true">提交</a>
        <input name="wxr" id="wxr" class="easyui-combobox" data-options=" valueField: 'text', textField: 'text',url: 'get_banzu.ashx'"/>
        <a href="#" runat="server" id="agree" class="easyui-linkbutton" iconCls="icon-ok" plain="true">同意</a>
        <a href="#" runat="server" id="disagree" class="easyui-linkbutton" iconCls="icon-no" plain="true">不同意</a>
        <a href="#" id="cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">关闭</a>
    </div>
    <style type="text/css">   
        .datagrid-header {position: absolute; visibility: hidden;}
    </style>
    
    <script type="text/javascript">
        // 无：
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
            var ID = $("#ID").val();
            var userlevel = $("#USERLEVEL").val();
            var width = document.body.clientWidth - 2;
            var colwidth = width / 7;
            if (ID[0] != 's' && ID[0] != 'd') {
                $("#agree").remove();
                $("#disagree").remove();
                $("#wxr").remove();
            }
            else if (ID[0] == 's' && (userlevel == "2" || userlevel == "9")) {
                if (userlevel == "2") {
                    $("#agree").html("同意并指派");
                }
                else
                    $("#wxr").remove();

                $("#ok").remove();
            }
            else {
                $("#agree").remove();
                $("#disagree").remove();
                $("#ok").remove();
                $("#wxr").remove();
            }
            $('#dg2').datagrid({
                title: "故障申请单",
                url: "get_ensure_wxd.ashx?ID=" + $("#ID").val(),
                toolbar: "#toolbar2",
                rownumbers: false,
                nowrap: false,
                columns: [[
                    { align: 'center', field: 'f1', title: 'f1', width: colwidth, formatter: function (val, row, index) {
                        return val;
                    }, styler: function (val, row, index) {
                        return 'background-color:#F1F1F1';
                    }
                    },
                    {
                        align: 'left', field: 'f2', title: 'f2', width: colwidth, formatter: function (val, row, index) {
                            if (ID[0] != 's' && ID[0] != 'd') {
                                if (index == "1")
                                    return "<input style=\"width:colwidth;\" id=\"DW\"  value=\"" + val + "\" class=\"easyui-validatebox\"/>";
                                else if (index == "2")
                                //  return "<input style=\"width:colwidth;\" id=\"YBMC\" value=\"" + val + "\" class=\"easyui-validatebox\"/>";
                                    return "<input style=\"width:colwidth;\" id=\"GGXH\" value=\"" + val + "\" class=\"easyui-validatebox\"/>";
                                else if (index == "3")
                                //return "<input id=\"GZXX\" class=\"easyui-validatebox\"/>";
                                    return "<textarea id=\"GZXX\" rows=\"2\" cols=\"120\"></textarea>";
                            }

                            else
                                return val;
                        }
                    },
                    { align: 'center', field: 'f3', title: 'f3', width: colwidth, formatter: function (val, row, index) {
                        return val;
                    }, styler: function (val, row, index) {
                        if (index != "3" && index != "0")
                            return 'background-color:#F1F1F1';
                    }
                    },
                    {
                        align: 'left', field: 'f4', title: 'f4', width: colwidth, formatter: function (val, row, index) {
                            if (ID[0] != 's' && ID[0] != 'd') {
                                if (index == "1") {
                                    return "<input style=\"width:colwidth;\" id=\"YBMC\" value=\"" + val + "\" class=\"easyui-validatebox\"/>";
                                    // return "<input style=\"width:colwidth;\" id=\"GGXH\" value=\"" + val + "\" class=\"easyui-validatebox\"/>";                     
                                }
                                else if (index == "2") {
                                    return "<input id=\"RQ\" type=\"text\" class=\"easyui-datebox\">";
                                }
                            }
                            else
                                return val;
                        }
                    },
                    { align: 'center', field: 'f5', title: 'f5', width: colwidth, formatter: function (val, row, index) {
                        return val;

                    }, styler: function (val, row, index) {
                        if (index != "3" && index != "0")
                            return 'background-color:#F1F1F1';
                    }
                    },
                    {
                        align: 'left', field: 'f6', title: 'f6', width: colwidth * 1.5, formatter: function (val, row, index) {
                            if (ID[0] != 's' && ID[0] != 'd') {
                                if (index == "1")
                                    return "<input style=\"width:colwidth;\" id=\"AZWZ\" value=\"" + val + "\" class=\"easyui-validatebox\"/>";
                                //else if (index == "2")
                                // return "<input id=\"RQ\" type=\"text\" class=\"easyui-datebox\">";
                            }
                            else
                                return val;
                        }
                    }
                ]],
                onLoadSuccess: function () {
                    merge();
                    $('#RQ').datebox();
                },
                onResizeColumn: function () {
                    merge();
                },
                onClickRow: function (rowIndex, rowData) {
                    $(this).datagrid('unselectRow', rowIndex);
                }
            });
            $("#cancel").click(function () {
                $('#cc').layout('remove', 'north');
            });
            $("#disagree").click(function () {
                $.messager.confirm("操作提示", "您确定要驳回吗？", function (data) {
                    if (data) {
                        $.messager.prompt("操作提示", "请输入您不同意的原因", function (data) {
                            var aj = $.ajax({
                                url: encodeURIComponent(encodeURIComponent("disagree.ashx?CONTENT=" + data + "&ID=" + $("#ID").val())),
                                type: 'post',
                                success: function (data) {
                                    alert("操作成功！");
                                    self.location.href = "show_measure_repair.aspx";
                                },
                                error: function () {
                                    alert("操作失败，请稍后再试！");
                                }
                            });
                        });
                    }
                });
            });
            $("#agree").click(function () {
                if (userlevel == "2") {
                    var aj = $.ajax({
                        url: encodeURI(encodeURI("agree.ashx?wxr=" + $("#wxr").combobox('getValue').toString() + "&ID=" + $("#ID").val())),
                        type: 'post',
                        success: function (data) {
                            if (data == "1")
                                alert("操作成功！");
                            else
                                alert("操作失败，请稍后再试！");
                            self.location.href = "show_measure_repair.aspx";
                        },
                        error: function () {
                            alert("操作失败，请稍后再试！");
                        }
                    });
                }
                else {
                    var aj = $.ajax({
                        url: encodeURI(encodeURI("agree.ashx?ID=" + $("#ID").val())),
                        type: 'post',
                        success: function (data) {
                            if (data == "1")
                                alert("操作成功！");
                            else
                                alert("操作失败，请稍后再试！");
                            self.location.href = "show_measure_repair.aspx";
                        },
                        error: function () {
                            alert("操作失败，请稍后再试！");
                        }
                    });
                }
            });
            $("#ok").click(function () {
                var DW = $("#DW").val();
                var WXLX = $("#WXLX").val();
                var AZWZ = $("#AZWZ").val();
                var YBMC = $("#YBMC").val();
                var GGXH = $("#GGXH").val();
                var RQ = $("#RQ").datebox('getValue');
                var GZXX = $("#GZXX").val();
                var str = DW + "," + WXLX + "," + AZWZ + "," + YBMC + "," + GGXH + "," + RQ + "," + GZXX;
                var aj = $.ajax({
                    url: encodeURI(encodeURI("submit_wxd.ashx?str=" + str)), // 跳转到 action  
                    type: 'post',
                    success: function (data) {
                        if (data == "1")
                            alert("操作成功！");
                        else
                            alert("操作失败！");
                        self.location.href = "show_measure_repair.aspx";
                    },
                    error: function (data) {
                        alert("操作失败，请稍后再试！" + data);
                    }
                });
            });
            //  setTimeout("$('#RQ').datebox();", 1000);          
        });

        ///end of $
        function merge() {
         
            $('#dg2').datagrid('mergeCells', {
                index: 0,
                field: 'f1',
                colspan: 6
            });
            $('#dg2').datagrid('mergeCells', {
                index: 3,
                field: 'f2',
                colspan: 5
            });
            $("#GZXX").css("width", (document.body.clientWidth - 2)/2);
        }
    </script>
</body>
</html>

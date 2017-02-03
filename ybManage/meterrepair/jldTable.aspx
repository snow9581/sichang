<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jldTable.aspx.cs" Inherits="ybManage_meterrepair_jldTable" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
    <input id="USERNAME" runat="server" type="hidden"/>
    <input id="WXR" runat="server" type="hidden"/>
    <input id="DW" runat="server" type="hidden"/>
    <input id="WXR_NAME" runat="server" type="hidden"/>
    <input id="SCDW_NAME" runat="server" type="hidden"/>


    <table id="dg2" style="height:auto;">
    </table>
    <div id="toolbar2">
        <a href="#" id="ok" runat="server" class="easyui-linkbutton" iconCls="icon-ok" plain="true">提交</a>
        <a href="#" id="jlyok" runat="server" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确认</a>
        <a href="#" id="jlyrefuse" runat="server" class="easyui-linkbutton" iconCls="icon-ok" plain="true">拒绝</a>
        <a href="#" id="save" runat="server" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>        
        <a href="#" id="cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">关闭</a>
    </div>
    <style type="text/css">   
        .datagrid-header {position: absolute; visibility: hidden;}
    </style>
    <script type="text/javascript">

        var is_wxr_name_exist = false;//在数据库中维修人是否已签名？
        var is_scdw_name_exist = false;//在数据库中生产单位是否已签名?

        $(function () {
            var width = document.body.clientWidth - 2;
            var colwidth = width / 7;
            var halfcolwidth = colwidth / 2;

            if ($('#WXR_NAME').val() != "") is_wxr_name_exist = true;
            
            if ($('#SCDW_NAME').val() != "") is_scdw_name_exist = true;

 
            $('#dg2').datagrid({
                title: "仪器仪表维修记录单",
                url: "get_jld.ashx?ID=" + $("#ID").val(),
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
                    { align: 'left', field: 'f2', title: 'f2', width: colwidth, formatter: function (val, row, index) {
                        if (index == "4" && val == "")
                            return "<input style=\"width:colwidth;\" id=\"WXDW\"  value=\"仪表室\" class=\"easyui-validatebox\"/>";
                        else if (index == "5")
                            //return "<input id=\"WXNR\" class=\"easyui-validatebox\"/>";
                            return "<textarea id=\"WXNR\" name=\"WXNR_\" rows=\"2\" cols=\"100\">"+val+"</textarea>"//改为多行文本框 高俊涛 2016-8-17
                        else if (index == "6")
                            return "<input id=\"PJYYQK\" value=\""+val+"\" class=\"easyui-validatebox\">";
                        else if (index == "7" && val == "修复")
                            return "<select  id=\"WXJG\" name=\"WXJG\" class=\"easyui-combobox\" style=\"width:50px;\"><option selected=\"selected\" value=\"修复\">修复</option> <option value=\"未修复\">未修复</option></select>";
                        else if (index == "7" && val == "未修复")
                            return "<select  id=\"WXJG\" name=\"WXJG\" class=\"easyui-combobox\" style=\"width:50px;\"><option value=\"修复\">修复</option> <option selected=\"selected\" value=\"未修复\">未修复</option></select>";
                        else if (index == "7" && val == "")
                            return "<select  id=\"WXJG\" name=\"WXJG\" class=\"easyui-combobox\" style=\"width:50px;\"><option value=\"修复\">修复</option> <option value=\"未修复\">未修复</option></select>";
                        else
                            return val;
                    }
                    },
                    { align: 'center', field: 'f3', title: 'f3', width: colwidth, formatter: function (val, row, index) {
                        return val;
                    }, styler: function (val, row, index) {
                        if (index != "3" && index != "0" && index != "5" && index != "6" && index != "7")
                            return 'background-color:#F1F1F1';
                    }
                    },
                    {
                        align: 'left', field: 'f4', title: 'f4', width: colwidth * 1.3, formatter: function (val, row, index) {
                        if (index == 4)
                            return "<input style=\"width:colwidth;\" id=\"WXRQZ\"  value=\""+val+"\" class=\"easyui-validatebox\"/>";
                        else
                        {                         
                            return val;
                        }
                           
                    }
                    },
                    { align: 'center', field: 'f5', title: 'f5', width: colwidth, formatter: function (val, row, index) {
                        return val;

                    }, styler: function (val, row, index) {
                        if (index != "3" && index != "0" && index != "5" && index != "6" && index != "7")
                            return 'background-color:#F1F1F1';
                    }
                    },
                    {
                        align: 'left', field: 'f6', title: 'f6', width: colwidth * 1.3, formatter: function (val, row, index) {
                        if (index == 4 && val == "")
                            return "<input style=\"width:colwidth;\" id=\"SCDWQZ\"  value=\"\" class=\"easyui-validatebox\"/>";
                        else
                        {                        
                            return val;
                        }
                    }
                    }
                ]],
                onLoadSuccess: function () {
                    merge();
                    /*
                    ////维修人签字按钮及权限控制
                    $('#WXRBT').linkbutton({
                        plain:true
                    });
                    var nm = $('#USERNAME').val();
                    $('#WXRBT').bind('click', function () {                                            
                        $('#WXRQZ').val(nm);
                    });
                    $('#WXRQZ').attr("disabled", true);
                    //只有当前用户是维修人的情况下签字按钮才可用
                    if (nm != $('#WXR').val()) $('#WXRBT').hide();

                    //////生产单位签字按钮及权限控制
                    $('#SCDWBT').linkbutton({
                        plain: true
                    });

                    $('#SCDWBT').bind('click', function () {
                        $('#SCDWQZ').val(nm);
                    });
                    $('#SCDWQZ').attr("disabled", true);
                    //只有当前用户是维修人的情况下签字按钮才可用
                    if (nm != $('#DW').val()) $('#SCDWBT').hide();
                    */

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
            $("#ok").click(function () {
                var WXDW = $("#WXDW").val();
                var WXNR = $("#WXNR").val();
                var PJYYQK = $("#PJYYQK").val();
                var WXJG = $('#WXJG').val()
                var WXRQZ = $("#WXRQZ").val();
                var SCDWQZ = $("#SCDWQZ").val();
                var str = WXDW + "," + WXNR + "," + PJYYQK + "," + WXJG + "," + WXRQZ + "," + SCDWQZ + "," + $("#ID").val();
               
                var aj = $.ajax({
                    url: encodeURI(encodeURI("submit_jld.ashx?str=" + str)), // 跳转到 action  
                    type: 'post',
                    success: function (data) {
                        if (data == "1")
                            alert("操作成功！");
                        else
                            alert("操作失败！");
                        self.location.href = "show_meter_repair.aspx";
                    },
                    error: function () {
                        alert("操作失败，请稍后再试！");
                    }
                });
            });
            //计量员确认维修记录单内容。
            $("#jlyok").click(function () {              
                var str = $("#ID").val();

                var aj = $.ajax({
                    url: encodeURI(encodeURI("jly_submit_jld.ashx?str=" + str)), // 跳转到 action  
                    type: 'post',
                    success: function (data) {
                        if (data == "1")
                            alert("操作成功！");
                        else
                            alert("操作失败！");
                        self.location.href = "show_meter_repair.aspx";
                    },
                    error: function () {
                        alert("操作失败，请稍后再试！");
                    }
                });
            });
            //计量员不同意维修记录单内容。
            $("#jlyrefuse").click(function () {
                var str = $("#ID").val();

                var aj = $.ajax({
                    url: encodeURI(encodeURI("jly_not_submit_jld.ashx?str=" + str)), // 跳转到 action  
                    type: 'post',
                    success: function (data) {
                        if (data == "1")
                            alert("操作成功！");
                        else
                            alert("操作失败！");
                        self.location.href = "show_meter_repair.aspx";
                    },
                    error: function () {
                        alert("操作失败，请稍后再试！");
                    }
                });
            });
            //维修人保存维修记录单内容。
            $("#save").click(function () {
                var WXDW = $("#WXDW").val();
                var WXNR = $("#WXNR").val();
                var PJYYQK = $("#PJYYQK").val();
                var WXJG = $('#WXJG').val()
                var WXRQZ = $("#WXRQZ").val();
                var SCDWQZ = $("#SCDWQZ").val();
                var str = WXDW + "," + WXNR + "," + PJYYQK + "," + WXJG + "," + WXRQZ + "," + SCDWQZ + "," + $("#ID").val();
                
                var aj = $.ajax({
                    url: encodeURI(encodeURI("save_jld.ashx?str=" + str)), // 跳转到 action  
                    type: 'post',
                    success: function (data) {
                        if (data == "1")
                            alert("操作成功！");
                        else
                            alert("操作失败！");
                       // self.location.href = "show_meter_repair.aspx";
                    },
                    error: function () {
                        alert("操作失败，请稍后再试！");
                    }
                });
            });
        });
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
            $('#dg2').datagrid('mergeCells', {
                index: 5,
                field: 'f2',
                colspan: 5
            });
            $('#dg2').datagrid('mergeCells', {
                index: 6,
                field: 'f2',
                colspan: 5
            });
            $('#dg2').datagrid('mergeCells', {
                index: 7,
                field: 'f2',
                colspan: 5
            });
            $("#GZXX").css("width", (document.body.clientWidth - 2) / 2);
            $("#WXNR").css("width", (document.body.clientWidth - 2) / 2);
            $("#PJYYQK").css("width", (document.body.clientWidth - 2) / 2);
            $("#WXJG").css("width", (document.body.clientWidth - 2) / 2);
        }
    </script>
   
</body> 
    
</html>
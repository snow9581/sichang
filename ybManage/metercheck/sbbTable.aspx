<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sbbTable.aspx.cs" Inherits="ybManage_Instrument_sbbTable" %>
<!--申报表操作界面-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>   
</head>
<body>
    <input id="fromid" runat="server" type="hidden"/>
    <input id="BM" runat="server" type="hidden"/>
    <input id="TITLE" runat="server" type="hidden"/>
    <table id="dg2" style=" height:100%; width:100%">
    </table>
    <div id="toolbar2">
        <a href="#" runat="server" id="agree" class="easyui-linkbutton" iconCls="icon-ok" plain="true">油田管理部同意</a>
        <a href="#" runat="server" id="disagree" class="easyui-linkbutton" iconCls="icon-no" plain="true">不同意</a>
        <a href="#" id="cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">关闭</a>
        <a href="#" id="exportExcel" class="easyui-linkbutton" iconCls="icon-save" plain="true">导出</a>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#dg2').datagrid({
                title: "外送仪表检定申报表",
                url: "get_sbbTable.ashx?FROMID=" + $('#fromid').val(),
                fit: true,
                fitColumns: true,
                toolbar: "#toolbar2",
                singleSelect: true,
                rownumbers: "true",
                columns: [[
                { title: $('#BM').val(), colspan: 13 }
                ], [
                { title: $('#TITLE').val(), colspan: 13 }
                ], [
                    { align: 'center', field: 'JLQJMC', title: '计量器具名称'},
                    { align: 'center', field: 'GGXH', title: '规格型号'},
                    { align: 'center', field: 'JLLB', title: '计量类别'},
                    { align: 'center', field: 'JDZQ', title: '检定周期'},
                    { align: 'center', field: 'JDDJ', title: '准确度等级'},
                    { align: 'center', field: 'SL', title: '数量'},
                    { align: 'center', field: 'JDRQ', title: '计划检定日期'},
                    { align: 'center', field: 'SYDW', title: '使用单位'},
                    { align: 'center', field: 'JDDW', title: '检定单位'},
                    { align: 'center', field: 'JDFS', title: '申请检定方式' },
                    { align: 'center', field: 'E_JDDJ', title: '鉴定单价(元)' },
                    { align: 'center', field: 'E_JDFYHJ', title: '鉴定费用合计(元)' },
                    { align: 'center', field: 'SM', title: '特殊情况说明'}
                ]]
            });

            $("#cancel").click(function () {
                $('#cc').layout('remove', 'north');
            });
            $("#exportExcel").click(function () {
                window.open("SSB_SaveExcel.ashx?FROMID="+$("#fromid").val());
            });
            $("#disagree").click(function () {
                $.messager.confirm("操作提示", "您确定不同意吗？", function (data) {
                    if (data) {
                        $.messager.prompt("操作提示", "请输入您不同意的原因", function (data) {
                            //$.post(encodeURI(encodeURI("disagree.ashx?CONTENT=" + data + "&FROMID=" + $("#fromid").val())));
                            var aj = $.ajax({  
                                url:"disagree.ashx?CONTENT=" + encodeURI(data) + "&FROMID=" + $("#fromid").val(),// 跳转到 action  
                                type:'post',  
                                success:function(data) {
                                    alert("操作成功！");
                                    self.location.href = "show_meter_check.aspx";
                                },  
                                error : function() {  
                                    alert("操作失败，请稍后再试！");
                                }
                            }); 
                        });
                    }
                });

            });
            $("#agree").click(function () {
//                $.post(encodeURI(encodeURI("agree.ashx?FROMID=" + $("#fromid").val())));
                var aj = $.ajax({  
                    url:encodeURI(encodeURI("agree.ashx?FROMID=" + $("#fromid").val())),// 跳转到 action  
                    type:'post',  
                    success:function(data) {
                        if (data == "1")
                            alert("操作成功！");
                        else
                            alert("操作失败，请稍后再试！");
                        self.location.href = "show_meter_check.aspx";
                    },  
                    error : function() {  
                        alert("操作失败，请稍后再试！");
                    }
                });
            });
        });
    </script>
</body>
</html>

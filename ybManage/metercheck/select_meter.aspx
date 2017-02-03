<%@ Page Language="C#" AutoEventWireup="true" CodeFile="select_meter.aspx.cs" Inherits="Instrument_Select" %>
<!--发起仪表外送检定时，选择待检定仪表操作界面-->
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
    <input id="ids" runat="server" type="hidden"/>
    <table id="dg2" width=100%>
    <thead>  
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="YBFL" width="55">管理分类</th>
				<th field="YBMC" width="55">仪表名称</th>
				<th field="KM" width="55">矿名</th>				
				<th field="DM" width="55">队名</th>
				<th field="AZDD" width="55">安装地点</th>
                <th field="GGXH" width="55">规格型号</th>
                <th field="SCCJ" width="55">生产厂家</th>
                <th field="CCBH" width="55">出厂编号</th>
                <th field="CCRQ" width="55">出厂日期</th>
                <th field="ZQDDJ" width="70">准确度等级</th>
                <th field="LC" width="70">测量范围</th>
                <th field="JDZQ" width="55">检定周期</th>
                <th field="JDDW" width="55">检定单位</th>
                <th field="JDRQ" width="55">检定日期</th>
                <th field="JDJG" width="55">检定结果</th>
                <th field="GLZT" width="55">管理状态</th>
                <th field="SFWS" width="55">送检/自检</th>
                <th field="BZ" width="28">备注</th>
            </tr>
    </thead>
    </table>
    <div id="toolbar2">
        <a href="#" id="btn_ok" class="easyui-linkbutton" iconcls="icon-ok" plain="true" onclick="ok()">确认</a> 
        <a href="#" id="A1" class="easyui-linkbutton" iconcls="icon-back" plain="true" onclick="goback()">返回</a>
        <span>矿名:</span><input name="KM" class="easyui-combobox"type="text" id="KM" value=""/>
        <span>队名:</span><input name="DM" class="easyui-combobox"type="text" id="DM" value="" />
        <span>检索范围:</span><input name="scope" checked type="radio" value="0"/>全部仪表<input name="scope" type="radio" value="1"/>推荐仪表
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()" shape="rect">查询</a>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#dg2').datagrid({
                title: "填写外送仪表检定申报表-挑选待检定仪表",
                url: "get_meter_information.ashx",
                fit: true,
                // fitColumns: true,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar2",
                pagination: "true",
                pageSize: 30,
                rownumbers: "true",
                selectOnCheck: true,
                detailFormatter: function (index, row) {
                    return '<div class="ddv"></div>';
                },
                onLoadSuccess: function (data) {
                    var ids = $("#ids").val();
                    var id = "";
                    if (ids != "") {
                        var rows = $("#dg2").datagrid('getRows');
                        for (var i = 0; i < ids.length - 1; i++) {
                            if (ids.charAt(i) != ',') {
                                id += ids.charAt(i);
                                continue;
                            }
                            if (ids.charAt(i) == ',') {
                                for (var j = 0; j < rows.length; j++) {
                                    if (rows[j].ID == id)
                                        $("#dg2").datagrid('checkRow', j);
                                }
                                id = "";

                            }
                        }
                        for (var j = 0; j < rows.length; j++) {
                            if (rows[j].ID == id)
                                $("#dg2").datagrid('checkRow', j);
                        }
                    }
                }
            });
            Bind();
        });

        function FindData() {
            var sc = checks();//0代表全部仪表，1代表检定时间+检定周期落入当前月份的仪表。

            $('#dg2').datagrid('load', {
                KM: $('#KM').combobox('getValue'),///下拉框的获取数值方法*王钧泽学长1月14日
                DM: $('#DM').combobox('getValue'),
                SCOPE:sc,
            });
        }

        function checks() {
            var radios = document.getElementsByName("scope");
            for (var i = 0; i < radios.length; i++) {
                if (radios[i].checked == true) {
                    return radios[i].value;
                }
            }
        }

        function Bind() {
            var KM = $('#KM').combobox({
                valueField: 'text', //值字段
                textField: 'text', //显示的字段
                url: '../../tools/getKM.ashx',
                editable: true,
                onChange: function (newValue, oldValue) {
                    $.get('../../tools/getDM.ashx', { meter: newValue }, function (data) {
                        DM.combobox("clear").combobox('loadData', data);
                    }, 'json');
                }
            });
            var DM = $('#DM').combobox({
                valueField: 'text', //值字段
                textField: 'text', //显示的字段
                editable: true
            });
        }
        function ok() {
            var cs = "";
            var rows = $('#dg2').datagrid("getChecked");
            for (var i = 0; i < rows.length; i++) {
                cs += rows[i].ID+",";
            }
            location.href = "ensure_meter.aspx?ID='" + cs + "'";
        }
        function goback() {
            location.href = "show_meter_check.aspx";
        }
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
 </script>
</body>
</html>

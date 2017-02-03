<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showGrade.aspx.cs" Inherits="exam_showGrade" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/export.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#dg').datagrid({
                title: "考试成绩",
                url: "getGrade.ashx",
                fit: true,
                fitColumns: true,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar",
                pagination: "true",
                pageSize: 30,
                singleSelect: false,
                sortName: 'E_DATE',               //排序字段
                sortOrder: 'asc',
                remoteSort: false,
                //multiSort:true,
                rownumbers: "true"
            });
        });

        ///方法说明：查询 
        /// </summary>     
        function FindData() {
            $('#dg').datagrid('load', {
                S_TITLE: $('#S_TITLE').val(),
                S_TYPE: $("input[name='S_TYPE']:checked").val(),
                S_LEVEL: $('#S_LEVEL').combobox('getValue')
            });
        }

        function color(val, row) {
            if (row.E_SCORE != undefined && row.E_SCORE < 0.6 * row.E_FULLSCORE)
                return '<span style="color:red">' + row.E_SCORE + '</span>'
            else
                return '<span style="color:red">' + row.E_SCORE + '</span>'
        }
    </script>
</head>

<body>
    <table id="dg">
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true">
                </th>
                <th field="E_EXAMINEE" width="100">
                    姓名
                </th>
<%--                <th field="E_MAJOR" width="50" sortable="true">
                    专业
                </th>--%>
                <th field="E_SCORE" width="100" data-options="formatter:color">
                    分数
                </th>
                <th field="E_FULLSCORE" width="100" >
                    满分
                </th>
                <th field="E_DATE" width="100" >
                    考试日期
                </th>
            </tr>
        </thead>
    </table>
</body>
</html>

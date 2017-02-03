<%@ Page Language="C#" AutoEventWireup="true" CodeFile="history.aspx.cs" Inherits="ybManage_calibrator_history" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
 </script>

    <script type="text/javascript">
        $(function () {
            $('#dg2').datagrid({
                title: " 历史文件",
                url: "history.ashx?BZQMC="+ $("#hd_BZQMC").val(),
                fit: true,
                fitColumns: true,
//                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar2",
                pagination: "true",
//                pageSize: 30,
                singleSelect: false,
                sortName: 'BXSJ',               //排序字段
                sortOrder: 'desc',
                remoteSort: false,
                //multiSort:true,
                rownumbers: "true",
                view: detailview,
                selectOnCheck: true,

                detailFormatter: function (index, row) {
                    return '<div class="ddv"></div>';
                },
                onExpandRow: function (index, row) {
                    var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                    ddv.panel({
                        border: false,
                        cache: true,
                        href: 'input_calibrator.aspx?index=' + index,
                        onLoad: function () {
                            $('#dg2').datagrid('fixDetailRowHeight', index);
                            $('#dg2').datagrid('selectRow', index);
                            $('#dg2').datagrid('getRowDetail', index).find('form').form('load', row);
                        }
                    });
                    $('#dg2').datagrid('fixDetailRowHeight', index);
                }

            });
            //规定用户权限
            var userlevel = $('#userLevel').val();
            if (userlevel == "2" || userlevel == "6") {
                $('#btn_new').css('display', 'none');
                $('#btn_delete').css('display', 'none');
            } else if (userlevel == "1") {
                $('#toolbar2').css('display', 'block');
            }
        });

        function myformatter(date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
        }
        function myparser(s) {
            if (!s)
                return new Date();
            var ss = (s.split('-'));
            var y = parseInt(ss[0], 10);
            var m = parseInt(ss[1], 10);
            var d = parseInt(ss[2], 10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                return new Date(y, m - 1, d);
            } else {
                return new Date();
            }
        }

        function Save_Excel() {
            var condition = "and rowindex <> 1 and bzqmc='" + $('#hd_BZQMC').val()+"'";
            window.location = "../../tools/toExcel.aspx?name= 标准器名称,编写(校对)时间,负责(校对)人,文件" +
            " &field= BZQMC,BXSJ,FZR,WJ &location= (SELECT id,BZQMC,BXSJ,FZR,WJ, ROW_NUMBER () OVER (PARTITION BY BZQMC ORDER BY ID DESC )as rowindex from T_CALIBRATOR)&condition=" + condition;
            return false;
        }

        function go(val, row) {
            // 高俊涛修改 2014-09-07 将文件名隐藏为下载
            // alert(row.FAWD);
            if (row.WJ != '#' && row.WJ != '' && row.WJ != undefined)
                return '<a href="../../datasubmit/downloadPic.aspx?picName=' + escape(row.WJ) + '&package=meter" target="_blank">' + '下载' + '</a>  '
            else
                return ''
        }
        function destroyItem() {              //删除
            var rows = $('#dg2').datagrid("getChecked");
            if (rows.length) {
                $.messager.confirm('confirm', 'are you sure to delete this data?', function (r) {
                    if (r) {
                        for (var i = rows.length - 1; i >= 0; i--)
                            $.post('destroy_calibrator.ashx', { id: rows[i].ID });
                        $("#dg2").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项
                        $('#dg2').datagrid('reload');
                    }
                });
            }
        }

</script>
   
</head>
<body>

    <div   id="toolbar2">
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true"  onclick="return Save_Excel()" >导出</a> 
        <a href="show_calibrator.aspx" class="easyui-linkbutton" iconcls="icon-back" " plain="true" >返回</a> 
    </div>
    <input type="hidden" id="hd_BZQMC" runat="server"/>
<table id="dg2">
        <thead>
			<tr>
                <th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'BZQMC',width:10">标准器名称</th>
				<th data-options="field:'BXSJ',width:10">编写(校对)时间</th>
				<th data-options="field:'FZR',width:10">负责(校对)人</th>
				<th data-options="field:'WJ',formatter:go,width:10">文件</th>
			</tr>
		</thead>
	</table>
</body>
</html>
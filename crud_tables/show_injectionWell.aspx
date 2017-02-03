<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_injectionWell.aspx.cs" Inherits="crud_tables_show_injectionWell" %>

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
            $('#dg').datagrid({
                title: "注入井",
                url: "../crud_get/get_injectionWell.ashx",
                fit: true,
                fitColumns: false,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar",
                pagination: "true",
                pageSize: 30,
                singleSelect: false,
                sortName: 'DM',               //排序字段
                sortOrder: 'asc',
                remoteSort: false,
                //multiSort:true,
                rownumbers: "true",
                view: detailview,
                selectOnCheck: true,

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
                        href: '../crud_form/input_injectionWell.aspx?index=' + index + '&id=' + id,
                        onLoad: function () {
                            $('#dg').datagrid('fixDetailRowHeight', index);
                            $('#dg').datagrid('selectRow', index);
                            $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                        }
                    });
                    $('#dg').datagrid('fixDetailRowHeight', index);
                },
                loader: SCLoader 
            });
            ////规定用户权限
            var userlevel = $('#userLevel').val();
            if (userlevel == "2" || userlevel == "6") {
                $('#btn_new').css('display', 'none');
                $('#btn_delete').css('display', 'none');
            } else if (userlevel == "1") {
                $('#toolbar').css('display', 'block');
            }
            if (userlevel != "1") {
                $('#formdiv').css('display', 'none');
            }
        });

        ///setValue是EasyUI固定的写法。
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
        // <summary>  



        function saveItem(index) {
            //alert(index);
            var row = $('#dg').datagrid('getRows')[index];
            //alert(row);
            var url = row.isNewRecord ? '../crud_insert/insert_injectionWell.ashx' : '../crud_update/update_injectionWell.ashx?ID=' + row.ID;
            //alert(url);
            $('#dg').datagrid('getRowDetail', index).find('form').form('submit', {
                url: url,
                onSubmit: function () {
                    //alert("success");
                    $("#save").removeAttr("onclick");
                    return $(this).form('validate');
                },
                success: function (data) {
                    //alert(data);
                    data = eval('(' + data + ')');
                    data.isNewRecord = false;
                    $('#dg').datagrid('collapseRow', index);
                    $('#dg').datagrid('updateRow', {
                        index: index,
                        row: data
                    });
                }
            });
        }
        function cancelItem(index) {
            var row = $('#dg').datagrid('getRows')[index];
            if (row.isNewRecord) {
                $('#dg').datagrid('deleteRow', index);
            } else {
                $('#dg').datagrid('collapseRow', index);
            }
        }
        function destroyItem() {                   //刘靖  可批量删除 2014.11.13
            var rows = $('#dg').datagrid("getChecked");
            if (rows.length) {
                $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                    if (r) {
                        for (var i = rows.length - 1; i >= 0; i--)
                            $.post('../crud_destroy/destroy_injectionWell.ashx', { id: rows[i].ID });
                        $("#dg").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项
                        $('#dg').datagrid('reload');
                    }
                });
            }
        }

        function newItem() {
            $('#dg').datagrid('appendRow', { isNewRecord: true });
            var index = $('#dg').datagrid('getRows').length - 1;
            $('#dg').datagrid('expandRow', index);
            $('#dg').datagrid('selectRow', index);
        }

        ///<summary>
        ///方法说明:导出EXCEL功能
        ///2014.11.2  修复了传输数据时编码不一致导致参数出错的问题
        ///暂无创建时间查询方式
        ///</summary>  
        function Save_Excel() {
            var dm = $('#dm').val();
            var conditions = '';
            $("#toolbar input").each(function () {
                if ($(this).val() !== '')
                    conditions += (' and ' + $(this).attr("id") + ' like \'%' + $(this).val() + '%\'');
            });
            if ($('#userLevel').val() == '1')
                conditions += (' and DM = \'' + dm + '\'');
            window.location = "../tools/toExcel.aspx?name=矿名,队名,所属站名,井号,投产日期,管线规格,长度,注入介质,保温方式,地类,管线材质,备注" +
            " &field=KM,DM,ZM,WNUMBER,TCRQ,GXGG,LENGTH,ZRFS,BWFS,LANDTYPE,GXCZ,BZ&location=T_injectionWell&condition=" + escape(conditions);

            return false;

        }

        ///方法说明：查询 
        /// </summary>     
        function FindData() {
            $('#dg').datagrid('load', {
                KM: $('#KM').val(),
                DM: $('#DM').val(),
                ZM: $('#ZM').val(),
                WNUMBER: $('#WNUMBER').val()
            });
        }
        function UpFile() {
            $('#form').form('submit', {
                url: "../tools/Upfile.ashx",
                onSubmit: function () {
                },
                success: function (data) {
                }
            });
        }
    </script>

</head>
<body>
    
  <table id="dg">
        <thead>         
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
				<th field="KM"   width="100" sortable="true">矿名</th>
				<th field="DM"   width="100" sortable="true">队名</th>
				<th field="ZM"  width="100" sortable="true">所属站名</th>
				<th field="WNUMBER"  width="100">井号</th>
				<th field="TCRQ" width="100">投产日期</th>
				<th field="GXGG"  width="100">管线规格</th>
				<th field="LENGTH"  width="100">长度</th>				
				<th field="ZRFS"  width="100">注入介质</th>
				<th field="BWFS"  width="100">保温方式</th>
				<th field="LANDTYPE" width="100">地类</th>
                <th field="GXCZ" width="100">管线材质</th>
				<th field="BZ"  width="100">备注</th>
			
			</tr>
        </thead>
    </table>
    <div id="inputd" class="easyui-panel" style="padding:10px;">Dialog Content</div>
    <input type="hidden" id="userLevel" runat="server"/>
     <input type="hidden" id="dm" runat="server"/>
    <div id="toolbar">
        <a href="#"  id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true"  onclick="return Save_Excel()" >导出</a>
        <span><label for="KM">矿名:</label></span><input class="easyui-textbox" id="KM" value="" size=10 /> 
        <span><label for="DM">队名:</label></span><input class="easyui-textbox" id="DM" value="" size=10 />
        <span><label for="ZM">所属站名:</label></span><input class="easyui-textbox" id="ZM" value="" size=10 />
        <span><label for="WNUMBER">井号:</label></span><input class="easyui-textbox" id="WNUMBER" value="" size=10 />
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>

        <div id="formdiv">
        <form id="form" method="post" action="../tools/Upfile.ashx" enctype="multipart/form-data">
        <a href="../File/INJECTIONWELL.xls" class="easyui-linkbutton" iconCls='icon-download'">下载模板</a>
        <a href="#" class="easyui-linkbutton" iconCls='icon-upload' onclick="UpFile()"">上传文档</a>
        <input id="File" name="File" type="file" />
        </form>
        </div>
    </div>
</body>
</html>

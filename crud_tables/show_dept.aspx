<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_dept.aspx.cs" Inherits="crud_tables_show_dept" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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

        $(function() {
            $('#dg').datagrid({
                title: "组织结构",
                url: "../crud_get/get_dept.ashx",
                fit: true,
                fitColumns: true,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar",
                pagination: "true",
                pageSize:30,
                singleSelect: false,
                sortName: 'KM',               //排序字段
                sortOrder: 'asc',               
                remoteSort:false,                
                //multiSort:true,
                 rownumbers:"true",
                view: detailview,

                detailFormatter: function(index, row) {
                    return '<div class="ddv"></div>';
                },
                onExpandRow: function(index, row) {
                    var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                    ddv.panel({
                        border: false,
                        cache: true,
                        href: '../crud_form/input_dept.aspx?index=' + index,
                        onLoad: function() {
                            $('#dg').datagrid('fixDetailRowHeight', index);
                            $('#dg').datagrid('selectRow', index);
                            $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                        }
                    });
                    $('#dg').datagrid('fixDetailRowHeight', index);
                },
                loader: SCLoader 
            });
        });


        function saveItem(index) {
            //alert(index);
            var row = $('#dg').datagrid('getRows')[index];
            //alert(row);
            var url = row.isNewRecord ? '../crud_insert/insert_dept.ashx' : '../crud_update/update_dept.ashx?ID=' + row.ID;
           // alert(url);
            $('#dg').datagrid('getRowDetail', index).find('form').form('submit', {
                url: url,
                onSubmit: function() {
                    //alert("success");
                    $("#save").removeAttr("onclick");
                    return $(this).form('validate');
                },
                success: function(data) {
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
      function destroyItem() {                  
            var rows = $('#dg').datagrid("getChecked"); 
            if (rows.length) {
                $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                    if (r) {
                    for(var i =rows.length-1;i>=0;i--)          
                        $.post('../crud_destroy/destory_dept.ashx', { id: rows[i].ID });                  
                    $("#dg").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项
                    $('#dg').datagrid('reload');
                    }
                 });
            }
        }
//         function destroyItem() {
//            var row = $('#dg').datagrid('getSelected');
//            if (row) {
//                $.messager.confirm('Confirm', 'Are you sure you want to remove this team?', function(r) {
//                    if (r) {
//                        var index = $('#dg').datagrid('getRowIndex', row);
//                        $.post('../crud_destroy/destory_dept.ashx', { id: row.ID }, function() {
//                            $('#dg').datagrid('deleteRow', index);
//                        });
//                    }
//                });
//            }
//        }

        function newItem() {
            $('#dg').datagrid('appendRow', { isNewRecord: true });
            var index = $('#dg').datagrid('getRows').length - 1;
            $('#dg').datagrid('expandRow', index);
            $('#dg').datagrid('selectRow', index);
        }
///方法说明：查询 
/// </summary>     
       function FindData(){ 
            $('#dg').datagrid('load',{
             KM: $('#KM').val(),
             DM: $('#DM').val()
           });
        } 
/// <summary> 
    </script>

 
</head>
<body>
     <table id="dg"> 
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
				<th field="KM"   width="50" sortable="true">矿名</th>
				<th field="DM"  width="50" >队名</th>	
			</tr>
        </thead>
    </table>
    <div id="toolbar">
        <a href="#" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <span>矿名:</span><input type="text" id="KM" value="" size=10 />
        <span>队名：</span><input type="text" id="DM" value="" size=10 /> 
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
    </div>
</body>
</html>

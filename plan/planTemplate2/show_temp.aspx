<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_temp.aspx.cs" Inherits="temp_show_temp" %>

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
   $(function() {
            $('#dg').datagrid({
                title: "模板编辑",
                url: "get_temp.ashx",
                fit: true,
                fitColumns: false,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar",
                pagination: "true",
                pageSize:30,
                singleSelect: false,             
                remoteSort:false,                
                //multiSort:true,
                view: detailview,
                rownumbers:"true",
                nowrap: false ,
                
                detailFormatter: function(index, row) {
                    return '<div class="ddv"></div>';
                },          
                onExpandRow: function(index, row) {
                    var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                    
                    var raw = $('#dg').datagrid('getRows')[index];
                    ddv.panel({
                        border: false,
                        cache: true,
                        href:'input_temp.aspx?index='+index,
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
            var row = $('#dg').datagrid('getRows')[index];
            var url = row.isNewRecord ? 'insert_temp.ashx' : 'update_temp.ashx?ID=' + row.ID;
            $('#dg').datagrid('getRowDetail', index).find('form').form('submit', {
                url: url,
                onSubmit: function() {
                    return $(this).form('validate');
                },               
                success: function(data) {
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
                $.messager.confirm('提示', '你确定要删除已选记录吗?', function(r) {
                    if (r) {
                    for(var i =rows.length-1;i>=0;i--)        
                        $.post('destroy_temp.ashx', { ID: rows[i].ID });                   
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
        </script>
        
</head>
<body>
    <table id="dg">
        <thead>
            <tr>		
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="TEMPNAME" sortable="true" data-options="width:150">模板名称</th>
                <th field="MAJORDELEGATECYCLE" sortable="true" data-options="width:180">一次委托资料周期</th>			
				<th field="WORKLOADSUBMITCYCLE" sortable="true" data-options="width:180">工程量提交周期</th>				
				<th field="WHITEGRAPHPROOFCYCLE" sortable="true" data-options="width:180">施工白图校审周期</th>				
				<th field="BLUEGRAPHSUBMITCYCLE" sortable="true" data-options="width:180" >蓝图存档周期</th>					
			</tr>
        </thead>
    </table>
    
    <div id="inputd" class="easyui-panel" style="padding:10px;">Dialog Content</div>
    <input type="hidden" id="userLevel" runat="server"/>
    
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        
    </div>
</body>
</html>

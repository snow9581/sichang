<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewLan.aspx.cs" Inherits="crud_tables_NewLan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="../themes/default/textbox.css" rel="stylesheet" />
    <link href="../themes/color.css" rel="stylesheet" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/export.js" type="text/javascript"></script>
</head>
<body>
    <script type="text/javascript">
      $.fn.datebox.defaults.formatter = function (date) {
          var y = date.getFullYear();
          var m = date.getMonth() + 1;
          var d = date.getDate();
          return y + '/' + (m < 10 ? (m) : m) + '/' + (d < 10 ? (+ d) : d);
      };
      $.fn.datebox.defaults.parser = function (s) {
          if (!s) return new Date();
          var ss = s.split('/');
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
          $(function(){
              $('#dg').datagrid({
                  title: "栏目管理",
                  url: "../crud_get/get_NewLan.ashx",
                  fit: true,
                  fitColumns: true,
                  showFooters: true,
                  collapsible: true,
                  toolbar: "#toolbar",
                  pagination: "true",
                  pageSize: 30,
                  singleSelect: false,
                  sortName: '',               //排序字段
                  sortOrder: 'asc',
                  remoteSort: false,
                  rownumbers: "true",
                  view: detailview,
                  detailFormatter: function (index, row) {
                      return '<div class="ddv"></div>';
                  },
                  onExpandRow: function (index, row) {
                      var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                      ddv.panel({
                          border: false,
                          cache: true,
                          href: "../crud_form/input_NewLan.aspx?index=" + index,
                          onLoad: function () {
                              $('#dg').datagrid('fixDetailRowHeight', index);
                              $('#dg').datagrid('selectRow', index);
                              $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                          }
                      });
                      $('#dg').datagrid('fixDetailRowHeight', index);
                  }
              });
          })
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
                        for (var i = rows.length - 1; i >= 0; --i) {
                            $.ajax({
                                type: "post",
                                url: "../crud_destroy/destroy_NewLan.ashx",
                                data: "LANMU=" + rows[i].LANMU,
                                async: false,//同步
                                success: function (data) {
                                    if (data == "1") {
                                        alert("栏目中有文件，无法删除！")                                        
                                    }
                                    else
                                        alert("删除成功！");
                                        var index = $('#dg').datagrid('getRowIndex', rows[i]);
                                        $('#dg').datagrid('deleteRow', index);
                                }
                            });
                        }
                    }
                });
            }
          }

          function saveItem(index) {
              //alert(index);
              var row = $('#dg').datagrid('getRows')[index];
              //alert(row.ID);
              var url = '../crud_insert/insert_NewLan.ashx';
              //alert(url);
              $('#dg').datagrid('getRowDetail', index).find('form').form('submit', {
                  url: url,
                  onSubmit: function () {
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
          function newItem() {
              $('#dg').datagrid('appendRow', { isNewRecord: true });
              var index = $('#dg').datagrid('getRows').length - 1;
              $('#dg').datagrid('expandRow', index);
              $('#dg').datagrid('selectRow', index);
          }

          $(function Bind() {
              var xz_project = $('#xz_project').combobox({
                  valueField: 'text', //值字段
                  textField: 'text', //显示的字段
                  url: '../tools/get_share_combobox.ashx',
                  editable: true,
                  onChange: function (newValue, oldValue) {
                      $.get('../crud_get/get_share_combobox.ashx', { ZYQ: newValue },'json');
                  }
              });
              var name = $('#xz_project').combobox('getValue');
              //alert(name);
              if (name != null && name != undefined && name!="")
              {
                  self.location = "show_share.aspx?SH_NAME="+name;
              }
          })
      </script>
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
    </div>
     <table id="dg">
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
				<th field="LANMU"  sortable="true" width="50">栏目名称</th>
				<th field="count"  width="50">文档个数</th>		
			</tr>
        </thead>
    </table>
</body>
</html>

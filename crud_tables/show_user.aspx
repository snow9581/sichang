<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_user.aspx.cs" Inherits="crud_tables_show_event" %>

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

      $(function () {
          $('#dg').datagrid({
              title: "用户管理",
              url: "../crud_get/get_user.ashx",
              fit: true,
              fitColumns: true,
              showFooters: true,
              collapsible: true,
              toolbar: "#toolbar",
              pagination: "true",
              pageSize: 30,
              singleSelect: false,
              sortName: 'USERNAME',               //排序字段
              sortOrder: 'asc',
              remoteSort: false,
              //multiSort:true,
              rownumbers: "true",
              view: detailview,

              detailFormatter: function (index, row) {
                  return '<div class="ddv"></div>';
              },
              onExpandRow: function (index, row) {
                  if (row.CONTENE != "" && row.CONTENT != null)
                      row.CONTENT = row.CONTENT.replace(/\<br\/\>/g, "\r\n");
                  var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                  ddv.panel({
                      border: false,
                      cache: true,
                      href: '../crud_form/input_user.aspx?index=' + index,
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
      });


      function saveItem(index) {
          //alert(index);
          var row = $('#dg').datagrid('getRows')[index];
          //alert(row);
          var url = row.isNewRecord ? '../crud_insert/insert_user.ashx' : '../crud_update/update_user.ashx?ID=' + row.ID;
          // alert(url);
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
              $.messager.confirm('confirm', 'are you sure to delete this data?', function (r) {
                  if (r) {
                      for (var i = rows.length - 1; i >= 0; i--)
                          $.post('../crud_destroy/destroy_user.ashx', { id: rows[i].ID });
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

      function go(val, row) {
          // 高俊涛修改 2014-09-07 将文件名隐藏为下载
          if (row.PICTURE != '#' && row.PICTURE != '' && row.PICTURE != undefined)
              return '<a  href="downloadPic.aspx?picName=' + escape(row.PICTURE) + '&package=signature" target="_blank">' + '下载' + '</a>  '
          else
              return ''
          // return '<a href="downloadPic.aspx?picName=' + escape(row.PICTURE) + '&package='ftpimage'" target="_blank">' + row.PICTURE + '</a>  '      
      }

      function resetPassword(val, row) {
          return '<a href="resetPassword.aspx?ID=' + row.ID + '" target="_blank">重置密码</a>  '
          // return '<a href="ftp://administrator:@58.155.47.128/ftpupload/' + row.PICTURE + '" target="_blank">下载</a>  '

      }
      ///方法说明：查询 
      /// </summary>     
      function FindData() {
          $('#dg').datagrid('load', {
              USERNAME: $('#USERNAME').val(),
              DM: $('#DM').val(),
              MAJOR: $('#MAJOR').val()
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
				<th field="USERNAME"   width="50" sortable="true">用户名</th>
				<%--<th field="PASSWORD"  width="50" sortable="true">密码</th>--%>
				<th field="POSITION"  width="50" sortable="true">职位</th>
                <th field="MAJOR"  width="50" sortable="true">专业</th>
				<th field="DM"  width="50">所在单位</th>
				<th data-options="field:'ID',formatter:resetPassword"  width="50">操作</th>
				 <th data-options="field:'PICTURE',formatter:go"  width="50">电子签名</th>
			</tr>
        </thead>
    </table>
    <div id="toolbar">
        <a href="#" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <span>用户名:</span><input type="text" id="USERNAME" value="" size="10" />
        <span>专业:</span><input type="text" id="MAJOR" value="" size="10" /> 
        <span>所在单位:</span><input type="text" id="DM" value="" size="10" /> 
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
    </div>
</body>
</html>

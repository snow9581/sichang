<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_share.aspx.cs" Inherits="show_share" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/sichang.js" type="text/javascript"></script>
    <script src="../js/export.js" type="text/javascript"></script>

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
          $(function () {
              $('#dg').datagrid({
                  title: "共享文档",
                  url: "../crud_get/get_share.ashx",
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
                          href: "../crud_form/input_share.aspx?index=" + index,
                          onLoad: function () {
                              $('#dg').datagrid('fixDetailRowHeight', index);
                              $('#dg').datagrid('selectRow', index);
                              $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                          }
                      });
                      $('#dg').datagrid('fixDetailRowHeight', index);
                  }
              });
              var level=$('#userlevel').val();
              if(level!='2'){
                  $('#btn_new').remove();
                  $('#btn_delete').remove();
                  $('#dg').datagrid('hideColumn', 'ck');
              }
          });
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
                          for (var i = rows.length - 1; i >= 0; i--)
                              $.post('../crud_destroy/destroy_share.ashx', { id: rows[i].ID });
                          $("#dg").datagrid('clearSelections');  
                          $('#dg').datagrid('reload');
                      }
                  });
              }
          }

          function saveItem(index) {
              //alert(index);
              var row = $('#dg').datagrid('getRows')[index];
              //alert(row.ID);
              var url = row.isNewRecord ? '../crud_insert/insert_share.ashx' : '../crud_update/update_share.ashx?ID=' + row.ID;
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
                      //alert(data);
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
                  editable: true
//                  onChange: function (newValue, oldValue) {
//                      $.get('../tools/get_share_combobox.ashx', { ZYQ: newValue },'json');
//                  }
              });
              //alert(name);              
          })
          function newlan() {
              if ($('#tab').tabs('exists', title)) {
                  $('#rab').tabs('select', title);
              } else {
                  var content = '<iframe scrolling="auto" frameborder="0"  src="NewLan.aspx" style="width:100%;height:100%;"></iframe>';
                  $('#tt').tabs('add', {
                      title: 新建栏目,
                      content: content,
                      closable: true
                  });
              }
          }
          ///方法说明：ftp 生成下载链接，by wya
          /// </summary>   
          function go(val, row) {
              // 高俊涛修改 2014-09-07 将文件名隐藏为下载
              //alert(row.pid);
              if (row.FILES != '#' && row.FILES != '' && row.FILES != undefined)
                  return '<a href="downloadPic.aspx?picName=' + escape(row.FILES) + '&package=share" target="_blank">' + '下载' + '</a>  '
              else
                  return ''
              // return '<a href="downloadPic.aspx?picName=' + escape(row.FILES) + '&package='ftpimage'" target="_blank">' + row.FILES + '</a>  '      
          }
          ///方法说明：查询 
          /// </summary>     
          function FindData() {
              //if($("#KWORDS").val()=="") { 
              // alert(PID); 
              // }               
              $('#dg').datagrid('load', {
                  xz_project: $('#xz_project').combobox('getValue'),                  
              });
              //alert($('#xz_project').combobox('getValue'));
          }
          /// <summary>
          function ClosePanel() {
              //console.log("closePanel");
              $("#dlg").panel('close');
          }
          function LoadShare(){
              //alert($('#xz_project').combobox('getValue'));
              var Lan = $('#xz_project').combobox('getValue');
              if (Lan != "" && Lan != undefined) {
                  $('#dg').datagrid('load', {
                      xz_project: $('#xz_project').combobox('getValue')
                  });
                  ClosePanel();
              }
              else {
                  alert("请选择栏目！");                  
              }
          }
          function addTab(title, url) {
              window.parent.addTab(title, url);
        }          
      </script>
    <style type="text/css">
        #btn{
            text-align:right;
        }
    </style>
</head>
<body>
    <div id="dlg" class="easyui-dialog" title="选择栏目" style="width:400px;height:200px;padding:10px">
        请选择栏目:<br/><br/>
        &nbsp; &nbsp; &nbsp; <input id="xz_project" name="xz_project" class="easyui-combobox" runat="server" data-options="required:true"/>
            <div id="btn">
                <a href="#" id="btn_share" class="easyui-linkbutton" plain="true" onclick="LoadShare()">确定</a>
                <a href="#" id="btn_newlan" class="easyui-linkbutton" plain="true" onclick="parent.addTab('栏目管理','crud_tables/NewLan.aspx')">栏目管理</a>                 
            </div>
	</div>
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
<%--        <input id="xz_project" name="xz_project" class="easyui-combobox" runat="server" data-options="required:true"  />
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="FindData()"">查询</a> 
        <a href="#" id="btn_newlan" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="addTab('栏目管理','show_NewLan')">新建栏目</a> --%>
    </div>
    <input  type="hidden" value="" id="userlevel" runat="server"/>
     <table id="dg">
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
				<th field="SH_NAME"  sortable="true" width="50">名称</th>
				<th field="SH_PROJECT"  sortable="true" width="50">栏目</th>
				<th field="SH_INFOR"  width="50">简介</th>
				<th field="SH_AUTHOR"  width="70">作者</th>				
				<th field="SH_CHAIRMAN" width="50">室主任</th>				
				<th field="SH_DATE"  width="70">上传日期</th>
                <th data-options="field:'FILES',formatter:go"  width="50">方案文档</th>	
			</tr>
        </thead>
    </table>
</body>
</html>

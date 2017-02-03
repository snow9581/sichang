<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_measure.aspx.cs" Inherits="show_measure" %>

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
              title: "测控信息管理",
              url: "get_measure.ashx",
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
              //multiSort:true,
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
                      href: "input_measure.aspx?index=" + index, ///../crud_form/
                      onLoad: function () {
                          $('#dg').datagrid('fixDetailRowHeight', index);
                          $('#dg').datagrid('selectRow', index);
                          $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                      }
                  });
                  $('#dg').datagrid('fixDetailRowHeight', index);
              }
          });
          ////规定用户权限
          var userlevel = $('#userLevel').val();
          if (userlevel == "2" || userlevel == "6" || userlevel == "4") {
              $('#btn_new').css('display', 'none');
              $('#btn_delete').css('display', 'none');
          } else if (userlevel == "1") {
              $('#toolbar').css('display', 'block');
          }
          if (userlevel != "1") {
              $('formdiv').css('display', 'none');
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
      function Save_Excel() {
         
          var dm = $('#dm').val();
          var conditions = '';
          if ($('#KM').combobox('getValue') != '')
              conditions += ('and KM=\'%' + $('#KM').combobox('getValue') + '%\'');

          if ($('#RJKFCJ').val() != '')
              conditions += ('and RJKFCJ=\'%' + $('#RJKFCJ').val() + '%\'');

          if ($('#userLevel').val() == '1')
              conditions += (' and DM = \'' + dm + '\'');
          else if ($('#DM').combobox('getValue') != '')
              conditions += ('and DM=\'%' + $('#DM').combobox('getValue') + '%\'');

          window.location = "MeasureToExcel.aspx?condition="+escape(conditions);
          return false;
      }
      function FindData() {
          $('#dg').datagrid('load', {
              KM: $('#KM').combobox('getValue'),///下拉框的获取数值方法*王钧泽学长1月14日
              DM: $('#DM').combobox('getValue'),
              RJKFCJ: $('#RJKFCJ').val()
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
      // <summary>  
         ///保存数据
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
                      for (var i = rows.length - 1; i >= 0; --i) {
                          $.ajax({
                              type: "post",
                              url: "destroy_measure.ashx",
                              data: "ID=" + rows[i].ID,
                              async: false,
                              success: function (data) {
                                  if (data == "1") {
                                      var index = $('#dg').datagrid('getRowIndex', rows[i]);
                                      $('#dg').datagrid('deleteRow', index);
                                      $('#dg').datagrid('reload');
                                  }
                                  else {
                                      alert("删除失败！");
                                  }
                              }
                          });
                      }
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
      /// <summary> 

         function saveItem(index) {
             var row = $('#dg').datagrid('getRows')[index];
             document.getElementById("userLevel").value = row.ID;
             //alert(row);
             var url = row.isNewRecord ? 'insert_measure.ashx' : 'update_measure.ashx?ID='+row.ID;
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
      </script>
    <style type="text/css">
        #KM
        {
            height: 68px;
            margin-top: 0px;
            width: 148px;
        }
        #Text1
        {
            width: 206px;
        }
    </style>
    <script type="text/javascript">///迭代关系的实现
   $(function Bind() {
          var KM = $('#KM').combobox({
          valueField: 'text', //值字段
          textField: 'text', //显示的字段
        url: '../tools/getKM.ashx',
          editable: true,
          onChange: function (newValue, oldValue) {
          $.get('../tools/getDM.ashx', { meter : newValue }, function (data) {
          DM.combobox("clear").combobox('loadData', data);
          }, 'json');
          }
          });
          var DM = $('#DM').combobox({
          valueField: 'text', //值字段
          textField: 'text', //显示的字段
          editable: true
          });
          });
 </script>
</head>
<body>
    <input type="hidden" id="idid" name="idid" runat="server" value=""/>
     <table id="dg">
        <thead>
            <tr>
               <th data-options="field:'ck',checkbox:true"></th>
<%--                <th field="KM" width="50"sortable="true">矿名</th>--%>
                <th field="DM"   width="50" sortable="true">队名</th>
                <th field="RJKFCJ"   width="50" sortable="true">软件开发厂家</th>
				<th field="TYSJ"     width="50" sortable="true" data-options="formatter:formatterdate">投用时间</th>
				<th field="SWRJPTMC"     width="50" sortable="true">上位软件平台名称</th>
                <th field="XWJMKCJMC"   width="50" sortable="true">下位机模块厂家名称</th>
                <th field="SWJPZ"   width="50" sortable="true">上位机配置</th>
                <th field="XTLX"   width="50" sortable="true">系统类型</th>
			</tr>
        </thead>
    </table>
    <div id="inputd" class="easyui-panel" style="padding:10px;">Dialog Content</div>
    <input type="hidden" id="userLevel" runat="server"/>
    <input type="hidden" id="dm" runat="server"/>
    <input type="hidden" id="km" runat="server"/>
    <div id="toolbar">
    &nbsp;
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
       <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true" onclick="return Save_Excel()" size=20>导出</a> 
        &nbsp; 
          &nbsp;   
        <span>矿名:</span><input name="KM" class="easyui-combobox"type="text" id="KM" value="" size=20/>&nbsp;&nbsp;
       &nbsp;
        <span>队名:</span><input name="DM" class="easyui-combobox"type="text" id="DM" value="" size=20/>&nbsp;&nbsp;
         &nbsp;   
            <span>软件开发厂家:</span><input type="text" id="RJKFCJ" name="RJKFCJ" value="" size='28'/>
         <a href="#" class="easyui-linkbutton" style=" position:absolute; right:10px;" iconCls='icon-search' onclick="FindData()" shape="rect">查询</a>
       <div id="formdiv">
        <form id="form" method="post" action="../tools/Upfile.ashx" enctype="multipart/form-data">
        <a href="../File/MEASURE.xls" class="easyui-linkbutton" iconCls='icon-download'">下载模板</a>
        <a href="#" class="easyui-linkbutton" iconCls='icon-upload' onclick="UpFile()"">上传文档</a>
        <input id="File" name="File" type="file" />
        </form>
            </div>
        </div>
</body>
</html>

﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_ConstructionMain.aspx.cs" Inherits="crud_tables_archives_show_ConstructionMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--施工图文档表-主页面--%>
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
              title: "施工图文档",
              url: "../../crud_get/archives/get_constructionMain.ashx?pna=" + encodeURIComponent($('#HDpname').val()) + "&pnum=" + encodeURIComponent($('#HDpnumber').val()),
              fit: true,
              fitColumns: true,
              showFooters: true,
              collapsible: true,
              toolbar: "#toolbar",
              pagination: "true",
              pageSize: 30,
              singleSelect: false,
              sortName: 'PID',               //排序字段
              sortOrder: 'asc',
              remoteSort: false,
              //multiSort:true,
              rownumbers: "true",
              view: detailview,
              onDblClickRow: function (index, row) {
                  parent.addTab('施工图文档->' + row.PNAME, 'crud_tables/archives/show_Construction.aspx?pname=' + encodeURIComponent(row.PNAME) + '&pnumber=' + encodeURIComponent(row.PID) + "&pleader=" + encodeURIComponent(row.PLEADER));
              },
              detailFormatter: function (index, row) {
                  return '<div class="ddv"></div>';
              },
              onExpandRow: function (index, row) {
                  var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                  ddv.panel({
                      border: false,
                      cache: true,
                      href: '../../crud_form/archives/input_constructionMain.aspx?index=' + index + "&flag=" + row.isNewRecord,
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
          if (userlevel == "6") {
              $('#btn_new').css('display', 'none');
              $('#btn_delete').css('display', 'none');
          } else if (userlevel == "1") {
              $('#toolbar').css('display', 'block');
          }
      });

      /// <summary>  
      ///方法说明：存储 
      /// </summary>
      function saveItem(index) {
          //alert(index);
          var row = $('#dg').datagrid('getRows')[index];
          //alert(row);
          var url = row.isNewRecord ? '../../crud_insert/archives/insert_construction.ashx' : '../../crud_update/archives/update_constructionMain.ashx?pna=' + encodeURIComponent(row.PNAME) + "&pnu=" + encodeURIComponent(row.PID);
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


      /// <summary>  
      ///方法说明：撤销、删除 
      /// </summary>
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
                          $.post('../../crud_destroy/archives/destroy_constructionMain.ashx', { PNAME: rows[i].PNAME, PNUMBER: rows[i].PID });
                      $("#dg").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项
                      $('#dg').datagrid('reload');
                  }
              });
          }
      }
      /// <summary>  
      ///方法说明：新增 
      /// </summary>
      function newItem() {
          $('#dg').datagrid('appendRow', { isNewRecord: true });
          var index = $('#dg').datagrid('getRows').length - 1;
          $('#dg').datagrid('expandRow', index);
          $('#dg').datagrid('selectRow', index);
      }
      /// <summary>  
      ///方法说明：查询 
      /// </summary>     
      function FindData() {
          $('#dg').datagrid('load', {
              PNAME: $('#PNAME').val(),
              PID: $('#PID').val()
          });
      }

      ///<summary>
      ///方法说明:导出EXCEL功能
      ///2014.11.2  修复了传输数据时编码不一致导致参数出错的问题
      ///暂无创建时间查询方式
      ///</summary>         
      function Save_Excel() {
          var conditions = '';
          $("#toolbar").each(function () {
              if ($(this).val() !== '')
                  conditions += (' and ' + $(this).attr("id") + ' like \'%' + $(this).val() + '%\'');
          });
          window.location = "../../tools/toExcel.aspx?name=项目编号,项目名称,设计时间,项目负责人,主要工程量,关键字,设计专业,档案号,审核人,备注" +
            " &field=PID,PNAME,DESIGNRQ,PLEADER,MAINWORK,KWORDS,DESIGNSPECIAL,FILENUMBER,REVIEWER,BZ&location=T_construction&condition=" + escape(conditions);

          return false;

      }
      // <summary>  
      ///方日期查询 END，by wya
      /// </summary>         
    </script>

</head>
<body>
     <table id="dg">
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
				<th field="PID"  width="70" sortable="true">项目编号</th>
				<th field="PNAME"  width="70" sortable="true">项目名称</th>
				<th field="PLEADER" width="70">项目负责人</th>
			</tr>
        </thead>
    </table>
    <input type="hidden" id="userLevel" runat="server"/>
    <input type="hidden" id="HDpname" runat="server"/>
    <input type="hidden" id="HDpnumber" runat="server"/>
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true" onclick="return Save_Excel()" >导出</a>
        <span>项目编号:</span><input type="text" id="PID" value="" size="10" /> 
        <span>项目名称:</span><input type="text" id="PNAME" value="" size="10" /> 
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a></div>
</body>
</html>
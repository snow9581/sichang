<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_pipecorrosion.aspx.cs" Inherits="crud_tables_show_event" %>

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
              title: "管道腐蚀穿孔记录",
              url: "../crud_get/get_pipecorrosion.ashx",
              fit: true,
              fitColumns: false,
              showFooters: true,
              collapsible: true,
              toolbar: "#toolbar",
              pagination: "true",
              pageSize: 30,
              singleSelect: false,
              sortName: 'CREATEDATE',               //排序字段
              sortOrder: 'desc',
              remoteSort: false,
              //multiSort:true,
              rownumbers: "true",
              view: detailview,

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
                      href: '../crud_form/input_pipecorrosion.aspx?index=' + index + '&id=' + id,
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
          var url = row.isNewRecord ? '../crud_insert/insert_pipecorrosion.ashx' : '../crud_update/update_pipecorrosion.ashx?ID=' + row.ID;
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
              $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                  if (r) {
                      for (var i = rows.length - 1; i >= 0; i--)
                          $.post('../crud_destroy/destroy_pipecorrosion.ashx', { id: rows[i].ID });
                      $("#dg").datagrid('clearSelections');  //在删除数据成功后清空所有的已选择项
                      $('#dg').datagrid('reload');
                  }
              });
          }
      }
      function go1(val, row) {
          if (row.PIC1 != '#' && row.PIC1 != '' && row.PIC1 != undefined)
              return '<a href="downloadPic.aspx?picName=' + escape(row.PIC1) + '&package=ftpupload" target="_blank">' + '下载' + '</a>  '
          else
              return ''
      }
      function go3(val, row) {
          if (row.PIC3 != '#' && row.PIC3 != '' && row.PIC3 != undefined)
              return '<a href="downloadPic.aspx?picName=' + escape(row.PIC3) + '&package=ftpupload" target="_blank">' + '下载' + '</a>  '
          else
              return ''
      }
      function go2(val, row) {
          if (row.PIC2 != '#' && row.PIC2 != '' && row.PIC2 != undefined)
              return '<a href="downloadPic.aspx?picName=' + escape(row.PIC2) + '&package=ftpupload" target="_blank">' + '下载' + '</a>  '
          else
              return ''
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
          $("#toolbar >input:not(#KSRQ,#JSRQ)").each(function () {
              if ($(this).val() !== '')
                  conditions += (' and ' + $(this).attr("id") + ' like \'%' + $(this).val() + '%\'');
          });
          if ($('#KSRQ').datebox('getValue') !== '')
              conditions += (' and CREATEDATE >= to_date(\'' + $('#KSRQ').datebox('getValue') + '\',\'yyyy-mm-dd\')');
          if ($('#JSRQ').datebox('getValue') !== '')
              conditions += (' and CREATEDATE <= to_date(\'' + $('#JSRQ').datebox('getValue') + '\',\'yyyy-mm-dd\')');
          if ($('#userLevel').val() == '1')
              conditions += (' and DM = \'' + dm + '\'');
          window.location = "../tools/toExcel.aspx?name=矿名,队名,起点名称,终点名称,管道类别,管道名称,管道建设时间,输送介质,管道规格,管道长度,材质,穿孔时间,穿孔所处地类,穿孔原因,穿孔位置,泄漏量,处理方式,是否恢复,处理完成时间,未处理原因,小队负责人,联系方式,创建日期" +
            " &field=KM,DM,QDMC,ZDMC,GDLB,GDMC,GDJSSJ,SSJZ,GDGG,GDCD,GDCZ,CKSJ,CKSCDL,CKYY,CKWZ,XLL,CLFS,SFHF,CLWCSJ,WCLYY,XDFZR,LXFS,CREATEDATE&location=T_PIPECORROSION&condition=" + escape(conditions);

          return false;
      }
      ///方法说明：查询 
      /// </summary>     
      function FindData() {
          $('#dg').datagrid('load', {
              KM: $('#KM').val(),
              DM: $('#DM').val(),
              XDFZR: $('#XDFZR').val(),
              KSRQ: $('#KSRQ').datebox('getValue'),
              JSRQ: $('#JSRQ').datebox('getValue')
          });
      }
      /// <summary> 
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
				<th field="KM"  sortable="true" >矿名</th>
				<th field="DM" sortable="true"  >队名</th>
				<th field="QDMC" >起点名称</th>
				<th field="ZDMC" >终点名称</th>
				
				<th field="GDLB" >管道类别</th>
				<th field="GDMC" >管道名称</th>
				<th field="GDJSSJ">管道建设时间</th>
				<th field="SSJZ"  >输送介质</th>
				
				<th field="GDGG" >管道规格</th>
				<th field="GDCD" >管道长度</th>
				<th field="GDCZ"  >材质</th>
				<th field="CKSJ" >穿孔时间</th>
				
				<th field="CKSCDL" >穿孔所处地类</th>
				<th field="CKYY" >穿孔原因</th>
				<th field="CKWZ" >穿孔位置</th>
				<th field="XLL">泄露量</th>
				
				<th field="CLFS" >处理方式</th>
				<th field="SFHF"  >是否恢复</th>
				<th field="CLWCSJ"  >处理完成时间</th>
				<th field="WCLYY"   >未处理原因</th>
				
				<th field="XDFZR"  >小队负责人</th>
				<th field="LXFS"   >联系方式</th>
				<th field="SFYZP" >是否有照片</th>
				<th field="PIC1"   data-options="field:'PICTURE',formatter:go1"   >照片1下载</th>
				<th field="PIC2"  data-options="field:'PICTURE',formatter:go2"   >照片2下载</th>
				<th field="PIC3" data-options="field:'PICTURE',formatter:go3"   >照片3下载</th>
				<th field="CREATEDATE"  >创建日期</th>
				
			</tr>
        </thead>
    </table>
    <div id="inputd" class="easyui-panel" style="padding:10px;">Dialog Content</div>
    <input type="hidden" id="userLevel" runat="server"/>
    <input type="hidden" id="dm" runat="server"/>
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
         <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true" onclick="return Save_Excel()" >导出</a>
        <span>矿名:</span><input type="text" id="KM" value="" size=10 /> 
        <span>队名:</span><input type="text" id="DM" value="" size=10 />
        <span>小队负责人:</span><input type="text" id="XDFZR" value="" size=10 /> 
        <span>创建时间:</span><input name="KSRQ" id="KSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <span>--</span><input name="JSRQ" id="JSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>

        <div id="formdiv">
        <form id="form" method="post" action="../tools/Upfile.ashx" enctype="multipart/form-data">
        <a href="../File/PIPECORROSION.xls" class="easyui-linkbutton" iconCls='icon-download'">下载模板</a>
        <a href="#" class="easyui-linkbutton" iconCls='icon-upload' onclick="UpFile()"">上传文档</a>
        <input id="File" name="File" type="file" />
        </form>
        </div>
    </div>
</body>
</html>

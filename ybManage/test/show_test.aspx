<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_test.aspx.cs" Inherits="ybManage_text_show_text" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/sichang.js" type="text/javascript"></script>
    <script type="text/javascript">
      $.fn.datebox.defaults.formatter = function (date) {
          var y = date.getFullYear();
          var m = date.getMonth() + 1;
          var d = date.getDate();
          return y + '-' + (m < 10 ? (m) : m) + '-' + (d < 10 ? (+ d) : d);
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
          $(function(){
              $('#dg').datagrid({
                  title: "仪表检定文档",
                  url: "get_test.ashx",
                  fit: true,
                  fitColumns: true,
                  showFooters: true,
                  collapsible: true,
                  toolbar: "#toolbar",
                  pagination: "true",
                  pageSize: 30,
                  singleSelect: false,
                  sortName: 'workitem',               //排序字段
                  sortOrder: 'desc',
                  selectOnCheck:false,
                  remoteSort: false,
                  rownumbers: "true",
                  checkOnSelect:false,
                  //view: detailview,
                  detailFormatter: function (index, row) {
                      return '<div class="cc"></div>';
                  }
                  //onExpandRow: function (index, row) {
                  //    var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                  //    ddv.panel({
                  //        border: false,
                  //        cache: true,
                  //        href: './input_test.aspx?index=' + index,
                  //        onLoad: function () {
                  //            $('#dg').datagrid('fixDetailRowHeight', index);
                  //            $('#dg').datagrid('selectRow', index);
                  //            $('#dg').datagrid('getRowDetail', index).find('form').form('load', row);
                  //        }
                  //    });
                  //    $('#dg').datagrid('fixDetailRowHeight', index);
                  //}
              });
          })
          function destroyItem() { 
              var rows = $('#dg').datagrid("getChecked");
              if (rows.length) {
                  $.messager.confirm('提示', '你确定要删除已选记录吗?', function (r) {
                      if (r) {
                          for (var i = rows.length - 1; i >= 0; i--)
                              $.post('destroy_test.ashx', { id: rows[i].ID });
                          $("#dg").datagrid('clearSelections');  
                          $('#dg').datagrid('reload');
                      }
                  });
              }
          }
          $(document).ready(function () {
              var height1 = $(window).height() - 20;
              $("#cc").attr("style", "width:100%;height:" + height1 + "px");
              $("#cc").layout("resize", {
                  width: "100%",
                  height: height1 + "px"
              });
          });
          $(window).resize(function () {
              var height1 = $(window).height() - 30;
              $("#cc").attr("style", "width:100%;height:" + height1 + "px");
              $("#cc").layout("resize", {
                  width: "100%",
                  height: height1 + "px"
              });
          });
          function Save_Excel() {//导出excel
              var rows = $('#dg').datagrid("getChecked");
              //alert("1");
              //alert("1");
              if (rows.length) {
                  $.messager.confirm('提示', '你确定要导出已选记录吗？', function (r) {
                      if (r) {
                          //alert("1");   
                          var Id = rows[0].ID; ;
                          for (var i = rows.length - 1; i > 0; i--) {
                              Id = Id + "/" + rows[i].ID;
                          }
                          //alert(Id);
                          $.ajax({
                              type: "post",
                              url: "save_excel.ashx",
                              data: { length: rows.length, Id: Id },
                              async: false,
                              success: function (data) {
                                  //alert('生成成功！');
                                  window.location = "./to_Excel.ashx?filename=" + data
                              }
                          });
                          $("#dg").datagrid('clearSelections');
                          $('#dg').datagrid('reload');

                      }
                  });
              }              
          }
          function work(val, row) {
              if (row.workitem == '等待检定') {
                  pic = "<img src='../../images/flag_red.png'/><img src='../../images/flag_red.png'/><img src='../../images/flag_red.png'/>";
              }
              else if (row.workitem == '等待核检') {
                  pic = "<img src='../../images/flag_green.png'/><img src='../../images/flag_red.png'/><img src='../../images/flag_red.png'/>";
              }
              else if (row.workitem == '等待批阅') {
                  pic = "<img src='../../images/flag_green.png'/><img src='../../images/flag_green.png'/><img src='../../images/flag_red.png'/>";
              }
              else {
                  pic = "<img src='../../images/flag_green.png'/><img src='../../images/flag_green.png'/><img src='../../images/flag_green.png'/>";
              }
              var pp = "<a onclick=\"working('" + row.workitem + "'," + row.ID + ")\">" + pic + "</a>";
              return pp;
          }
          function working(state, id) {
              $('#cc').layout('remove', 'north'); //刷新layout
              $('#cc').layout('add', {
                  region: 'north',
                  height: 400,//设置弹出框的高度
                  split: true,
                  collapsed: true,
                  href: "input_test.aspx?ID=" + id
              });
              $('#cc').layout('expand', 'north');
          }
          ///方法说明：查询 
          /// </summary>     
          function FindData() {
              $('#dg').datagrid('load', {
                  YBMC: $('#YBMC').val(),
                  GGXH: $('#GGXH').val()
              });
          }  
        </script>
    </head>
<body>
    <div id="cc" class="easyui-layout" style="width:100%;height:1000px">
        <div data-options="region:'center',split:true" >
            <input id="userLevel" runat="server" type="hidden"/>
            <input id="xx" runat="server" type="hidden"/>
            <input id="dm" runat="server" type="hidden"/>
            <div id="toolbar">
               <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
               <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true" onclick="Save_Excel()" size="20">导出</a> 
               <span>仪表名称:</span><input type="text" name="YBMC" id="YBMC" value="" class="easyui-validatebox" size="12"/>
               <span>规格型号:</span><input type="text" id="GGXH" name="GGXH" value="" class="easyui-validatebox" size="12"/> 
               <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>
                <input type="hidden" runat="server" name="iid" id="iid" />
            </div>
            <table id="dg">
                <thead>
                    <tr>                 
                        <th data-options="field:'ck',checkbox:true"></th>
                        <th data-options="field:'pic',formatter:work,width:50,align:'center'">状态</th>
                        <th field="workitem" sortable="true" hidden="hidden">状态</th>
        		        <th field="COMPANY"  sortable="true" width="80">送检单位</th>
        		        <th field="YBMC"  sortable="true" width="80">仪表名称</th>
        		        <th field="GGXH"  width="100">型号/规格</th>
        		        <th field="CCBH"  width="100">出厂编号</th>				
        		        <th field="ZQDDJ" width="50">准确度等级</th>				
        		        <th field="SCCJ"  width="100">生产厂家</th>
                        <th field="COMPETENT"  width="50">主管</th>
        		        <th field="CHECKER"  width="70">核检员</th>				
        		        <th field="TEXTER" width="50">检定员</th>				
        		        <th field="TEXTDATE"  width="70">检定日期</th>
                        <th field="VALIDDATE"  width="50">有效日期</th>
        		        <th field="MAXERROR"  width="70">最大误差</th>				
			         </tr>
                </thead>
            </table>
        </div>
    </div>
</body>
</html>

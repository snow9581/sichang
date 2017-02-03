<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_meter.aspx.cs" Inherits="ybManage_meter_show_meter" %>
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
              title: "仪表管理",
              url: "get_meter.ashx",
              fit: true,
              fitColumns: false,
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
                      href: "input_meter.aspx?index=" + index, ///../crud_form/
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
          var dm = $('#dm').val();
          if ((userlevel == "2" || userlevel == "6" || userlevel == "4")&&dm!="仪表室")
          {
              $('#btn_new').css('display', 'none');
              $('#btn_delete').css('display', 'none');
          } else if (userlevel == "1") {
              $('#toolbar').css('display', 'block');
          }
          if (userlevel != "1")
          {
              $('formdiv').css('display', 'none');
          }
      });
      </script>
    <script type ="text/javascript">
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
                              url: "destroy_meter.ashx",
                              data: "ID=" + rows[i].ID,
                              async: false,
                              success: function (data) {
                                  if (data == "1") {
                                      var index = $('#dg').datagrid('getRowIndex', rows[i]);
                                      $('#dg').datagrid('deleteRow', index);
                                      $('#dg').datagrid('reload');
                                  }
                                  else
                                      alert("删除失败！");
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
      ///<summary>
      ///方法说明:导出EXCEL功能
      ///2014.11.2  修复了传输数据时编码不一致导致参数出错的问题
      ///暂无创建时间查询方式
      ///</summary>  
      function Save_Excel() {
          var dm=$('#dm').val();
          var conditions='';
          $("#toolbar >input:not(#JDRQ1,#JSRQ2)").each(function(){
              if ($(this).val()!= '')
               conditions += (' and ' + $(this).attr("id") + ' like \'%' + $(this).val() + '%\'');
          });
          if ($('#KM').combobox('getValue') != '')
              conditions += (' and KM=\'%' + $('#KM').combobox('getValue') + '%\'');
          
          if (dm!="" && $('#userLevel').val() == '1')
              conditions += (' and DM = \'' + dm + '\'');
          else if ($('#DM').combobox('getValue') != '')
              conditions += (' and DM=\'%' + $('#DM').combobox('getValue') + '%\'');
          else
              conditions += (' and DM=\'%仪表室%\'');

          if ($('#JDRQ1').datebox('getValue')!= '')
              conditions += (' and JDRQ >= to_date(\'' + $('#JDRQ1').datebox('getValue') + '\',\'yyyy-mm-dd\')');
          if ($('#JDRQ2').datebox('getValue')!= '')
              conditions += (' and JDRQ <= to_date(\'' + $('#JDRQ2').datebox('getValue') + '\',\'yyyy-mm-dd\')');
              
            window.location = "../../tools/toExcel.aspx?name=管理分类,仪表名称,矿名,队名,安装地点,规格型号,生产厂家,出厂编号,出厂日期,准确度等级,测量范围,检定周期,检定单位,检定日期,检定结果,管理状态,是否外送,备注" 
            +" &field=YBFL,YBMC,KM,DM,AZDD,GGXH,SCCJ,CCBH,CCRQ,ZQDDJ,LC,JDZQ,JDDW,JDRQ,JDJG,GLZT,SFWS,BZ&location=T_METER&condition="+escape(conditions);
          return false;
      }
     
      ///方法说明：查询 
      /// </summary>     
      function FindData() {
          $('#dg').datagrid('load', {
              KM: $('#KM').combobox('getValue'),///下拉框的获取数值方法*王钧泽学长1月14日
              DM: $('#DM').combobox('getValue'),
              JDRQ1: $('#JDRQ1').datebox('getValue'),
              JDRQ2: $('#JDRQ2').datebox('getValue'),
              GGXH: $('#GGXH').val(),
              AZDD: $('#AZDD').val(),
              SCCJ: $('#SCCJ').val(),
              JDDW: $('#JDDW').val()
          });
      }
      function UpFile() {
          $('#form').form('submit', {
              url: "../../tools/Upfile.ashx",
              onSubmit: function () {
              },
              success: function (data) {
              }
          });
      }
      /// <summary> 
    </script>
     <script type="text/javascript">
         function saveItem(index) {
             //alert(index);
             var row = $('#dg').datagrid('getRows')[index];
             var url = row.isNewRecord ? 'insert_meter.ashx' : 'update_meter.ashx?ID='+row.ID;
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
  <script type="text/javascript">///迭代关系的实现
   $(function Bind() {
          var KM = $('#KM').combobox({
          valueField: 'text', //值字段
          textField: 'text', //显示的字段
        url: '../../tools/getKM.ashx',
          editable: true,
          onChange: function (newValue, oldValue) {
          $.get('../../tools/getDM.ashx', { meter : newValue }, function (data) {
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
</head>
<body>
    <input type="hidden" id="idid" name="idid" runat="server" value=""/>
     <table id="dg">
        <thead>
            <tr>
               <th data-options="field:'ck',checkbox:true"></th>
                <th field="YBFL"   width="80" sortable="true">管理分类</th>
                <th field="YBMC"   width="100" sortable="true">仪表名称</th>
				<th field="KM"     width="100" sortable="true">矿名    </th>
				<th field="DM"     width="100" sortable="true">队名    </th>
                <th field="AZDD"   width="100" sortable="true">安装地点</th>
                <th field="GGXH"   width="100" sortable="true">规格型号</th>
                <th field="SCCJ"   width="150" sortable="true">生产厂家</th>
                <th field="CCBH"   width="150" sortable="true">出厂编号</th>
                <th field="CCRQ"   width="100" sortable="true">出厂日期</th>
                <th field="ZQDDJ"  width="100" sortable="true">准确度等级</th>
                <th field="LC"     width="100" sortable="true">测量范围 </th>
                <th field="JDZQ"   width="100" sortable="true">检定周期</th>
				<th field="JDDW"   width="100" sortable="true">检定单位</th>
                <th field="JDRQ"   width="100" sortable="true">检定日期</th>
                <th field="JDJG"   width="100" sortable="true">检定结果</th>
				<th field="GLZT"   width="100" sortable="true">管理状态</th>
                <th field="SFWS"   width="100" sortable="true">送检/自检</th>
				<th field="BZ"     width="100" >备注</th>
			</tr>
        </thead>
    </table>
    <div id="inputd" class="easyui-panel" style="padding:10px;">Dialog Content</div>
    <input type="hidden" id="userLevel" runat="server"/>
    <input type="hidden" id="dm" runat="server"/>
    <div id="toolbar">
        <div style=" float:left">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
         <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true" onclick="return Save_Excel()" >导出</a>
         </div>
     <%--   <span>矿名</span>///自制的下拉框
         <select class="easyui-combobox"  name="KM" id="KM" >
            <option value="第一油矿">第一油矿</option>
            <option value="第二油矿">第二油矿</option>
            <option value="第三油矿">第三油矿</option>
            <option value="第四油矿">第四油矿</option>
            <option value="第五油矿">第五油矿</option>
            </select>--%>  
        <div>
            <table style=" text-align:right">
            <tr>
                <td><span>矿名:</span><input name="KM" class="easyui-combobox"type="text" id="KM" value="" size='12'/>&nbsp;</td>
                <td><span>队名:</span><input name="DM" class="easyui-combobox"type="text" id="DM" value="" size='18'/>&nbsp;</td>
                <td colspan="2"><span>检定日期:</span><input name="JDRQ1" id="JDRQ1" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
                <span>--</span><input name="JDRQ2"id="JDRQ2"class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />&nbsp;</td>
            </tr>
            <tr>
                 <td><span>规格型号:</span><input type="text" id="GGXH" name="GGXH" value="" size='20'/>&nbsp;</td>
                 <td><span>安装地点:</span><input type="text" name="AZDD" id="AZDD" value="" size='20'/>&nbsp;</td>
                 <td><span>生产厂家:</span><input type="text" name="SCCJ" id="SCCJ" value="" size='20'/>&nbsp;</td>
                 <td><span>检定单位:</span><input type="text" id="JDDW" name="JDDW" value="" size='20'/>&nbsp;</td>
                 <td><a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a></td>
             </tr>
             </table>
          </div>
    <div id="formdiv">
        <form id="form" method="post" action="../../tools/Upfile.ashx" enctype="multipart/form-data">
        <a href="../../File/METER.xls" class="easyui-linkbutton" iconCls='icon-download'">下载模板</a>
        <a href="#" class="easyui-linkbutton" iconCls='icon-upload' onclick="UpFile()"">上传文档</a>
        <input id="File" name="File" type="file" />
        </form>
    </div>
   </div>
</body>
</html>

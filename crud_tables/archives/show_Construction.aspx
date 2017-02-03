

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_Construction.aspx.cs" Inherits="crud_tables_show_event" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../../js/export.js" type="text/javascript"></script>
<script type="text/javascript">
///<summary> 
  ///模块编号：archives-04 电子档案管理子系统4号模块 施工图文档表 table功能代码   
  ///作用：<含最初方案、上报方案、审查后方案进行存储> <可按每个字段进行排序，有导出及下载功能>
  ///作者：by wya 
  ///编写日期：2014-08-26  
///</summary>
    $.fn.datebox.defaults.formatter = function(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
    };
    $.fn.datebox.defaults.parser = function(s) {
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
/// <summary>  
 
///方法说明：显示表单 及 排序 ？？？
/// </summary>
      $(function () {
          $('#dg').datagrid({
              title: "施工图文档->" + $('#HDpname').val(),
              url: "../../crud_get/archives/get_construction.ashx?pname=" + encodeURIComponent($('#HDpname').val()) + "&pnumber=" + encodeURIComponent($('#HDpnumber').val()),
              fit: true,
              fitColumns: true,
              showFooters: true,
              collapsible: true,
              toolbar: "#toolbar",
              pagination: "true",
              pageSize: 30,
              singleSelect: false,
              sortName: 'DESIGNSPECIAL',               //排序字段
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
                      href: '../../crud_form/archives/input_construction.aspx?index=' + index + "&pname=" + encodeURIComponent($('#HDpname').val()) + "&pnumber=" + encodeURIComponent($('#HDpnumber').val()) + "&pleader=" + encodeURIComponent($('#HDpleader').val()),
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
            var url = row.isNewRecord ? '../../crud_insert/archives/insert_construction.ashx' : '../../crud_update/archives/update_construction.ashx?ID='+row.ID;
            //alert(url);
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


/// <summary>  
 
///方法说明：撤销、删除 
/// </summary>
        function cancelItem(index) {
            var row = $('#dg').datagrid('getRows')[index];
            if (row.isNewRecord) {
                $('#dg').datagrid('deleteRow', index);
            } else {
                $('#dg').datagrid('collapseRow', index);0
            }
        }
        function destroyItem() {                   //刘靖  可批量删除 2014.11.13
            var rows = $('#dg').datagrid("getChecked"); 
            if (rows.length) {
                $.messager.confirm('提示', '你确定要删除已选记录吗?', function(r) {
                    if (r) {
                    for(var i =rows.length-1;i>=0;i--)        
                        $.post('../../crud_destroy/archives/destroy_construction.ashx', { ID: rows[i].ID });                   
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
       function FindData(){ 
            $('#dg').datagrid('load',{
             KWORDS: $('#KWORDS').val(),
             KSRQ: $('#KSRQ').datebox('getValue'),
             JSRQ: $('#JSRQ').datebox('getValue') 
           });
        } 
/// <summary>  
///方法说明：ftp 生成下载链接，by wya
/// </summary>   
        function go(val, row) {
        // 高俊涛修改 2014-09-07 将文件名隐藏为下载
        //alert(row.pid);
         if(row.FILES!='#' && row.FILES!=''&&row.FILES!=undefined)
            return '<a href="../downloadPic.aspx?picName=' + escape(row.FILES) + '&package=archives" target="_blank">' + '下载' + '</a>  '       
            else 
            return ''
         // return '<a href="downloadPic.aspx?picName=' + escape(row.FILES) + '&package='ftpimage'" target="_blank">' + row.FILES + '</a>  '      
        }   
/// <summary>  
///方法说明：日期查询 格式化，by wya
/// </summary>   
        function getdate(){
                var myDate = new Date();
                var time = myDate.getFullYear()+"-"+(myDate.getMonth()+1)+"-"+myDate.getDate();
                $("#KSRQ").datebox('setValue', time);
                $("#JSRQ").datebox('setValue', time);
                }
///setValue是EasyUI固定的写法。
        function myformatter(date) {
          var y = date.getFullYear();
          var m = date.getMonth() + 1;
          var d = date.getDate();
          return y + '-' + (m < 10 ? ('0' + m) : m) + '-'+ (d < 10 ? ('0' + d) : d);
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
 ///<summary>
///方法说明:导出EXCEL功能
///2014.11.2  修复了传输数据时编码不一致导致参数出错的问题
///暂无创建时间查询方式
///</summary>         
        function Save_Excel() {
            var conditions='';
             $("#toolbar >input:not(#KSRQ,#JSRQ)").each(function(){
             if($(this).val()!=='')
                conditions+=(' and '+$(this).attr("id")+' like \'%'+$(this).val()+'%\'');  
             });
             if($('#KSRQ').datebox('getValue')!=='')
                conditions+=(' and CREATEDATE >= to_date(\''+$('#KSRQ').datebox('getValue')+'\',\'yyyy-mm-dd\')');
             if($('#JSRQ').datebox('getValue')!=='')
                conditions+=(' and CREATEDATE <= to_date(\''+$('#JSRQ').datebox('getValue')+'\',\'yyyy-mm-dd\')');
            window.location="../../tools/toExcel.aspx?name=项目编号,项目名称,设计时间,项目负责人,主要工程量,关键字,设计专业,档案号,审核人,备注"+
            " &field=PID,PNAME,DESIGNRQ,PLEADER,MAINWORK,KWORDS,DESIGNSPECIAL,FILENUMBER,REVIEWER,BZ&location=T_construction&condition="+escape(conditions);
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
                <th field="DESIGNSPECIAL"   width="50" sortable="true">设计专业</th>
                <th field="SPECIALPERSON"   width="50" sortable="true">专业负责人</th>
				<th field="FILENUMBER"  width="50" >档案号</th>
				<th field="REVIEWER"  width="50" >审核人</th>
                <th field="DESIGNRQ" width="50" sortable="true">设计时间</th>
				<th field="MAINWORK" width="80" sortable="true">主要工程量</th>
                <th field="KWORDS"  width="50"sortable="true">关键字</th>
				<th field="BZ"  width="50" >备注</th>
				<th data-options="field:'FILES',formatter:go"  width="50">施工图文档</th>
                <th field="ARRIVALDATE" width="50" sortable="true">蓝图下发时间</th>
			</tr>
        </thead>
    </table>
    <div id="inputd" class="easyui-panel" style="padding:10px;">Dialog Content</div>
    <input type="hidden" id="userLevel" runat="server"/>
    <input type="hidden" id="HDpname" runat="server"/>
    <input type="hidden" id="HDpnumber" runat="server"/>
    <input type="hidden" id="HDpleader" runat="server"/>
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true" onclick="return Save_Excel()" >导出</a>
        <span>关键字:</span><input type="text" id="KWORDS" value="" size="10" /> 
        <span>设计时间:</span><input name="KSRQ" id="KSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <span>--</span><input name="JSRQ" id="JSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a></div>


</body>
</html>

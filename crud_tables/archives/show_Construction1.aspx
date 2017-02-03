﻿

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_Construction1.aspx.cs" Inherits="crud_tables_show_event" %>

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
///<summary> 
  ///模块编号：archives-07 电子档案管理子系统7号模块 施工图借阅文档表 table功能代码   
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
        $(function() {
            $('#dg').datagrid({
                title: "施工图借阅文档",
                url: "../../crud_get/archives/get_construction1.ashx",//
                //url: "./show_construction1.ashx",//
                fit: true,
                fitColumns: true,
                showFooters: true,
                collapsible: true,
                toolbar: "#toolbar",
                pagination: "true",
                pageSize:30,
                singleSelect: false,
                sortName: 'PID',               //排序字段
                sortOrder: 'asc',               
                remoteSort:false,                
                //multiSort:true,
                rownumbers:"true",
                view: detailview,

                detailFormatter: function(index, row) {
                    return '<div class="ddv"></div>';
                },
                onExpandRow: function(index, row) {
                    var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                    ddv.panel({
                        border: false,
                        cache: true,
                        href:'../../crud_form/archives/input_construction1.aspx?index=' + index,
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
            var url = row.isNewRecord ? '../../crud_insert/archives/insert_construction1.ashx' : '../../crud_update/archives/update_construction1.ashx?ID=' + row.ID;
           // alert(url);
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
                $('#dg').datagrid('collapseRow', index);
            }
        }
        function destroyItem() {                   //刘靖  可批量删除 2014.11.13
            var rows = $('#dg').datagrid("getChecked"); 
            if (rows.length) {
                $.messager.confirm('提示', '你确定要删除已选记录吗?', function(r) {
                    if (r) {
                    for(var i =rows.length-1;i>=0;i--)        
                        $.post('../../crud_destroy/archives/destroy_construction1.ashx', { ID: rows[i].ID });                   
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
///方法说明：查询 
/// </summary>     
       function FindData(){ 
           //if($("#KWORDS").val()=="") { 
          // alert("请输入关键字！"); 
          // } 
            $('#dg').datagrid('load',{
             //KWORDS: $('#KWORDS').val(),
             PID: $('#PID').val(),
             PNAME:$('#PNAME').val(),
             KSRQ: $('#KSRQ').datebox('getValue'),
             JSRQ: $('#JSRQ').datebox('getValue') 
           });
        } 
/// <summary> 
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
               
            window.location="../../tools/toExcel.aspx?name=存档号,设计专业,文件号,项目编号,项目名称,设计日期,存档日期,项目负责人,审核人,文字页数,折合一号图,存档情况,借阅日期,借阅人,归还日期,归还人,备注"+
            " &field=ARCHIVENO,DESIGNSPECIAL,FILENUMBER,PID,PNAME,DESIGNRQ,ARCHIVERQ,PLEADER,REVIEWER,PAGENO,ONEFIGURE,ARCHIVESTATE,BORROWRQ,BORROWER,RETURNRQ,RETURNER,BZ&location=T_construction1&condition="+escape(conditions);

            return false;
            
        }
// <summary>  
///方日期查询 END，by wya
/// </summary>         
        
    </script>

 
    <style type="text/css">
        .style1
        {
            width: 73px;
        }
        .style2
        {
            width: 64px;
        }
        .style3
        {
            width: 65px;
        }
    </style>

 
</head>
<body>
     <table id="dg">
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th field="ARCHIVENO"  width="50" sortable="true">存档号</th>
				<th field="DESIGNSPECIAL"  width="50" sortable="true">设计专业</th>
				<th field="FILENUMBER" class="style1"sortable="true">文件号</th>
				<th field="PID"  width="50" sortable="true">项目编号</th>
				<th field="PNAME"  width="50" sortable="true">项目名称</th>
				<th field="DESIGNRQ" class="style1"sortable="true">设计日期</th>
				<th field="ARCHIVERQ" class="style1"sortable="true">存档日期</th>				
				<th field="PLEADER" class="style2">项目负责人</th>
				<th field="REVIEWER"  width="50" >审核人</th>
				<th field="PAGENO"  width="50" sortable="true">文字页数</th>
				<th field="ONEFIGURE" class="style3" sortable="true">折合一号图</th>
				<th field="ARCHIVESTATE"  width="50"sortable="true">存档情况</th>
				<th field="BORROWRQ"   width="50" sortable="true">借阅日期</th>
				<th field="BORROWER"   width="50" sortable="true">借阅人</th>
				<th field="RETURNRQ"   width="50" sortable="true">归还日期</th>
				<th field="RETURNER"   width="50" sortable="true">归还人</th>				
				<th field="BZ"  width="50" >备注</th>
			</tr>
        </thead>
    </table>
    <div id="inputd" class="easyui-panel" style="padding:10px;">Dialog Content</div>
    <input type="hidden" id="userLevel" runat="server"/>
    <div id="toolbar">
        <a href="#" id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true" onclick="return Save_Excel()" >导出</a>
        <span>项目编号:</span><input type="text" id="PID" value="" size=10 /> 
        <span>项目名称:</span><input type="text" id="PNAME" value="" size=10 /> 
        <span>借阅时间:</span><input name="KSRQ" id="KSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <span>--</span><input name="JSRQ" id="JSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a></div>


</body>
</html>

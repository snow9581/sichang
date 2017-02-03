<%@ Page Language="C#" AutoEventWireup="true" CodeFile="show_house.aspx.cs" Inherits="crud_tables_show_house" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/export.js" type="text/javascript"></script>
<script type="text/javascript">
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

        $(function () {
            $('#dg').datagrid({
                title: "房屋信息",
                url: "../crud_get/get_house.ashx",
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
                selectOnCheck: true,

                detailFormatter: function (index, row) {
                    return '<div class="ddv"></div>';
                },
                onExpandRow: function (index, row) {
                    var ddv = $(this).datagrid('getRowDetail', index).find('div.ddv');
                    ddv.panel({
                        border: false,
                        cache: true,
                        href: '../crud_form/input_house.aspx?index=' + index,
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
/// <summary>  

        function saveItem(index) {
            var row = $('#dg').datagrid('getRows')[index];
            var url = row.isNewRecord ? '../crud_insert/insert_house.ashx' : '../crud_update/update_house.ashx?ID=' + row.ID;
            $('#dg').datagrid('getRowDetail', index).find('form').form('submit', {
                url: url,
                onSubmit: function () {
                    //                    var isValid = $(this).form('validate');
                    //                    if (!isValid) {
                    //                        $.messager.progress('close'); // hide progress bar while the form is invalid
                    //                    }
                    //                    return isValid; // return false will stop the form submission
                    //alert("success");
                    $("#save").removeAttr("onclick");
                    return $(this).form('validate');
                },
                success: function (data) {
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
                        for (var i = rows.length - 1; i >= 0; i--) {
                            $.post('../crud_destroy/destroy_house.ashx', { id: rows[i].ID });                           
                        }
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
          if(row.PICTURE!='#' && row.PICTURE!=''&& row.PICTURE!=undefined)
            return '<a  href="downloadPic.aspx?picName=' + escape(row.PICTURE) + '&package=ftpimage" target="_blank">' + '下载' + '</a>  '       
          else 
            return ''
         // return '<a href="downloadPic.aspx?picName=' + escape(row.PICTURE) + '&package='ftpimage'" target="_blank">' + row.PICTURE + '</a>  '      
        }

///<summary>
///方法说明:导出EXCEL功能
///2014.11.2  修复了传输数据时编码不一致导致参数出错的问题
///暂无创建时间查询方式
///</summary>  
        function Save_Excel() {
            var dm=$('#dm').val();
            var conditions='';
             $("#toolbar >input:not(#KSRQ,#JSRQ)").each(function(){
             if($(this).val()!=='')
                conditions+=(' and '+$(this).attr("id")+' like \'%'+$(this).val()+'%\'');  
             });
             if($('#KSRQ').datebox('getValue')!=='')
                conditions+=(' and CREATEDATE >= to_date(\''+$('#KSRQ').datebox('getValue')+'\',\'yyyy-mm-dd\')');
             if($('#JSRQ').datebox('getValue')!=='')
                 conditions += (' and CREATEDATE <= to_date(\'' + $('#JSRQ').datebox('getValue') + '\',\'yyyy-mm-dd\')');
             if ($('#userLevel').val() == '1')
                 conditions += (' and DM = \'' + dm + '\'');
            window.location="../tools/toExcel.aspx?name=矿名,队名,所属站名,房屋名称,房屋功能,投产日期,建筑面积,房屋结构,防水方式,最近维修日期,维修内容,备注,创建日期"+
            " &field=KM,DM,ZM,HNAME,HFUNCTION,TCRQ,HAREA,HSTRUCTURE,FSFS,WXRQ,WXNR,BZ,CREATEDATE&location=T_HOUSE&condition="+escape(conditions);
            return false;         
            
        }
           
          

///方法说明：查询 
/// </summary>     
       function FindData(){ 
            $('#dg').datagrid('load',{
             KM: $('#KM').val(),
             DM: $('#DM').val(),
             ZM: $('#ZM').val(),
             KSRQ: $('#KSRQ').datebox('getValue'),
             JSRQ: $('#JSRQ').datebox('getValue') 
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
				<th field="KM"   width="100" sortable="true">矿名</th>
				<th field="DM"   width="100" sortable="true">队名</th>
				<th field="ZM"  width="100" sortable="true">所属站名</th>
				<th field="HNAME"  width="100" sortable="true">房屋名称</th>
				<th field="HFUNCTION"  width="100">房屋功能</th>
				<th field="TCRQ" width="100">投产日期</th>
				<th field="HAREA"  width="100">建筑面积</th>
				<th field="HSTRUCTURE"  width="100">房屋结构</th>				
				<th field="FSFS"  width="100">防水方式</th>
				<th field="WXRQ"  width="100">最近维修日期</th>
				<th field="WXNR" width="100">维修内容</th>
				<th data-options="field:'PICTURE',formatter:go"  width="100">图片</th>
				<th field="BZ"  width="100">备注</th>
				<th field="CREATEDATE"  width="100">创建日期</th>
			
			</tr>
        </thead>
    </table>
    <div id="inputd" class="easyui-panel" style="padding:10px;">Dialog Content</div>
    <input type="hidden" id="userLevel" runat="server"/>
    <input type="hidden" id="dm" runat="server"/>
    <div id="toolbar">
        <a href="#"  id="btn_new" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newItem()">新建</a> 
        <a href="#" id="btn_delete" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-save" plain="true"  onclick="return Save_Excel()" >导出</a>
        <span><label for="KM">矿名:</label></span><input class="easyui-textbox" id="KM" value="" size="10" /> 
        <span><label for="DM">队名:</label></span><input class="easyui-textbox" id="DM" value="" size="10" />
        <span><label for="ZM">所属站名:</label></span><input class="easyui-textbox" id="ZM" value="" size="10" />
        <span>创建时间：</span><input name="KSRQ" id="KSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <span>--</span><input name="JSRQ" id="JSRQ" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" />
        <a href="#" class="easyui-linkbutton" iconCls='icon-search' onclick="FindData()"">查询</a>

        <div id="formdiv">
        <form id="form" method="post" action="../tools/Upfile.ashx" enctype="multipart/form-data">
        <a href="../File/HOUSE.xls" class="easyui-linkbutton" iconCls='icon-download'">下载模板</a>
        <a href="#" class="easyui-linkbutton" iconCls='icon-upload' onclick="UpFile()"">上传文档</a>
        <input id="File" name="File" type="file" />
        </form>
        </div>
    </div>
</body>
</html>

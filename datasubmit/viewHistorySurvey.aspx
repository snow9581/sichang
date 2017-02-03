<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewHistorySurvey.aspx.cs" Inherits="datasubmit_viewProgress" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--主管所长查看历史调查-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/sichang.js" type="text/javascript"></script>
    <script src="../js/export.js" type="text/javascript"></script>
  <script type="text/javascript">

        $(function() {
            $('#dg').datagrid({
                title: "查看历史调查记录",
                url: "./viewHistorySurvey.ashx",
                fit: true,
                fitColumns: true,
                showFooters: true,
                collapsible: true,
               
                pagination: "true",
                pageSize:30,
                singleSelect: "true",
                sortName: '',               //排序字段
                sortOrder: 'asc',               
                remoteSort:false,                
                //multiSort:true,
                //view: detailview,

                onLoadSuccess: function(data) {
                    if (data.rows.length > 0) {
                        //调用mergeCellsByField()合并单元格
                     //   mergeCellsByField("dg", "NAME,INITDATE,WORDNAME0,EXCELNAME0");
                     GMergeCells("dg", "INITDATE");
                    }
             },
             loader: SCLoader  
            });
        });


        /**
        * EasyUI DataGrid根据字段动态合并单元格
        * @param tableID 要合并table的id
        * @param colList 要合并的列,用逗号分隔(例如："name,department,office");
        */
        function mergeCellsByField(tableID, colList) {
            var ColArray = colList.split(",");
            var tTable = $('#' + tableID);
            var TableRowCnts = tTable.datagrid("getRows").length;
            var tmpA;
            var tmpB;
            var PerTxt = "";
            var CurTxt = "";
            var alertStr = "";
            for (j = ColArray.length - 1; j >= 0; j--) {
                PerTxt = "";
                tmpA = 1;
                tmpB = 0;

                for (i = 0; i <= TableRowCnts; i++) {
                    if (i == TableRowCnts) {
                        CurTxt = "";
                    }
                    else {
                        CurTxt = tTable.datagrid("getRows")[i][ColArray[j]];
                    }
                    if (PerTxt == CurTxt) {
                        tmpA += 1;
                    }
                    else {
                        tmpB += tmpA;
                        tTable.datagrid('mergeCells', {
                            index: i - tmpA,
                            field: ColArray[j],
                            rowspan: tmpA,
                            colspan: null
                        });
                        tmpA = 1;
                    }
                    PerTxt = CurTxt;
                }
            }
        }


      

        function goWord(val, row) {
            return '<a href="downloadPic.aspx?picName=' + escape(row.WORDNAME) + '&package=materialsubmit" target="_blank">' + row.WORDNAME + '</a>  '
            // return '<a href="ftp://administrator:@58.155.47.128/ftpupload/' + row.PICTURE + '" target="_blank">下载</a>'

        }
        function goExcel(val, row) {

           if(row.EXCELNAME0!='') return '<a href="downloadPic.aspx?picName=' + escape(row.EXCELNAME) + '&package=materialsubmit" target="_blank">下载</a>  '
           // return '<a href="downloadFile.aspx?picName=' + escape(row.EXCELNAME) + '" target="_blank">' + row.EXCELNAME + '</a>  '
            // return '<a href="ftp://administrator:@58.155.47.128/ftpupload/' + row.PICTURE + '" target="_blank">下载</a>'

        }

        function goWord0(val, row) {
            return '<a href="downloadPic.aspx?picName=' + escape(row.WORDNAME0) + '&package=materialsubmit" target="_blank">' + row.WORDNAME0 + '</a>  '
        }
        function goExcel0(val, row) {

           if(row.EXCELNAME0!='') return '<a href="downloadPic.aspx?picName=' + escape(row.EXCELNAME0) + '&package=materialsubmit" target="_blank">下载</a>  '


        }
    
    </script>
  
</head>
<body>
     <table id="dg">
        <thead>
            <tr>
				<th field="NAME"   width="50" sortable="true">主题</th>
				<th field="INITDATE"  width="50" >发起时间</th>
				<th field="MINERNAME"  width="50">矿名</th>
                <th hidden="true" data-options="field:'WORDNAME0',formatter:goWord0"  width="50">汇总表word</th>
				<th data-options="field:'EXCELNAME0',formatter:goExcel0"  width="50">汇总报告</th>
				<th field="TEAMNAME"  width="50">小队</th>
				<%--<th field="WORDNAME"   width="50" >word下载</th>
				<th field="EXCELNAME"  width="50" >excel下载</th>--%>
				<th hidden="true" data-options="field:'WORDNAME',formatter:goWord"  width="50">调查表word</th>
				<th data-options="field:'EXCELNAME',formatter:goExcel"  width="50">调查报告</th>
			</tr>
        </thead>
    </table>
  
</body>
</html>

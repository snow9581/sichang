<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewProgress.aspx.cs" Inherits="datasubmit_viewProgress" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--室主任查看进度-->
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
                title: "查看进度",
                url: "./viewProgress.ashx",
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
                nowrap:false,           
                //multiSort:true,
                //view: detailview,

                onLoadSuccess: function(data) {
                    if (data.rows.length > 0) {
                        //调用mergeCellsByField()合并单元格
                     //   mergeCellsByField("dg", "NAME,WORD,EXCEL,INITDATE,LEADERCHECK");
                      GMergeCells("dg", "NAME,WORD,EXCEL,INITDATE,LEADERCHECK");
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


        function cellStyler(value, row, index) 
        {
            if (value!=""&&value<1) {
               return  'background-color:#ffee00;color:red;';
            } 
        }
       
        function go1(val, row) {
            // 高俊涛修改 2014-10-10 主管所长审核意见
         if (val=='1') return '通过['+row.LEADER+']审核'+'<br>'+row.CHECKTIME;
         else if (val == '0') return '[' + row.LEADER + ']拒绝<div  style="border-bottom:1px solid #000;color:#000;cursor:pointer" onclick="alert(\'审核意见：' + row.LEADEROPINION.replace(/\<br\/\>/g, " ") + '\')">查看意见</div>' + row.CHECKTIME;
            else return '等待['+row.LEADER+']审核';
       //     return '<a href="downloadPic.aspx?picName=' + escape(row.PICTURE) + '" target="_blank">' + '下载' + '</a>  '       

        }
       function go3(val, row) {
        // 高俊涛修改 2014-09-07 将文件名隐藏为下载
         if(row.LEADERCHECK=='1'){
         if (val=='1') return '通过审核';
            else if(val=='0')  return '拒绝';
                 else if(val=='2') return '已接收，待审核 <br>'+row.RECEIVETIME;
                       else return '未接收';    
        } else{
              return "";
           }
        }
        function go4(val, row) {
        // 高俊涛修改 2014-09-07 将文件名隐藏为下载
         if(row.LEADERCHECK=='1'){
             if (val=='1') return '通过审核';
                else if(val=='0')  return '拒绝';
                    else  if(val=='2') return '已接收，待审核';
                       else return '未接收';               
           } else{
              return "";
           }
        }
        function go2(val, row) {
            // 高俊涛修改 2014-09-07 将文件名隐藏为下载
            if (val == '1') return '是';
            else return '否';
            //     return '<a href="downloadPic.aspx?picName=' + escape(row.PICTURE) + '" target="_blank">' + '下载' + '</a>  '       

        }    
        function go5(val, row) {
          
          // 调查大纲，包括文本和文件两种

            var result = '';
            if (row.REQUIREMENTS != "" && row.REQUIREMENTS != null)
                row.REQUIREMENTS = row.REQUIREMENTS.replace(/\<br\/\>/g, "\\n");
          if((val!='#')&&(val!=''))  result=result + ' <a href=\"downloadPic.aspx?picName=' +val + '&package=materialsubmit\">下载</a>  ';       
          if(row.REQUIREMENTS!='')  result=result+'<a href="#" onclick=$.messager.alert(\'调查要求\',\''+row.REQUIREMENTS+'\')>查看要求</a>';        
          return result;
        }     
        function go6(val, row) {
            // 高俊涛修改 2014-09-07 将文件名隐藏为下载
          if((val!='#')&&(val!=''))  return '<a href=\"downloadPic.aspx?picName=' +val + '&package=materialsubmit\">下载</a>  ';       
             else return '';

        }    
        function go7(val, row) {
            // 高俊涛修改 2014-09-07 将文件名隐藏为下载
            if (val != '') return val+'<br> ['+row.GYKD+']';            
        }    
        function go8(val, row) {
            // 高俊涛修改 2014-09-07 将文件名隐藏为下载
            if (val != '') return val;            
        }  
        function go9(val,row){          
          if(row.MINERCHECK=='1') 
          {
           var result='<ul>';
           
           if(row.WEXCEL!='#'){//存在汇总报告
              result=result+'<li><a href="downloadPic.aspx?picName='+row.WEXCEL+'&package=materialsubmit">汇总下载</a></li> ';
           } 
           else if (val!=='') {//不存在汇总报告，存在小队报告
               var m=val.split(',');
               var len=m.length;
               
               for(var i=0;i<len;i++)
               {
                 result=result+'<li><a href="downloadPic.aspx?picName='+m[i]+'&package=materialsubmit">下载'+i+'</a></li> ';
                }            
                 
           }              
           return result+'</ul>';          
         r }
        }
    </script>
  
</head>
<body>
     <table id="dg">
        <thead>
            <tr>
				<th field="NAME"   width="50" sortable="true" data-options="align:'center',styler:cellStyler,formatter:go7">主题</th>
				<th field="WORD"   width="50" data-options="align:'center',styler:cellStyler,formatter:go5">调查大纲</th>
				<th field="EXCEL"   width="50"data-options="align:'center',styler:cellStyler,formatter:go6">调查模板</th>
				<th field="INITDATE"  width="50" >发起时间</th>
				<th field="LEADER"   width="0" hidden="true">主管所长</th>				
				<th field="LEADERCHECK"  width="50" data-options="align:'center',styler:cellStyler,formatter:go1">主管所长审核</th>				
				<th field="LEADEROPINION"   width="0" hidden="true">审核意见</th>
				<th field="CHECKTIME"   width="0" hidden="true">审核时间</th>
				<th field="GYKD"   width="0" hidden="true">矿</th>
				<th field="MINERNAME"  width="50" data-options="align:'center',styler:cellStyler,formatter:go8">矿名</th>
				<th field="MINERTEAMCHECK"   width="50" data-options="align:'center',styler:cellStyler,formatter:go3">矿工艺队审核</th>
				<th field="RECEIVETIME" hidden="true"  width="50" >接收时间</th>
				<th field="MINERCHECK"  width="50" data-options="align:'center',styler:cellStyler,formatter:go4">地面矿长审核</th>
				<th field="STATE"  width="50" sortable="true" data-options="align:'center',styler:cellStyler,formatter:go2">是否结束</th>
				<th field="WEXCEL" hidden="true"  width="50" >汇总报告</th>
				<th field="REQUIREMENTS" hidden="true"  width="50" >需求大纲</th>
				<th field="EXCELNAME"  width="50" data-options="align:'left',styler:cellStyler,formatter:go9">小队报告</th>
				
			</tr>
        </thead>
    </table>
  
</body>
</html>

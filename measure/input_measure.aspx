<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_measure.aspx.cs" Inherits="input_measure" %>

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
    <style type="text/css">
        .easyui-validatebox
        {
            margin-bottom: 0px;
            width: 155px;
            height: 19px;
            margin-top: 0px;
        }
        .easyui-datebox
        {
            width: 155px;
            height: 19px;
        }
        .style3
        {
            height: 44px;
        }
        .easyui-numberbox
        {
            margin-bottom: 0px;
            width: 155px;
            height :19px;
            margin-top:0px;
        }
        .style9
        {
            width: 83px;
            height: 44px;
        }
        .style10
        {
            width: 100px;
            height: 44px;
        }
        .style14
        {
            height: 44px;
            width: 156px;
        }
        .style21
        {
            width: 83px;
            height: 42px;
        }
        .style22
        {
            height: 42px;
            width: 156px;
        }
        .style23
        {
            height: 42px;
        }
        .style24
        {
            height: 44px;
            width: 181px;
        }
        .style25
        {
            height: 42px;
            }
        .auto-style1 {
            height: 42px;
            width: 163px;
        }
        .auto-style2 {
            width: 83px;
        }
        .auto-style3 {
            height: 42px;
            width: 100px;
        }
        .auto-style4 {
            width: 100px;
        }
        </style>
<script type="text/javascript">
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
      </script>
</head>
<body>
    <form id="form1" method= "post"  runat="server">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>    
     <input type="hidden" value=""  id="userLevel"  runat="server"/> 
	<table class="dv-table" 
        style="width:100%;background:#fafafa;padding:5px;margin-top:5px; height: 142px;">	
        <tr>
            <td class="style9">矿名</td>
			<td class="style25" colspan="3"><input name="KM"  style="width:99%;background-color:gray;"class="easyui-validatebox" readonly="readonly" /></td>     
            <td class="style10">队名</td>
			<td class="style25"><input name="DM"style="background-color:gray" class="easyui-validatebox" readonly="readonly"/></td>  
            <td class="style10">岗位</td>
			<td class="style25"colspan="3"><input name="GW"style="width:99%"class="easyui-validatebox" /></td>
        </tr>
        <tr> 
            
			<td class="style9">站别</td>
			<td class="style25" colspan="3"><input name="ZB" class="easyui-validatebox"style="width:99%"  size="20"/></td>        
            <td class="style10">站名</td>
			<td class="style25"><input name="ZM" class="easyui-validatebox" /></td>    
           <td class="style10">系统编码</td>
			<td class="style25"colspan="3"><input name="XTBM"style="width:99%"class="easyui-validatebox" /></td>
            </tr>
		<tr>
			<td class="style9">软件开发厂家</td>
			<td class="style25" colspan="3"><input name="RJKFCJ" class="easyui-validatebox"style="width:99%"  required="true" size="20"/></td>        
            <td class="style10">投用时间</td>
			<td class="style25"><input name="TYSJ" class="easyui-datebox" data-options ="formatter:myformatter,parser:myparser"/></td>    
           <td class="style10">上位软件平台名称</td>
			<td class="style25"colspan="3"><input name="SWRJPTMC"style="width:100%"class="easyui-validatebox" /></td>
            </tr>
            <tr>
         	   <td class="style23">下位机模块厂家名称</td>
            <td class="style25"><input name="XWJMKCJMC"style="width:100%"class="easyui-validatebox"></td>  
            <td class="style9">上位机配置</td>
            <td class ="auto-style1"><input name ="SWJPZ"class="easyui-validatebox"></td>
			<td class="style10">系统类型</td>
			<td class="style25"><input name="XTLX"style="width:100%"class="easyui-validatebox" /></td>                
            <td class="style9">系统模块CPU型号</td>
			<td class="style25"><input name="CPUXH" class="easyui-validatebox"/></td>    
           <td class="style10">系统模块CPU数量</td>
			<td class="style25"><input name="CPUSL"class="easyui-numberbox" /></td>
        </tr>  
        <tr>
            <td class="style23">系统模块AI模块型号</td>
            <td class="style25" "width:150px"><input name="AIXH"class="easyui-validatebox"></td>  
        	<td class="style10">系统模块AI模块数量</td>
            <td class ="style25"><input name ="AISL"class="easyui-numberbox"></td>
			<td class="style10">系统模块AO模块型号</td>
			<td class="auto-style1"><input name="AOXH" class="easyui-validatebox" /></td>  
            <td class="style9">系统模块AO模块数量</td>
			<td class="style25"><input name="AOSL" class="easyui-numberbox" /></td>    
            <td class="style10">系统模块DI模块型号</td>
			<td class="style25"><input name="DIXH"class="easyui-validatebox" /></td>
        </tr>
        <tr>      
            <td class="style10">系统模块DI模块数量</td>
			<td class="style25"><input name="DISL"class="easyui-numberbox" /></td>
            <td class="style10">系统模块DO模块型号</td>
			<td class="style25"><input name="DOXH"class="easyui-validatebox" /></td>
            <td class="auto-style3">系统模块DO模块数量</td>
            <td class="style25" "width:150px"><input name="DOSL"class="easyui-numberbox"></td>  
            	<td class="style10">系统模块电源型号</td>
                <td class ="style25"><input name ="DYXH"class="easyui-validatebox"></td>
            <td class="style10">系统模块电源数量</td>
			<td class="auto-style1"><input name="DYSL" class="easyui-numberbox"/></td> 
                  </tr><tr>   
             <td class="style10">系统模块其他模块型号</td>
			<td class="style25"><input name="QTMKXH"class="easyui-validatebox" /></td>
            <td class="style23">系统模块其他模块数量</td>
            <td class="style25" "width:150px"><input name="QTMKSL"class="easyui-numberbox"></td>  
        	<td class="style10">辅助模块安全栅型号</td>
            <td class ="style25"><input name ="AQSXH"class="easyui-validatebox"></td>
           	<td class="style3">辅助模块安全栅数量</td>
			<td class="style25"><input name="AQSSL" class="easyui-numberbox"/></td>        
			<td class="style10">辅助模块配电器型号</td>                                     
			<td class="auto-style1"><input name="PDQXH" class="easyui-validatebox"/></td>        
            </tr><tr>
               <td class="style9">辅助模块配电器数量</td>
			<td class="style25"><input name="PDQSL" class="easyui-numberbox"/></td>    
           <td class="style10">辅助模块继电器型号</td>
			<td class="style25"><input name="JDQXH"class="easyui-validatebox" /></td>
            <td class="auto-style3">辅助模块继电器数量</td>
            <td class="style25" "width:150px"><input name="JDQSL"class="easyui-numberbox"></td>
                  <td class="style3">辅助模块其他型号</td>
                <td class ="style25"><input name ="QTXH"class="easyui-validatebox"></td>
			<td class="style10">辅助模块其他数量</td>                                           
			<td class="auto-style1"><input name="QTSL" class="easyui-numberbox" /></td>   
                </tr><tr>   
            <td class="style9">系统状况</td>
			<td class="style25"colspan="3"><input name="XTZK" style="width:100%"class="easyui-numberbox"/></td>    
            <td class="auto-style4"></td>
            <td></td>
           <td class="style10">上位机源程序存储路径</td>
			<td class="style25"colspan="3"><input name="SWJYCXCCLJ"style="width:100%"class="easyui-validatebox" /></td>
                      </tr><tr>
            <td class="auto-style3">下位机源程序存储路径</td>
            <td class="style25"  colspan="3"><input name="XWJYCXCCLJ"style="width:100%"class="easyui-validatebox"></td>  
                          </td><td></td><td>
        	<td class="style10">通讯方式</td>
                <td class ="style25"colspan="3"><input name ="TXFS"style="width:100%" class="easyui-numberbox"></td>
        	</td>
            </tr>
                 <tr>
		<td class="auto-style2"> &nbsp;&nbsp; 备注：</td><td colspan=5> 
             <textarea name="BZ" 
        style=" width:100%; height:112px; margin-top: 6px; margin-right: 0px;" 
                 rows="1"></textarea></td>
		</tr>
           </table>
		<div style="padding:5px 0;text-align:right;padding-right:30px">
            <a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>&nbsp;&nbsp;&nbsp;
            <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
	</div>
  
 <script type="text/javascript">
     $(function () {       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑
         var userlevel = $('#userLevel').val();
         //if (userlevel != null || userlevel != "") {
         //    $("form :input[name='KM']").attr("readonly", "readonly");
         //    $("form :input[name='DM']").attr("readonly", "readonly");
         //}
         if (userlevel == "6" || userlevel == "2") {
             $("form :input").attr("readonly", "readonly"); //设置控件为只读
             $("form :input[type='file']").hide(); //隐藏上传文件窗口
             $("form a").hide(); //隐藏保存和撤销按钮    
         }
     });
     </script>
    <div>  
    </div>
    </form>
 </body>
</html>

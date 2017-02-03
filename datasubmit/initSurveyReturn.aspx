<%@ Page Language="C#" AutoEventWireup="true" CodeFile="initSurveyReturn.aspx.cs" Inherits="datasubmit_initSurveyReturn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script> 
</head>
<body>
<div class="easyui-panel" title="室主任修改调查" style="width:500px">        
<div style="padding:10px 60px 20px 60px">       
<form id="ff" method="post" enctype="multipart/form-data" 
    style="text-align: center">    
<input type="hidden" id="hd_id" name="HD_ID" runat="server"/>      
<table cellpadding="7">                
<tr>                    
<td style="width:25%">主题:</td>                    
<td style="width:80%"><input class="easyui-textbox" type="text" id="NAME" name = "NAME" runat="server" data-options="required:true" style="width:100%"/></td>                
</tr>  
<tr>                    
<td><div id="RT" runat="server">调查要求:</div></td>                    
<td><textarea class="easyui-textbox" data-options="multiline:true" id="REQUIREMENTS" readonly="readonly" runat="server" style="width:100%; height:60px"/></td>
</tr>               
<tr>                    
<td>调查大纲（Word）:</td>                    
<td>
<div id="DG" runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer" onclick="downloadWord()">下载</div>
</td>
<td style="width:30px">
<input  type="hidden" id="WORDNAME"  readonly="readonly" style="width:100%"  runat="server"/>
</td>          
</tr> 

<tr>                    
<td>调查模板（Excel）:</td>                    
<td>
<div style="text-align:center;border-bottom:1px solid #000;cursor:pointer" onclick="downloadExcel()">下载</div>
</td>
<td style="width:30px">
<input type="hidden" id="EXCELNAME"  readonly="readonly" style="width:100%"  runat="server"/>
</td>          
</tr>                
<tr>                    
<td>主管所长:</td>                    
<td>
<input name="LEADER" id = "LEADER" runat = "server"  class="easyui-combobox" style="width:100%" data-options=" valueField: 'text', textField: 'text',url: '../tools/getUserZGSZ.ashx'"/>
</td>                
</tr>                
<tr>                    
<td>矿工艺队:</td>                   
<td>
<input type="checkbox" id="GYKD1" name="GYKD" value="第一油矿" runat="server"/><label for="1">1矿</label>
<input type="checkbox" id="GYKD2" name="GYKD" value="第二油矿" runat="server"/><label for="2">2矿</label>
<input type="checkbox" id="GYKD3" name="GYKD" value="第三油矿" runat="server"/><label for="3">3矿</label>
<input type="checkbox" id="GYKD4" name="GYKD" value="第四油矿" runat="server"/><label for="4">4矿</label>
<input type="checkbox" id="GYKD5" name="GYKD" value="第五油矿" runat="server"/><label for="5">5矿</label>
<input type="checkbox" id="sy" name="GYKD" value="试验大队" runat="server"/><label for="sy">试验</label>  
</td>                      
</tr>  
<tr>                    
<td>审核意见:</td>                   
<td> 
    <textarea class="easyui-textbox" data-options="multiline:true" type="text" id="SHYJ" name = "SHYJ" runat ="server"
         style="width:100%; height:60px" readonly="readonly"/></td>               
</tr> 
   
</table>        
</form>        
<%--<div style="text-align:center;padding:5px">            
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
</div>     --%>   
</div>   
</div> 
<script type="text/javascript">
    function downloadWord() {
        var wordname = document.getElementById("WORDNAME").value;
        var url = "downloadPic.aspx?picName=" + wordname + "&package=materialsubmit";
        self.location.href = url;
        //window.open(url)
    }
    function downloadExcel() {
        var excelname = document.getElementById("EXCELNAME").value;
        var url = "downloadPic.aspx?picName=" + excelname + "&package=materialsubmit";
        self.location.href = url;
        //window.open(url)
    }
</script>    
</body>
</html> 



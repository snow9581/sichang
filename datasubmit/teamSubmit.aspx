<%@ Page Language="C#" AutoEventWireup="true" CodeFile="teamSubmit.aspx.cs" Inherits="datasubmit_teamSubmit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--小队资料提交表单-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
     <script type="text/javascript">


           function downloadWord() {
               var wordname = document.getElementById("WORDNAME1").value;
               var url = "downloadPic.aspx?picName=" + wordname+"&package=materialsubmit";
               location.href = url;
               //window.open(url);
           }
           function downloadExcel() {
               var excelname = document.getElementById("EXCELNAME1").value;
               var url = "downloadPic.aspx?picName=" + excelname+"&package=materialsubmit";
               location.href = url;
               //window.open(url);
           }

     
    </script>  
</head>
<body>
<div class="easyui-panel" title="小队提交资料" style="width:500px">        
<div style="padding:10px 60px 20px 60px">       
<form id="ff" action="teamSubmit.ashx" method="post" enctype="multipart/form-data">
<input type="hidden" id="hd_id" name="HD_ID" runat="server"/>      
<table cellpadding="7">                
<tr>                    
<td style="width:25%">主题:</td>                    
<td  style="width:80%"><input id="NAME"  style="width:100%" readonly="readonly"  runat="server" class="easyui-textbox"/></td>                
<td  style="width:80%"></td>                
</tr>  
   
<tr>                    
<td><div id="RT" runat="server">调查要求</div></td>                    
<td><textarea class="easyui-textbox" data-options="multiline:'true'" id="REQUIREMENTS" readonly="readonly" rows="5" runat="server" style="width: 100% ; height :60px"></textarea>
</tr>  
           
<tr>                    
<td style="width:25%">调查大纲（Word）:</td>                    
<td  style="width:80%">
<div id="DG" runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer" onclick="downloadWord()">下载</div></td>                
<td  style="width:80%">
<input type="hidden" id="WORDNAME1"  readonly="readonly" style="width:100%"  runat="server" 
        class="textbox"/>
</td>                
</tr>                
<tr>                    
<td style="width:25%">调查模板（Excel）:</td>                    
<td  style="width:80%">
<div style="text-align:center;border-bottom:1px solid #000;cursor:pointer" onclick="downloadExcel()">下载</div></td>                
<td  style="width:80%">
<input  type="hidden" id="EXCELNAME1"  readonly="readonly" style="width:100%"  runat="server" 
        class="textbox"/>
</td>                
</tr>                
                   
  
<tr>                    
<td>调查报告:</td>                   
<td><input class="easyui-validatebox" data-options="required:true" type="file" name="EXCELNAME"   style="width:100%"/></td>                
<td>&nbsp;</td>                
</tr>                
   
<tr>                    
<td><label id="labelSHYJ" runat ="server" value = "asdf"></label></td>                   
<td>&nbsp;</td>                
<td>&nbsp;</td>                
</tr>                
   
</table>        
</form>        
<div style="text-align:center;padding:5px">            
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
</div>        
</div>   
</div>    
<script type="text/javascript">

    //    var qx = $("input[name='qx']:checked").map(function() {
    //        return $(this).val();
    //    }).get().join('#');          

    function submitForm() {
        
        $('#ff').form('submit',{
          success: function(data)
          {            
             if(data.toString()=='1')
                {
                    alert('资料提交成功');
                    self.location='viewHistorySurvey_XD.aspx';
                 }
                else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../login.aspx';
                } else 
                {
                     alert('资料提交失败');
                }             
          }
        });
    }
    function clearForm() {
        $('#ff').form('clear');
    }    
</script>
</body>
</html> 


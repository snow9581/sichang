<%@ Page Language="C#" AutoEventWireup="true" CodeFile="minerSurvey.aspx.cs" Inherits="datasubmit_minerSurvey" %>
<!--矿工艺队分发调查表-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
               var wordname = document.getElementById("WORDNAME").value;
               var url ="downloadPic.aspx?picName=" + wordname+"&package=materialsubmit";
               location.href = url;
               //window.open(url);
           }
           function downloadExcel() {
               var excelname = document.getElementById("EXCELNAME").value;
               var url = "downloadPic.aspx?picName=" + excelname+"&package=materialsubmit";
               location.href = url;
               //window.open(url);
           }

     
    </script>  
      
</head>
<body style=" margin:0px 0px 0px 0px">
<form id="ff"  action="minerSurvey.ashx" method="post">   

<div class="easyui-panel" title="矿工艺队分发调查表" style="width:500px">    
<div style="padding:10px 60px 20px 60px">       
<input type="hidden" id="hd_id" name="HD_ID" runat="server"/> 
<table cellpadding="7">                
<tr>                    
<td style="width:25%">主题:</td>                    
<td ><input class="easyui-textbox" type="text" id="NAME"  style="width:100%" runat="server"/></td>                
</tr>   

<tr>                    
<td><div id="RT" runat="server">调查要求</div></td>                    
<td><textarea rows="5" cols="100" class="easyui-textbox" data-options="multiline:'true'" id="REQUIREMENTS" readonly="readonly" runat="server" style="width: 100%; height :60px"/></td>
</tr>  

<tr>                    
<td>调查大纲（Word）:</td>                    
<td>
<div  id="DG"  runat="server" style="text-align:center;border-bottom:1px solid #000;cursor:pointer"  onclick="downloadWord()"><a>下载</a></div>
</td>
<td style="width:30px">
<input  id="WORDNAME"  readonly="readonly" type="hidden" style="width:100%"  runat="server"/>
</td>          
</tr> 

<tr>                    
<td>调查模板（Excel）:</td>                    
<td>
<div style="text-align:center;border-bottom:1px solid #000;cursor:pointer" onclick="downloadExcel()">下载</div>
</td>
<td style="width:30px">
<input  id="EXCELNAME" type="hidden" readonly="readonly" style="width:100%"  runat="server"/>
</td>          
</tr>  
              
<tr>                    
<td>小队：</td>                   
<td>
<input class="easyui-combobox" required="true"
            data-options=" 
            url:'minerSurvey.ashx?type=1',
            method:'post',
            valueField:'text',
            textField:'text',
            multiple:true,
            multiline:false,
            panelHeight:'auto'
            " id="TEAM" 
        style="width:100%; height:50px;word-wrap:break-word;overflow:auto; "/>
    <br />
</td>                
</tr>                

   
</table>        
       
<div style="text-align:center;padding:5px">            
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>   

</div> 
       
</div>   
  
</div> 

<script type="text/javascript">
    function submitForm() {
        $('#ff').form('submit',{
          success: function(data)
          {            
             if(data.toString()=='1')
                {
                    alert('资料提交成功');
                    self.location='viewHistorySurvey_KGYD.aspx';
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
</form> 
</body>
</html> 
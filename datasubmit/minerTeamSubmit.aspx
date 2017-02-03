<%@ Page Language="C#" AutoEventWireup="true" CodeFile="minerTeamSubmit.aspx.cs" Inherits="datasubmit_minerTeamSubmit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--将检查通过的报告提交给地面矿长，可以直接提交，也可以汇总提交-->
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
<div class="easyui-panel" title="工艺队提交调查" style="width:500px">        
<div style="padding:10px 60px 20px 60px">       
<form id="ff" action="minerTeamSubmit.ashx" method="post"  runat="server" enctype="multipart/form-data"> 
<input type="hidden" id="hd_id" name="HD_ID" runat="server"/>     
<table cellpadding="7">  
<tr>                    
<td style="width:25%">主题:</td>                    
<td style="width:80%"><input class="easyui-textbox" type="text" id="NAME" name = "NAME" runat="server" readonly="readonly" style="width:100%"/></td>              
</tr>              
<tr>                    
<td style="width:25%">提交方式:</td>                    
<td  style="width:80%"> 
<input type="radio" name="TJFS" value="1" onclick="check()" checked="checked" />直接提交&nbsp;
<input type="radio" name="TJFS" value="2" id="hz" onclick="check()"/>汇总提交</td>                
</tr>                
<!--<tr>                    
<td>调查表Word:</td>                    
<td><input class="easyui-validatebox" type="file" name="WORDNAME"   style="width:100%"></td>                </tr>           -->     
<tr  id="hz_excel" style="visibility:hidden" >                    
<td>调查表Excel:</td>                   
<td><input class="easyui-validatebox" type="file" name="EXCELNAME"   style="width:100%"/></td>                
</tr>                
<tr>                    
<td>&nbsp;</td>                   
<td> 
    &nbsp;</td>               
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
    
    function check(){                                      //刘靖 判断是"直接提交"还是"汇总提交"  2014.11.9
       if(document.getElementById("hz").checked)
           document.getElementById("hz_excel").style.visibility="visible";
       else
           document.getElementById("hz_excel").style.visibility="hidden";
    }
    
    function submitForm() {
        $('#ff').form('submit',{
          success: function(data)
          {
             if(data.toString()=='1')
                {
                    alert('审核提交成功');
                    self.location='viewHistorySurvey_KGYD.aspx';
                } else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../login.aspx';
                }
                else 
                {
                    alert('审核提交失败');
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


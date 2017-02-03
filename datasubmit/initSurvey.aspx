<%@ Page Language="C#" AutoEventWireup="true" CodeFile="initSurvey.aspx.cs" Inherits="datasubmit_initSurvey" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min1.4.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
   
</head>
<body>

<div class="easyui-panel" title="室主任发起调查" style="width:500px">        
<div style="padding:10px 60px 20px 60px">       
<form id="ff" action="initSurvey.ashx" method="post" enctype="multipart/form-data" 
    style="text-align: center">     
<table cellpadding="7">                
<tr>                    
<td style="width:25%">主题:</td>                    
<td  style="width:80%"><input class="easyui-textbox" type="text" name="NAME" data-options="required:true" style="width:100%"/></td>                
</tr>
<tr>
<td>调查要求:</td>
<td><input name="REQUIREMENTS" class="easyui-textbox" data-options="multiline:true" style="width:300px;height:100px"/></td>
</tr>                
<tr>                    
<td>调查大纲（Word）:</td>                    
<td><input class="easyui-validatebox" type="file" id="WORDNAME" name = "WORDNAME" runat ="server"  style="width:100%"  /></td>                </tr>                
<tr>                    
<td>调查模板（Excel）:</td>                   
<td><input required="true" class="easyui-validatebox" type="file" id="EXCELNAME" name = "EXCELNAME" runat ="server"    style="width:100%"/></td>                
</tr>                
<tr>                    
<td>主管所长:</td>                    
<td>
<%--<input class="easyui-textbox" name="LEADER" data-options=""  style="width:100%"/>
--%><input required="true" name="LEADER"  class="easyui-combobox" data-options=" valueField: 'text', textField: 'text',url: '../tools/getUserZGSZ.ashx'"/>
</td>                
</tr>                
<tr>                    
<td>矿工艺队:</td>  
<td>
<input type="checkbox" id="1" name="GYKD" value="第一油矿" /><label for="1">1矿</label>
<input type="checkbox" id="2" name="GYKD" value="第二油矿" /><label for="2">2矿</label>
<input type="checkbox" id="3" name="GYKD" value="第三油矿" /><label for="3">3矿</label>
<input type="checkbox" id="4" name="GYKD" value="第四油矿" /><label for="4">4矿</label>
<input type="checkbox" id="5" name="GYKD" value="第五油矿" /><label for="5">5矿</label>
<input type="checkbox" id="sy" name="GYKD" value="试验大队" /><label for="sy">试验</label>  
</td>         
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
    
    function submitForm() {
       var i=0;                                             //刘靖 2014.11.7 判断矿工艺队的checkbox是否被选中
       $("input:checkbox").each(function(){
       if($(this).prop("checked"))i++;
       });
       if (!i) {
           $.messager.alert('提示框', '请至少选择一个矿工艺队！');
       }
       else
           $('#ff').form('submit', {
               success: function (data) {
                   //alert(data.toString());
                   if (data.toString() == '1') {
                       alert('资料提交成功');
                       self.location = 'viewProgress.aspx';
                   }
                   else if (data.toString() == "")//高俊涛增加于 2014-10-09 判断提交失败的原因是否是账号过期,提示用户重新登陆。
                   {
                       alert('登陆账号已过期，请重新登录！');
                       window.top.location.href = '../login.aspx';
                   } else {
                       $.messager.alert('提示框', '资料提交失败');
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


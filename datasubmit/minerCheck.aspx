<%@ Page Language="C#" AutoEventWireup="true" CodeFile="minerCheck.aspx.cs" Inherits="datasubmit_minerCheck" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--地面矿长审核-->
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
               var url = "downloadFile.aspx?picName=" + wordname;
               location.href = url;
               //window.open(url);
           }
           function downloadExcel() {
               var excelname = document.getElementById("EXCELNAME").value;
               var url = "downloadPic.aspx?picName=" + excelname+"&package=materialsubmit";
               //location.href = url;
               window.open(url);
           }

     
    </script>  
      
    <style type="text/css">
        .style1
        {
            height: 152px;
        }
    </style>
      
</head>
<body style=" margin:0px 0px 0px 0px">
<form id="ff"  action="minerCheck.ashx" method="post">   

<div class="easyui-panel" title="地面矿长审核" style="width:500px">    
<div style="padding:10px 60px 20px 60px">       
<input type="hidden" id="hd_id" name="HD_ID" runat="server"/> 

<table cellpadding="7">                
<tr>                    
<td style="width:25%">主题:</td>                    
<td style="width:80%"><input class="easyui-textbox" type="text" id="NAME" name = "NAME" runat="server" readonly="readonly" style="width:100%"/></td>              
</tr>   
<tr>                    
<td colspan="2" class="style1">
    <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>
        <table id="tt" class="easyui-datagrid" style="width:320px;height:auto;">
        <thead>
        <tr>
        <th  field="name1" align="center" width="20%">小队</th>
        <th  field="name2" align="center" width="80%">查看报告</th>
        </tr>
        </thead>
        <tbody>
        </HeaderTemplate>        
        <ItemTemplate>
        <tr>
        <td><%# DataBinder.Eval(Container.DataItem, "TEAMNAME") %></td>      
        <td><a href="downloadPic.aspx?picName=<%# DataBinder.Eval(Container.DataItem, "EXCELNAME") %>&package=materialsubmit">下载</a></td>
        </tr>        
        </ItemTemplate>        
        <FooterTemplate>
        </tbody>
        </table>
        </FooterTemplate>
    
    </asp:Repeater>
</td>                    
</tr>             
<tr>                    
<td>是否同意：</td>                   
<td><label><input name="LEADERCHECK" type="radio" value="0" />拒绝（请在以下说明原因） </label> 
<label><input name="LEADERCHECK" type="radio"  value="1" />同意 </label> 
</td>                
</tr>                
<tr>                    
<td>审批意见:</td>                    
<td>
<input name="LEADEROPINION"  class="easyui-textbox" data-options="multiline:true" style="width:100%;height:100px"/>
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
        $('#ff').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
                    alert('审核提交成功');
                    self.location = 'viewHistorySurvey_DMKZ.aspx';
                }
                else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../login.aspx';
                } else {
                    alert('审核提交失败');
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

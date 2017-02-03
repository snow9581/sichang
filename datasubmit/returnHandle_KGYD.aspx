<%@ Page Language="C#" AutoEventWireup="true" CodeFile="returnHandle_KGYD.aspx.cs" Inherits="returnHandle_KGYD" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
</head>
<body>
 <div class="easyui-panel" title="退回报告处理" style="width:450px">
    <form id="ff" runat="server" action="returnHandle_KGYD.ashx" method="post">
    <input type="hidden" id="hd_id" name="HD_ID" runat="server"/> 
    <table cellpadding="5">
    <tr><td>地面矿长意见：</td>
    <td><asp:TextBox ID="T_OPINION" runat="server" Height="102px" ReadOnly="True" 
        TextMode="MultiLine" Width="299px"></asp:TextBox>
    </td>
    </tr>
    
    <asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
      <tr>
        <td><input type="checkbox" name="XD" value="<%# DataBinder.Eval(Container.DataItem, "rid")%>" /></td>
        <td><a href="downloadPic.aspx?picName=<%# DataBinder.Eval(Container.DataItem, "excelname")%>&package=materialsubmit"><%# DataBinder.Eval(Container.DataItem, "teamname")%>报告</a></td>
        <td><input name="<%# DataBinder.Eval(Container.DataItem, "rid")%>" class="easyui-textbox" data-options="multiline:true" value="请填写意见..." style="width:300px;height:100px"></td>
      </tr>    
      </ItemTemplate>
    </asp:Repeater>
    
    </table>
    </form>
<div style="text-align:center;padding:5px">            
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
</div>   
</div>

</body>
<script type="text/javascript">
    function submitForm() {
        $('#ff').form('submit',{
          success: function(data)
          {            
             if(data.toString()=='1')
                {
                    alert('修改意见提交成功');
                    self.location='viewHistorySurvey_KGYD.aspx';
                 }
                else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../login.aspx';
                } else 
                {
                     alert('修改意见提交失败');
                }             
          }
        });
       
    }
    function clearForm() {
        $('#ff').form('clear');
    }        
</script>
</html>

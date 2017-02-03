<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_project.aspx.cs" Inherits="crud_form_input_project" %>

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
</head>
<body>
  <style type="text/css">
        .auto-style1 {
            width: 127px;
        }
        
        .auto-style2 {
            height: 28px;
        }
        
        .auto-style3 {
            width: 189px;
        }
        
      .easyui-validatebox {
          width: 248px;
      }
        
    </style>
<form method= "post"  runat="server" enctype="multipart/form-data">
<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
    <tr>
        <td >项目名称 </td>
        <td >
         <input name="PNAME"  class="easyui-validatebox" style="width:250px;height:20px;" />
        </td>
      </tr><tr>
        <td class="auto-style2">
           项目编号
        </td>
        <td colspan="2" class="auto-style2">
            <input name="PNUMBER"  style=" height:20px; width: 250px" class="easyui-validatebox"/>
        </td>
    </tr>
     <br/>
    <tr>
        <td class="auto-style1">
            项目负责人
        </td>
        <td style="font-weight: 700" class="auto-style3">
           <input  name="SOLUCHIEF" style="width: 164px; height:20px;" class="easyui-validatebox"/>
        </td>
        <td>设计负责人</td>
                <td> <input name="DESICHIEF"  style="width:164px;height:20px;" class="easyui-validatebox"/> </td>
    </tr>
    <tr>
     <td>方案批复文号</td>
        <td class="auto-style3">
            <input  name="PLANNUMBER" style="width: 162px;height:20px;"/>
        </td>
<td>设计批复文号</td>
        <td>
            <input name="DESIAPPROVALARRIVALFILENUMBER" style="width:164px;height:20px;" class="easyui-validatebox"/>
        </td>
            </tr>
        <tr>
        <td>计划文号</td>
        <td class="auto-style3">
            <input name="PLANARRIVALFILENUMBER" style="width: 164px;height:20px;" class="easyui-validatebox"/>
        </td>
        <td>实际投资</td>
        <td>
            <input name="PLANINVESMENT" style="width:164px; height:20px;" class="easyui-validatebox"/>
        </td>
        </tr>
</table>       
    </form>
        </body>
    </html>
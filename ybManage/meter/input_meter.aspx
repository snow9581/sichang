<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_meter.aspx.cs" Inherits="ybManage_meter_input_meter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="../../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../js/datagrid-detailview.js" type="text/javascript"></script>
 <script src="../../js/export.js" type="text/javascript"></script>
    <style type="text/css">
        button 
        {
            width:35px;
            height:21px;
        }
        </style>
    <style type="text/css">
        .easyui-validatebox
        {
            margin-bottom: 0px;
            width: 150px;
            height: 19px;
            margin-top: 0px;
        }
        .easyui-datebox
        {
            width: 150px;
            height: 19px;
        }
        .style3
        {
            height: 44px;
        }
        .easyui-numberbox
        {
            width: 147px;
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
            width: 181px;
        }
        .auto-style1 {
            height: 44px;
            width: 88px;
        }
        .auto-style4 {
            width: 454px;
        }
        .auto-style5 {
            height: 44px;
            width: 454px;
        }
        .auto-style6 {
            height: 44px;
            width: 277px;
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
    <script type="text/javascript">
        $(function BindYBMC() {
           
           
        });
    </script>
</head>
<body>
    <form id="form1" method= "post"  runat="server">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <input type="hidden" value=""  id="userLevel"  runat="server"/> 
    <input type="hidden" id="dm" runat="server"/>
	<table class="dv-table" 
        style="width:100%;background:#fafafa;padding:5px;margin-top:5px; height: 142px;">
		<tr>
			<td class="style3">管理分类</td>
            <td class="style14">
                <select class="easyui-combobox"  name="YBFL" style="width:153px; height: 23px;" required="true">
            <option value="A">A类</option>
            <option value="B">B类</option>
            <option value="C">C类</option>
            <option value="QJ">强检</option>        
            </select></td>
			<td class="style3">仪表名称</td>
			<td class="style24"><input name="YBMC" id="YBMC" class="easyui-combobox" required="true"/></td>        
			<td class="style3">安装地点</td>
			<td class="auto-style6" >
            <input name="AZDD"style="width:391px; height: 23px; margin-left: 0px;"class="easyui-validatebox" /></td>
                            <td colspan="2" rowspan="4">
                    <input type="button" id="M" runat="server" value="m" class="busBtn" onclick="BindUnit('M')"/>
                    <input type="button" id="T" runat="server" value="t" class="busBtn" onclick="BindUnit('T')"/>
                    <input type="button" id="SD" runat="server" value="m/s" class="busBtn" onclick="BindUnit('SD')"/>           
                                                                <br/>
                    <input type="button" id="WD" runat="server" value="℃"  class="busBtn" onclick="BindUnit('WD')"/>
                    <input type="button" id="A" runat="server" value="A"  class="busBtn" onclick="BindUnit('A')"/>
                    <input type="button" id="V" runat="server" value="V"  class="busBtn" onclick="BindUnit('V')"/>
                                                                <br/>
                    <input type="button" id="PA" runat="server" value="Pa"  class="busBtn" onclick="BindUnit('PA')"/>
                    <input type="button" id="KPA" runat="server" value="kPa"  class="busBtn" onclick="BindUnit('KPA')"/>
                    <input type="button" id="KMA" runat="server" value="MPa"  class="busBtn" onclick="BindUnit('KMA')"/>
                   
                                                                <br/>
                    <input type="button" id="LL" runat="server" value="m3/h"  class="busBtn" onclick="BindUnit('LL')"/>
                    <input type="button" id="KG" runat="server" value="kg"  class="busBtn" onclick="BindUnit('KG')"/>
                    <input type="button" id="MD" runat="server" value="kg/m3"  class="busBtn" onclick="BindUnit('MD')"/>              
                                                                <br/>
                    <input type="button" id="DZ" runat="server" value="MΩ"  class="busBtn" onclick="BindUnit('DZ')"/>
                    <input type="button" id="DN" runat="server" value="kwh"  class="busBtn" onclick="BindUnit('DN')"/>
            </td>
			</tr>&nbsp;
				<tr>         
           <td class="style3">出厂编号</td>
           	<td class="style14"><input name="CCBH" class="easyui-validatebox" /></td>
            <td class="style9">出厂日期</td>
			<td class="style24"><input name="CCRQ" class="easyui-datebox" data-options ="formatter:myformatter,parser:myparser"/></td>    
           <td class="style10">生产厂家</td>
			<td class="auto-style6"><input name="SCCJ"style="width:391px; height: 23px; margin-left: 0px;"class="easyui-validatebox" /></td>
        </tr><tr>
            <td class="style23">规格型号</td>
            <td class="style25" "width:150px"><input name="GGXH"class="easyui-validatebox"/></td>  
        	<td class="style3">准确度等级</td>
			<td class="style24"><input name="ZQDDJ" class="easyui-validatebox" /></td>	
            <td class="style10">测量范围</td>
			<td class="auto-style1"><input id="LC" name="LC"style="width:391px; height: 23px; margin-left: 0px;"class="easyui-validatebox"type="text" value="下限~上限" onfocus="myFocus(this)" onblur="myblur(this)" />               
			</td>
                </tr>
            <tr>
          <td class="style10">检定日期</td>
            <td class="style14"><input name="JDRQ" class="easyui-datebox"  data-options="formatter:myformatter,parser:myparser"/>   </td>
            <td class="style3">检定周期</td>
			<td class="style24" ><input name="JDZQ" class="easyui-validatebox" />月</td>
			<td class="style9">检定单位</td>
			<td class="auto-style6"><input name="JDDW"style="width:391px; height: 23px; margin-left: 0px;"class="easyui-validatebox" /></td>   
       </tr><tr>
        <td class="style9">检定结果</td>
        <td class="style14">    
                <input type="radio" name="JDJG" value="合格"id="Radio5"onclick="(this.value);" />合格 &nbsp  
                <input type="radio" name="JDJG"value="不合格" id="Radio6"/onclick="(this.value);"/>不合格</td>
            <td class="style3">管理状态</td>
			<td class="style14">
                <select class="easyui-combobox"  name="GLZT"  
                    style="width:153px; height:23px;">
            <option value="在用">在用</option>
            <option value="封存">封存</option>
            <option value="禁用">禁用</option>
            <option value="停用">停用</option>
            <option value="报废">报废</option>
            </select></td>
            <td class="style9">送检/自检</td>
			<td class="auto-style6">               
                <input type="radio" name="SFWS" value="送检"id="Radio7"onclick="(this.value)" />送检 &nbsp  
                <input type="radio" name="SFWS" value="自检"id="Radio8"onclick="(this.value)" />自检                       
            </td>
			<td class="auto-style5">               
                </td>
         </tr>
         <tr>
		<td> &nbsp;&nbsp; 备注：</td><td colspan=5> 
             <textarea name="BZ" 
        style=" width:100%; height:112px; margin-top: 6px; margin-right: 0px;" 
              cols="20" rows="1"></textarea></td>
		     <td class="auto-style4"> 
                 &nbsp;</td>
		</tr>
           </table>
		<div style="padding:5px 0;text-align:right;padding-right:30px">
            <a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>&nbsp;&nbsp;&nbsp;
            <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
	</div>
  
 <script type="text/javascript">
     $(function () {       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑
         var userlevel = $('#userLevel').val();
         var dm = $('#dm').val();
         if ((userlevel == "6" || userlevel == "2")&&dm!="仪表室") {
             $("form :input").attr("readonly", "readonly"); //设置控件为只读
             $("form :input[type='file']").hide(); //隐藏上传文件窗口
             $("form a").hide(); //隐藏保存和撤销按钮    
         }

         var YBMC = $('#YBMC').combobox({
             valueField: 'text',
             textField: 'text',
             url: '../../tools/getMeterName.ashx',
             editable: true
         });

     });
     function myFocus(obj) {
         //判断文本框中的内容是否是默认内容
         if (obj.value == "下限~上限") {
             obj.value = "";
         }
     }
     function myblur(obj) {
         //当鼠标离开时候改变文本框背景颜色
         if (obj.value == "") {
             obj.value = "下限~上限";
         }
     }
     function BindUnit(unitID)
     {
         $('#LC').val($('#LC').val() + $('#' + unitID).val());
     }
   </script>
    </form>
 </body>
</html>


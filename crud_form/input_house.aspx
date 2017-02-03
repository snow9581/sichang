<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_house.aspx.cs" Inherits="easyui_crud_demo_show_form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>   
</head>
<body>
    <form method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
  	<input name="KM" class="easyui-validatebox"  type="hidden"/>
	<input name="DM" class="easyui-validatebox" type="hidden"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<%--<td>矿名</td>
			<td>
			<input class="easyui-combobox" id="KM" data-options=" valueField: 'text', textField: 'text',url: '../tools/getKM.ashx',onSelect: function(rec){ 
            var url = '../tools/getDM.ashx?km='+escape(rec.text); 
            $('#DB').combobox('reload', url); 
            }" /> 

			</td>
			<td>队别</td>
			<td><input name="DB" id="DB" class="easyui-combobox" data-options=" valueField: 'text', textField: 'text',url: '../tools/getDM.ashx'"/></td>
			--%>
			<%--添加隐藏域  防止修改后值不回传 显示空--%> 

			
			<td>所属站名</td>
			<td><input name="ZM" class="easyui-validatebox" /></td>
			<td>房屋名称</td>
			<td><input name="HNAME" class="easyui-validatebox" /></td>
			<td>房屋功能</td>
			<td><input name="HFUNCTION" class="easyui-validatebox" /></td>
			<td>投产日期</td>
			<td><input name="TCRQ" class="easyui-datebox" /></td>
		</tr>
		<tr>
			
			<td>建筑面积</td>
			<td><input name="HAREA" class="easyui-numberbox" precision="2"/></td>
			<td>房屋结构</td>
			<td>
			<select  name="HSTRUCTURE" class="easyui-combobox" style="">
				 <option value="砖混">砖混</option>        
			     <option value="大板">大板</option>        
			     <option value="彩板">彩板</option>
			     <option value="框架">框架</option>        
			     <option value="其他">其他</option>
			</select>
			</td>
		    <td>防水方式</td>
			<td>
			<select  name="FSFS" class="easyui-combobox" style="">
			     <option value="彩板">彩板</option>
			     <option value="卷材防水">卷材防水</option>        
			     <option value="其他">其他</option>
			</select>
			</td>
			<td>最近维修日期</td>
			<td><input name="WXRQ" class="easyui-datebox" />	</td>
		</tr>
		<tr>
			
			<td>维修内容</td>
			<td><input name="WXNR" class="easyui-validatebox" /></td>
			<td>备注</td>
			<td><input name="BZ" class="easyui-validatebox" /></td>
			<td>图片</td>
			<td><input type="file" id="PICFILE" name="PICFILE" class="easyui-validatebox"/> 
		    <input type="hidden" name="PICTURE" class="easyui-validatebox" />
			</td>
		</tr>
        </table>
        <input type="hidden" value=""  id="userLevel"  runat="server"/>  
	<div style="padding:5px 0;text-align:right;padding-right:30px">	      
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
	</div>
</form>
  <script type="text/javascript">
      $(function () {       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑S
          var userlevel = $('#userLevel').val();
          if (userlevel == "") {
          }
          else if (userlevel == "6" || userlevel == "2") {
              $("form :input").attr("readonly", "readonly"); //设置控件为只读
              $("form :input[type='file']").hide(); //隐藏上传文件窗口
              $("form a").hide(); //隐藏保存和撤销按钮    
          }
      });
//   $('#save').click(function () {
//       saveItem($('#hd_index').val());
//       $('#save').unbind('click');
//   })
   </script>
</body>
</html>

﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_estimate.aspx.cs" Inherits="easyui_crud_demo_show_form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
   
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<td>项目编号</td>
			<td><input name="PID" class="easyui-validatebox" required="true"/></td>
			<td>项目名称</td>
			<td><input name="PNAME" class="easyui-validatebox" required="true"/></td>			
			<td>项目负责人</td>
			<td><input name="PLEADER" class="easyui-validatebox" /></td>
			<td>项目投资金额</td>
			<td><input name="PMONEY" class="easyui-numberbox" precision="2"/></td>
		</tr>
		
		<tr>	
			<td>概算专业</td>
			<td width="20">
			<select  name="ESTIMATESPECIAL" class="easyui-combobox" style="">
				 <option value="采暖">采暖</option>        
			     <option value="给排水">给排水</option>        
			     <option value="道路">道路</option>
			     <option value="集输">集输</option>        
			     <option value="注水">注水</option>        
			     <option value="污水">污水</option>        
			     <option value="防腐">防腐</option>
			     <option value="自控">自控</option>   
			     <option value="通信">通信</option>
			     <option value="电气">电气</option>
			     <option value="土建">土建</option>
			     <option value="其他">其他</option>
			</select>
			</td>		
		    <td>概算类型</td>
			<td width="20">
			<select  name="ESTIMATETYPE" class="easyui-combobox" style="">
				 <option value="老区改造">老区改造</option>        
			     <option value="产能">产能</option>        
			     <option value="生产维修">生产维修</option>
			     <option value="房屋维修">房屋维修</option>        
			     <option value="厂内维修">厂内维修</option>        
			     <option value="安全隐患">安全隐患</option>        
			     <option value="工业配套">工业配套</option>
			     <option value="节余资金">节余资金</option>   
			     <option value="节能工程">节能工程</option>
			     <option value="环境隐患">环境隐患</option>  
			     <option value="其他">其他</option>
			</select>
			</td>
			<td>审核人</td>
			<td><input name="REVIEWER" class="easyui-validatebox" /></td>
			<td>备注</td>
			<td><input name="BZ" class="easyui-validatebox" /></td>			
		</tr>
		<tr>
			<td>概算文档</td>
			<td><input type="file" name="FILES" class="easyui-validatebox" /></td>			
		    <input type="hidden" name="ARCHIVES" class="easyui-validatebox" />
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
     $(function(){       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑
        var userlevel = $('#userLevel').val();
         if (userlevel == "6") {
           $("form :input").attr("readonly","readonly");//设置控件为只读
           $("form :input[type='file']").hide();//隐藏上传文件窗口
           $("form a").hide(); //隐藏保存和撤销按钮    
       }
     }); 
    
   </script>
</body>
</html>

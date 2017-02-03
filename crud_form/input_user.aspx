<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_user.aspx.cs" Inherits="easyui_crud_demo_show_user" %>

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
			<td>用户名</td>
			<td><input name="USERNAME" class="easyui-validatebox" required="true"/></td>
			<%--<td>密码</td>
			<td><input name="PASSWORD" class="easyui-validatebox" /></td>--%>
		    <td>用户职务</td>
		     <td><select  name="USERLEVEL" class="easyui-combobox" style="width:155px;">
				 <option value="1">小队</option>        
			     <option value="3">矿工艺队</option>        		        
			     <option value="5">地面矿长</option>
                 <option value="6">室员工</option>     	     
			     <option value="7">副主任</option>        
			     <option value="2">室主任</option>        
			     <option value="4">所长</option>
			     <option value="0">系统管理员</option>
                 <option value="8">图纸管理员</option> 
                 <option value="9">矿计量员</option>       
            </select></td>
            <td>专业</td>
			<td><%--<input name="MAJOR" class="easyui-validatebox"/>--%>
            <select  name="MAJOR" class="easyui-combobox" style="">
				 <option value=""></option>
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
                 <option value="干式水表">干式水表</option>
                 <option value="水流量仪表">水流量仪表</option>
                 <option value="自动化仪表">自动化仪表</option>
                 <option value="测控维护">测控维护</option>
                 <option value="气表">气表</option>
			</select>
            </td>
        </tr><tr>
		    <td>所在部门</td>
		    <td><input name="DM" id="DM" class="easyui-combobox" data-options=" valueField: 'text', textField: 'text',url: '../tools/getDM.ashx'"/></td>
			<td>电子签名</td>
			<td><input type="file" id="PICFILE" name="PICFILE" class="easyui-validatebox"/> 
			 <input type="hidden" name="PICTURE" class="easyui-validatebox" />
			</td>
		</tr>
	
        </table>
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
		       
	
	</div>
</form>

</body>

</html>

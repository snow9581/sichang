<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_constructionMain.aspx.cs" Inherits="crud_form_archives_input_constructionMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
    <input type="hidden" value="1"  id="HDflag"  runat="server"/>
	<table id="Table1" class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<td>项目编号</td>
			<td><input id="PID" name="PID" class="easyui-validatebox" required="true" runat="server"/></td>
			<td>项目名称</td>
			<td><input id="PNAME" name="PNAME" class="easyui-validatebox" required="true" runat="server"/></td>
			<td>项目负责人</td>
			<td><input id="PLEADER" name="PLEADER" class="easyui-validatebox" runat="server"/></td>
			<td>主要工程量</td>
			<td><input name="MAINWORK" class="easyui-validatebox" /></td>	
		</tr>
		
		<tr>					
		    <td>关键字</td>
			<td><input name="KWORDS" class="easyui-validatebox" /></td>
			<td>设计专业</td>
			<td width="20">
			<input id="DESIGNSPECIAL" name="DESIGNSPECIAL" class="easyui-combobox" />
			</td>
            <td>专业负责人</td>
			<td><input id="SPECIALPERSON" name="SPECIALPERSON" class="easyui-combobox"/></td>
			<td>档案号</td>
			<td><input name="FILENUMBER" class="easyui-validatebox" /></td>			
			
		</tr>
		<tr>
            <td>审核人</td>
			<td><input name="REVIEWER" class="easyui-validatebox" />	</td>			
			<td>备注</td>
			<td><textarea rows="3"   cols="30"name="BZ" class="easyui-validatebox" /></td>	
			<td>施工图文档</td>
			<td><input type="file" name="FILES" class="easyui-validatebox" /></td>				
			<td>蓝图下发时间</td>
			<td><input name="ARRIVALDATE" class="easyui-datebox" /></td>
		</tr>
        </table>
        <input type="hidden" value=""  id="userLevel"  runat="server"/> 
	<div style="padding:5px 0;text-align:right;padding-right:30px">
		<a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="cancelItem($('#hd_index').val())">取消</a>
		       
	
	</div>
</form>
  <script type="text/javascript">
      $(function () {       //高俊涛添加 2014-0-10-26 根据用户级别设置form表单是否可编辑
          var userlevel = $('#userLevel').val();
          if (userlevel == "6") {
              $("form :input").attr("readonly", "readonly"); //设置控件为只读
              $("form :input[type='file']").hide(); //隐藏上传文件窗口
              $("form a").hide(); //隐藏保存和撤销按钮    
          }

          //专业、专业负责人二级联动
          var designSpecial = $('#DESIGNSPECIAL').combobox({
              valueField: 'label',
              textField: 'value',
              data: [{ label: '采暖', value: '采暖' }, { label: '给排水', value: '给排水' }, { label: '道路', value: '道路' },
                { label: '集输', value: '集输' }, { label: '注水', value: '注水' }, { label: '污水', value: '污水' },
                { label: '防腐', value: '防腐' }, { label: '自控', value: '自控' }, { label: '通信', value: '通信' },
                { label: '电气', value: '电气' }, { label: '土建', value: '土建' }, { label: '其他', value: '其他'}],
              editable: true,
              onChange: function (newValue, oldValue) {
                  $.get('../../tools/getMajorPerson.ashx', { major: newValue }, function (data) {
                      spcialPerson.combobox("clear").combobox('loadData', data);
                  }, 'json');
              }
          });

          var spcialPerson = $('#SPECIALPERSON').combobox({
              valueField: 'text', //值字段
              textField: 'text', //显示的字段
              editable: true
          });
      });
      if ($('#HDflag').val() != "true") {
          $('.NewRecord').remove();
          $("#Table1").css("width", "750px");
      }
   </script>
</body>
</html>

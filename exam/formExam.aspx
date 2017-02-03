<%@ Page Language="C#" AutoEventWireup="true" CodeFile="formExam.aspx.cs" Inherits="exam_formExam" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
    <script src="../js/ckeditor/ckeditor.js" type="text/javascript"></script>
    <script src="../js/ckfinder/ckfinder.js" type="text/javascript"></script>
</head>
<body>
    <form id="ff" method="post" runat="server">
    <input type="hidden" value=""  id="HDflag"  runat="server"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
            <td>题目</td>
			<td colspan="7">
                <textarea cols="80" id="E_TITLE" name="E_TITLE" rows="8" runat="server"></textarea>
            </td>
        </tr>
        <tr>
        <td>试题类型</td>
			<td><select  name="E_TYPE" id="E_TYPE" class="easyui-combobox" style=" width:100px" listHeight="20" panelHeight="50" runat="server"  data-options="onSelect:function(rec){ answerType(rec.text);}">
				 <option value="选择">选择</option>        
			     <option value="判断">判断</option> 
                 </select>
            </td>
            <td style=" width:100px"></td>
			<td>答案</td>
			<td id="Xanswer"><input name="E_X_ANSWER" id="E_X_ANSWER" class="easyui-validatebox" runat="server" style=" width:130px"/></td>
            <td id="Panswer" style=" display:none;"><select name="E_P_ANSWER" id="E_P_ANSWER" class="easyui-combobox" runat="server" listheight="20" panelheight="50" style=" width:100px">
            	<option value="对">对</option>        
			    <option value="错">错</option> 
            </select></td>
            <td style=" width:100px"></td>
			<td>难度系数</td>
			<td><select  name="E_LEVEL" id="E_LEVEL" class="easyui-combobox" listHeight="20" panelHeight="70" runat="server" style=" width:100px">
				 <option value="难">难</option>        
			     <option value="中等">中等</option> 
                 <option value="简单">简单</option> 
                 </select>
            </td>
		</tr>
        </table>
</form>
<script type="text/javascript">
    $(function () {
        var editor = CKEDITOR.replace('E_TITLE');          // 创建编辑器
        CKFinder.setupCKEditor(editor, '../js/ckfinder/');   // 为编辑器绑定"上传控件"
        answerType($('#E_TYPE').val());
    });
    function answerType(type) {
        if (type == "判断") {
            $('#Xanswer').css('display', 'none');
            $('#Panswer').css('display', 'block');
        }
        else if (type == "选择") {
            $('#Panswer').css('display', 'none');
            $('#Xanswer').css('display', 'block');
        }
    }
    //    判断CKEDITOR是否存在，如果存在就销毁再新建一个，但编辑器无法编辑
//    var editor;
//    if (!CKEDITOR.instances.E_TITLE) {  //判定content2是否存在
//        editor = CKEDITOR.replace("E_TITLE");
//    } else {
//        addCkeditor("E_TITLE");
//    }

//    function addCkeditor(id) {

//        var editor2 = CKEDITOR.instances[id];

//        if (editor2) editor2.destroy(true); //销毁编辑器 content2,然后新增一个
//        editor = CKEDITOR.replace(id);
//    }   
</script>
</body>
</html>

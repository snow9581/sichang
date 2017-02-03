<%@ Page Language="C#" AutoEventWireup="true" CodeFile="_examination.aspx.cs" Inherits="exam_examination" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>
   <script src="../js/export.js" type="text/javascript"></script>
   <style type="text/css">
       .color
       {
           background-color:Yellow;
       }
   </style>
</head>
<body>
    <form id="form1"  runat="server" >
    <div id="cc" class="easyui-panel" title="正在考试" data-options="tools:'#tt'" style=" height:470px"> 
    <table id="Xdg" class="easyui-datagrid" title="选择题"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				url: '_getPartExam.ashx?type=X',
				onClickRow: onClickRowX,
                fitColumns: true,
                fit: false,
                rownumbers:true
			"  >
		<thead>
			<tr>
				<th data-options="field:'E_TITLE',width:800">题目</th>
				<th data-options="field:'UserAnswer',width:100,align:'center',editor:'validatebox'">作答</th>
                <th data-options="field:'E_ANSWER',width:100,align:'center'" data-options="formatter:color">答案</th>
			</tr>
		</thead>
	</table>

    <table id="Pdg" class="easyui-datagrid" title="判断题" 
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				url: '_getPartExam.ashx?type=P',
				onClickRow: onClickRowP,
                fitColumns: true,
                fit: false,
                rownumbers:true
			"  >
		<thead>
			<tr>
				<th data-options="field:'E_TITLE',width:800">题目</th>
                <th data-options="field:'UserAnswer',width:100,align:'center',
                                    editor:{
                                    type:'combobox',
                                    options:{
                                    editable:false,
                                    listHeight:'20',
                                    panelHeight:'50', 
                                    data:  
                                    [  
                                    {'id':'对','text':'对'},  
                                    {'id':'错','text':'错'},
                                    ],  
                                    valueField:'id',  
                                    textField:'text'}}">作答</th>
				<%--<th data-options="field:'UserAnswer',width:100,align:'center',editor:'validatebox'">作答</th>--%>
                <th data-options="field:'E_ANSWER',width:100,align:'center'" data-options="formatter:color">答案</th>
			</tr>
		</thead>
	</table>
    </div>
    <br />
    <div style=" text-align:center">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submit()">提交</a>
     </div> 
     <div id="tt">
       <span style="width: 150px; display: inline-block; text-align:right;"><label style=" font-weight:bold; color:red;" id="labelScore"></label></span>
     </div>
     <input id="Etime" type="hidden" runat="server" />
     <input id="scoreX" type="hidden" runat="server" />
     <input id="scoreP" type="hidden" runat="server" />
     <input id="endExam" type="hidden" runat="server" />
    </form>
    	<script type="text/javascript">
    	    $(function () {
    	        $("#Xdg").datagrid('hideColumn', "E_ANSWER"); //隐藏选择答案
    	        $("#Pdg").datagrid('hideColumn', "E_ANSWER"); //隐藏判断答案
    	        showTime(); //倒计时
//    	        document.getElementById('label_scoreX').innerHTML = $('#scoreX').val() + "分/题";
//    	        document.getElementById('label_scoreP').innerHTML = $('#scoreP').val() + "分/题";

    	        //点击空白处，datagrid自动保存
    	        var gcn = gcn || {};
    	        gcn.listen = function (a, e, b) {
    	            if (a.addEventListener)
    	            { a.addEventListener(e, b, false) }
    	            else if (a.attachEvent) { a.attachEvent('on' + e, b) }
    	        };
    	        gcn.redirect = function () {
    	            if (endEditingX()) {
    	                $('#Xdg').datagrid('acceptChanges');
    	            }
    	            if (endEditingP()) {
    	                $('#Pdg').datagrid('acceptChanges');
    	            }
    	        };
    	        gcn.listen(document, 'click', gcn.redirect);
    	    });

    	    //设定倒数秒数  
    	    var t = $('#Etime').val()*60;
    	    //显示倒数秒数  
    	    function showTime() {
    	        t -= 1;
    	        document.getElementById('labelScore').innerHTML = "倒计时：" + Math.floor(t / 60) + "分钟" + t % 60 + "秒";
    	        if (t == 0) {
    	            var score = totalScore();
    	            alert("考试结束！成绩：" + score + "分");
    	            $.post('_handInParper.ashx', { Score: score, FullScore: $('#Xdg').datagrid('getRows').length * $('#scoreX').val() + $('#Pdg').datagrid('getRows').length * $('#scoreP').val() });
    	            $("#Xdg").datagrid('showColumn', "E_ANSWER"); //显示选择答案
    	            $("#Pdg").datagrid('showColumn', "E_ANSWER"); //显示判断答案
    	            labelScore.innerHTML = "成绩：" + score + "分";
    	        }
    	        //每秒执行一次,showTime()  

    	        else
                    setTimeout("showTime()", 1000);
    	    }

            //单选题，datagrid行编辑所需函数
    	    var editIndex = undefined;
    	    function endEditingX() {
    	        if (editIndex == undefined) { return true }
    	        if ($('#Xdg').datagrid('validateRow', editIndex)) {
    	            $('#Xdg').datagrid('endEdit', editIndex);
    	            editIndex = undefined;
    	            return true;
    	        } else {
    	            return false;
    	        }
    	    }

    	    function onClickRowX(index) {
    	        if ($('#endExam').val() != "1") {
    	            if (editIndex != index) {
    	                if (endEditingX()) {
    	                    $('#Xdg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
    	                    editIndex = index;
    	                } else {
    	                    $('#Xdg').datagrid('selectRow', editIndex);
    	                }
    	            }
    	        }
    	    }
    	    //判断题，datagrid行编辑所需函数
    	    var editIndexP = undefined;
            function endEditingP() {
    	        if (editIndexP == undefined) { return true }
    	        if ($('#Pdg').datagrid('validateRow', editIndexP)) {
    	            var ed = $('#Pdg').datagrid('getEditor', { index: editIndexP, field: 'UserAnswer' });
    	            var answer = $(ed.target).combobox('getText');
    	            $('#Pdg').datagrid('getRows')[editIndexP]['text'] = answer;
    	            $('#Pdg').datagrid('endEdit', editIndexP);
    	            editIndexP = undefined;
    	            return true;
    	        } else {
    	            return false;
    	        }
    	    }
    	    function onClickRowP(index) {
    	        if ($('#endExam').val() != "1") {
    	            if (editIndexP != index) {
    	                if (endEditingP()) {
    	                    $('#Pdg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
    	                    editIndexP = index;
    	                } else {
    	                    $('#Pdg').datagrid('selectRow', editIndexP);
    	                }
    	            }
    	        }
    	    }
            //交卷
    	    function submit() {
    	        $.messager.confirm('提示', '确定交卷吗?', function (r) {
    	            if (r) {
    	                t = 1;
    	            }
    	        });
    	    }

            //计算分数
    	    function totalScore() {
    	        document.getElementById("endExam").value = "1";//页面状态为：结束考试，不可编辑行
                var totalScore = 0;
    	        var rows = $('#Xdg').datagrid('getRows');
    	        for (var i = 0; i < rows.length; i++) {
    	            if (rows[i].UserAnswer != null && rows[i].UserAnswer.toUpperCase() == rows[i].E_ANSWER)
    	                totalScore = totalScore + parseInt(rows[i].score);
    	            else {
    	                $('#Xdg').datagrid('updateRow', {
    	                    index: i,
    	                    row: {
    	                        E_ANSWER: '<span style="color:red">' + rows[i].E_ANSWER + '</span>'
    	                    }
    	                });
    	            }
    	        }
    	        var rows = $('#Pdg').datagrid('getRows');
    	        for (var i = 0; i < rows.length; i++) {
    	            if (rows[i].UserAnswer != null && rows[i].UserAnswer.toUpperCase() == rows[i].E_ANSWER)
    	                totalScore = totalScore + parseInt(rows[i].score);
                    else {
    	                $('#Pdg').datagrid('updateRow', {
    	                    index: i,
    	                    row: {
    	                        E_ANSWER: '<span style="color:red">' + rows[i].E_ANSWER + '</span>'
    	                    }
    	                });
    	            }
    	        }
    	        return totalScore;
    	    }
	</script>
</body>
</html>

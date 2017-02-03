<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubmitWorkLoad.aspx.cs" Inherits="plan_planRun_dtz_SubmitWorkLoad" %>
<!--各单位提交工作量-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div id="p" class="easyui-panel" title="工程量提交" style="width:100%;height:100%;">
    <form id="ff" method="post" action="SubmitWorkLoad.ashx" enctype="multipart/form-data" style="width:100%; height:95%;">
    <input value="1" type="hidden" id="hd_id"  runat="server"/>
    <input value="1" type="hidden" id="hd_comflag"  runat="server"/>
    <input value="1" type="hidden" id="H_PName"  runat="server"/>
    <input value="1" type="hidden" id="H_workloadFile"  runat="server"/>
    <input value="1" type="hidden" id="userName"  runat="server"/>
    <div id="tool" style=" padding:10px">  
        <a id="Btn_submitCom" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="SubmitCom()">发送委托</a>
        
        <span  style=" position:absolute; right:20px;">
        <span class="finish" style=" display:none">已提交的工程量：<a href="#" onclick="downloadWord()">下载</a></span>&nbsp;&nbsp;&nbsp;
        <span class="finish" style=" display:none">重新</span>提交工程量：<input id="W_FILE" name="W_FILE" class="easyui-validatebox textbox" type="file" style="width:170px;" runat ="server"/>&nbsp;&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" onclick="submitForm()">提交</a>
        </span>
    </div>
	<table class="easyui-datagrid" style="width:100%;height:85%" data-options="title:$('#H_PName').val()+'->委托资料',url:'getCommission.ashx?PID='+$('#hd_id').val()+'&type=1',showFooters: true,pagination:true,pageSize: 10,fitColumns:true,singleSelect:true,remoteSort: false,rownumbers:true,sortName: 'RELEASERQ',sortOrder: 'desc'">
    <thead>    
        <tr>
            <th data-options="field:'CONSIGNERMAJOR',width:80">委托人专业</th>
			<th data-options="field:'CONSIGNER',width:150">委托人</th>
            <th data-options="field:'SENDEEMAJOR',width:80">接收人专业</th>
			<th data-options="field:'SENDEE',styler:SendeeColor,width:150">接收人</th>
            <th data-options="field:'FILES',formatter:download,width:150">委托资料文档</th>
			<th data-options="field:'RELEASERQ',width:150">委托时间</th>				
		</tr>
    </thead>
    </table>

    </form>
</div>
<script type="text/javascript">
    $(function () {
        if (document.getElementById("H_workloadFile").value != "")
            $('.finish').show();
    });
    function FindData_wt() {
        $('#wt').datagrid('load', {
            Find_SENDEE: $('#Find_SENDEE').val()
        });

    }
    function SubmitCom() {
        if (document.getElementById("hd_comflag").value == "1")
            alert("委托资料提交结束！");
        else
            working('提交委托资料', 'SubmitCommission.aspx', $('#hd_id').val() + '&principal=0&type=1');
    }
    function download(val, row) {
        if (row.FILES != '#' && row.FILES != '' && row.FILES != undefined)
            return '<a href="../../datasubmit/downloadPic.aspx?picName=' + escape(row.FILES) + '&package=archives" target="_blank">' + '下载' + '</a>  '
        else
            return ''
    }
    function SendeeColor(val, row) {
        if (row.SENDEE == $("#userName").val()) {
            return 'color:green;'
        }
        else
            return ''
    }
    function submitForm() {
        $("#save").removeAttr("onclick");
        $('#ff').form('submit', {
            success: function (data) {
                if (data.toString() == '1') {
                    var strUrl = window.location.href;
                    var arrUrl = strUrl.split("/");
                    var strPage = arrUrl[arrUrl.length - 1].split("#");
                    var page = strPage[0];
                    self.location = page;
                    parent.saveurl();
                }
                else if (data.toString().indexOf('对不起') >= 0)//高俊涛增加于 2014-10-09 判断提交失败的原因是否是账号过期,提示用户重新登陆。
                {
                    $.messager.alert('提示框', '登陆账号已过期，请重新登录！');
                }
                else {
                    $.messager.alert('提示框', '计划提交失败');
                }
            }
        });
    }
    function downloadWord() {
        var wordname = document.getElementById("H_workloadFile").value;
        var url = "../../datasubmit/downloadPic.aspx?picName=" + wordname + "&package=ftp_planfile";
        self.location.href = url;
    }    
    </script> 
   
</body>
</html>

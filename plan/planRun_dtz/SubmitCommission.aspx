<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubmitCommission.aspx.cs" Inherits="plan_planRun_dtz_SubmitCommission" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div class="easyui-panel" title="提交委托资料" style="width:100%;height:100%;">
<div id="tools" style=" display:none;padding:10px">
    <a id="BackWorkLoad" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="working('提交工程量', 'SubmitWorkLoad.aspx',$('#hd_id').val())">返回</a> 
    <a id="BackSecComFile" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="working('提交二次委托资料', 'ShowSecComFile.aspx',$('#hd_id').val())">返回</a> 
</div>
<div id="selectMajMain" style="text-align:left; margin-left:15%;"><span style=" float:left">请选择专业:&nbsp;&nbsp;</span><div id="selectMaj" style="float:left"> </div> <a href='javascript:void(0)' class='easyui-linkbutton' onclick="showCom()">确定</a></div>
    <br />
    <form id="ff" method="post" action="SubmitCommission.ashx" enctype="multipart/form-data">
    <input id="ckLength" type="hidden" runat="server" value="0"/>
    <input id="hd_id" value="1" type="hidden"  runat="server"/>
    <input id="comFlag" type="hidden"  runat="server"/>
    <input id="secondComFlag" type="hidden"  runat="server"/>
    <input id="hd_type" type="hidden"  runat="server"/>
    <input id="hd_principal" type="hidden"  runat="server"/>
        <div id="submitCom" style=" display:none;text-align:center;"></div>
        
        <div id="BtnSubmit" style=" display:none;text-align:center;padding:5px;" >           
        <a id="save" href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">清空</a>        
        </div>  
    </form> 
</div>
<script type="text/javascript">
    $(function () {
        if ($('#hd_principal').val() == "0" && $('#hd_type').val() == "1") {
            $('#BackSecComFile').remove();
            $('#tools').show();
        }
        else if ($('#hd_principal').val() == "0" && $('#hd_type').val() == "2") {
            $('#BackWorkLoad').remove();
            $('#tools').show();
        }
        $.getJSON("../getOfficeStaff/getMajor.ashx", null, function (response) {
            var listHtml = "";
            //循环取json中的数据,并呈现在列表中 
            $.each(response, function (i) {
                listHtml += " <input type='checkbox'";
                listHtml += " name=major";
                listHtml += " id=cr0" + i;
                listHtml += " value=" + response[i].text;
                listHtml += " style=border:none;/>";
                listHtml += "<label for=cr0" + i;
                listHtml += ">" + response[i].text + "</label>&nbsp;&nbsp;";
                if ((i + 1) % 8 == 0) {
                    listHtml += "<br/>";
                    $("#selectMajMain").append("<br/>"); 
                }
            });
            $("#selectMaj").html(listHtml);
        });
    });
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
                } else if (data.toString() == "") {
                    alert('登陆账号已过期，请重新登录！');
                    window.top.location.href = '../../login.aspx';
                }
                else {
                    $.messager.alert('提示框', '提交失败');
                }
            }
        });
    }

    function clearForm() {
        $('#ff').form('clear');
    }
    function showCom() {
        if ($('#hd_type').val() == "1" && $('#comFlag').val() != "") {
            alert("委托资料已结束提交!");
        }
        else if ($('#hd_type').val() == "2" && $('#secondComFlag').val() != "") {
            alert("委托资料已结束提交!");
        }
        else {
            $("#ckLength").val($('input[name="major"]:checked').length);
            $("#submitCom").html("");
            $("#BtnSubmit").css('display', 'block');
            $("#submitCom").css('display', 'block');
            $('input[name="major"]:checked').each(function (i) {
                $("#submitCom").append($(this).val() + "<input type='hidden' name='selectMajor" + i + "' value='" + $(this).val() + "'/>&nbsp;&nbsp;&nbsp;&nbsp;专业负责人：<input name='combobox" + i + "' id='combobox" + i + "' class='easyui-combobox' data-options='required:\"true\"'/>&nbsp;&nbsp;&nbsp;&nbsp;委托资料：<input name='commission" + i + "' id='commission" + i + "' type='file'><br/><br/>");
                $("#combobox" + i).combobox({
                    type: 'post',
                    url: '../getOfficeStaff/getMajor.ashx?major=' + escape($(this).val()) + '&pid=' + $('#hd_id').val(),
                    valueField: 'text',
                    textField: 'text'
                });
            });
        }
    }

</script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_test.aspx.cs" Inherits="ybManage_text_input_text" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../themes/icon.css" rel="stylesheet" type="text/css" />    
</head>
<body>
    <style type="text/css">
        #pages{margin:auto;text-align:center;width:100%;}
        #page{margin-left:auto;margin-right:auto;width:80%;padding:10px;overflow:hidden;/*background-color:deeppink;*/}
        #left{text-align:center;padding:0px 20px 0px 50px;width:35%;float:left;margin-right:100px;border:3px solid black;height:99.6%}
        #right{text-align:center;float:left;border:3px solid black;width:40%;padding:0px 20px;height:99.6%}
        #data{margin:0px auto;width:70%;background-color:black;/*border-collapse:collapse;*/border-width: 0px 0px 0px 0px;border:none;}
        #DATA1,#DATA2,#DATA3,#DATA4,#DATA5,#DATA6,#DATA7,#DATA8,#DATA9,#DATA10,#DATA11,#DATA12,#DATA13,#DATA14,#DATA15,#DATA16,#DATA17,#DATA18,#DATA19,#DATA20,#DATA21,#DATA22,#DATA23,#DATA24,#DATA25,#DATA26,#DATA27,#DATA28,#DATA29,#DATA30,#DATA31,#DATA32,#DATA33,#DATA34,#DATA35,#DATA36,#DATA37,#DATA38{
            /*width:30px;*/width:100%;padding:0px 0px;}
        #head1{word-spacing:2px;font-size:16px;border-width: 0px 0px 0px 0px;border:none;}
        #head2{word-spacing:5px;font-size:25px;border-width: 0px 0px 0px 0px;border:none;}
        #head3{border-width: 0px 0px 0px 0px;border:none;}
        #head-right{word-spacing:5px;font-size:25px;}      
        .bg{background-color:white;border:1px solid black;}
    </style>
    <div id="pages">
        <input id="formid" runat="server" type="hidden" />
        <form id="form1" method= "post"  runat="server">
            <input type="hidden" value="1"  id="hd_index"  runat="server"/>
            <input type="hidden" value="1"  id="hd_DM"  runat="server"/>
            <input type="hidden" value=""  id="ul"  runat="server"/>
            <div id="page">
                <input type="hidden" value=""  id="ID" name="ID"  runat="server"/>
                <div id="left">                
                    <table>
                        <tr class="table">
                            <td colspan="3"><p id="head1">第 四 采 油 厂 规 划 设 计 研 究 所</p></td>
                        </tr>
                        <tr>
                            <td colspan="3"><p id="head2">检 定 证 书</p></td>
                        </tr>
                        <tr>
                            <td colspan="3"><p id="num">证书编号:<label id="T_NUMBER"></label></p></td>
                        </tr>
                        <tr>
                            <td style="width:40%">送检单位：</td>
                            <td colspan="2"><input id="COMPANY" name="COMPANY" runat="server" class="easyui-textbox" style="width:100%" /></td>
                        </tr>
                        <tr>
                            <td style="width:40%">仪表名称：</td>
                            <td colspan="2"><input id="YBMC" name="YBMC" runat="server" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td style="width:40%">型号/规格：</td>
                            <td colspan="2"><input id="GGXH" name="GGXH" runat="server" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td style="width:40%">出厂编号：</td>
                            <td colspan="2"><input id="CCBH" name="CCBH" runat="server" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td style="width:40%">准确度等级：</td>
                            <td colspan="2"><input id="ZQDDJ" name="ZQDDJ" runat="server" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td style="width:40%">生产厂家：</td>
                            <td colspan="2"><input id="SCCJ" name="SCCJ" runat="server" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td style="width:40%">检定结果：</td>
                            <td colspan="2"><input id="JDJG" name="JDJG" runat="server" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width:20%"">主 管：</td>
                            <td style="width:50%"><input id="COMPETENT" runat="server" name="COMPETENT" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>核验员：</td>
                            <td style="width:50%"><input id="CHECKER" runat="server" name="CHECKER" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>检定员：</td>
                            <td style="width:50%"><input id="TEXTER" name="TEXTER" runat="server" class="easyui-textbox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td>检定日期：</td>
                            <td colspan="2"><input name="TEXTDATE" runat="server" id="TEXTDATE" class="easyui-datebox" style="width:100%"  /></td>
                        </tr>
                        <tr>
                            <td>有效日期：</td>
                            <td colspan="2"><input name="VALIDDATE" runat="server" id="VALIDDATE" class="easyui-datebox" style="width:100%"  /></td>
                        </tr>
                    </table>
                </div>
                <div id="right">
                    <table style="margin:0px auto">
                        <tr>
                            <td colspan="6" style="height:40px"></td>
                        </tr>

                        <tr>
                            <td colspan="6"><p id="head-right">检定结果</p></td>
                        </tr>
                        <tr>
                            <td colspan="6" style="height:30px"></td>
                        </tr>
                    </table>
                    <table id="data">
                        <tr>
                            <td class="bg">量程</td>
                            <td class="bg">标准值</td>
                            <td class="bg" colspan="2" class="border" >指示值<select runat="server" class="easyui-combobox" id="DATA3" name="DATA3" style="width:50px; height:23px;">
                                    <option value="Ω">&Omega;</option>
                                    <option value="&#8451">&#8451</option>
                                    <option value="mA">mA</option>
                                    <option value="MPa">MPa</option>
                                    <option value="m">m</option>
                                                                 </select></td>
                            <td class="bg" colspan="2">误差</td>
                        </tr>
                        <tr>
                            <td class="bg"><select class="easyui-combobox" id="DATA1" runat="server" name="DATA1" style="width:50px; height:23px;">
                                    <option value="Ω">&Omega;</option>
                                    <option value="&#8451">&#8451</option>
                                    <option value="mA">mA</option>
                                    <option value="MPa">MPa</option>
                                    <option value="m">m</option>
                                </select></td>
                            <td class="bg"><select class="easyui-combobox" runat="server" id="DATA2" name="DATA2" style="width:50px; height:23px;">
                                    <option value="Ω">&Omega;</option>
                                    <option value="&#8451">&#8451</option>
                                    <option value="mA">mA</option>
                                    <option value="MPa">MPa</option>
                                    <option value="m">m</option>
                                </select></td>
                            <td class="bg">上升</td>
                            <td class="bg">下降</td>
                            <td class="bg">上升</td>
                            <td class="bg">下降</td>
                        </tr>
                        <tr>
                            <td><input id="DATA9" runat="server" name="DATA9" class="easyui-textbox" /></td>
                            <td><input id="DATA10" runat="server" name="DATA10" class="easyui-textbox" /></td>
                            <td><input id="DATA11" runat="server" name="DATA11" class="easyui-textbox" /></td>
                            <td><input id="DATA12" runat="server" name="DATA12" class="easyui-textbox" /></td>
                            <td><input id="DATA13" runat="server" name="DATA13" class="easyui-textbox" /></td>
                            <td><input id="DATA14" runat="server" name="DATA14" class="easyui-textbox" /></td>
                        </tr>
                        <tr>
                            <td><input id="DATA15" runat="server" name="DATA15" class="easyui-textbox" /></td>
                            <td><input id="DATA16" runat="server" name="DATA16" class="easyui-textbox" /></td>
                            <td><input id="DATA17" runat="server" name="DATA17" class="easyui-textbox" /></td>
                            <td><input id="DATA18" runat="server" name="DATA18" class="easyui-textbox" /></td>
                            <td><input id="DATA19" runat="server" name="DATA19" class="easyui-textbox" /></td>
                            <td><input id="DATA20" runat="server" name="DATA20" class="easyui-textbox" /></td>
                        </tr>
                        <tr>
                            <td><input id="DATA21" runat="server" name="DATA21" class="easyui-textbox" /></td>
                            <td><input id="DATA22" runat="server" name="DATA22" class="easyui-textbox" /></td>
                            <td><input id="DATA23" runat="server" name="DATA23" class="easyui-textbox" /></td>
                            <td><input id="DATA24" runat="server" name="DATA24" class="easyui-textbox" /></td>
                            <td><input id="DATA25" runat="server" name="DATA25" class="easyui-textbox" /></td>
                            <td><input id="DATA26" runat="server" name="DATA26" class="easyui-textbox" /></td>
                        </tr>
                        <tr>
                            <td><input id="DATA27" runat="server" name="DATA27" class="easyui-textbox" /></td>
                            <td><input id="DATA28" runat="server" name="DATA28" class="easyui-textbox" /></td>
                            <td><input id="DATA29" runat="server" name="DATA29" class="easyui-textbox" /></td>
                            <td><input id="DATA30" runat="server" name="DATA30" class="easyui-textbox" /></td>
                            <td><input id="DATA31" runat="server" name="DATA31" class="easyui-textbox" /></td>
                            <td><input id="DATA32" runat="server" name="DATA32" class="easyui-textbox" /></td>
                        </tr>
                        <tr>
                            <td><input id="DATA33" runat="server" name="DATA33" class="easyui-textbox" /></td>
                            <td><input id="DATA34" runat="server" name="DATA34" class="easyui-textbox" /></td>
                            <td><input id="DATA35" runat="server" name="DATA35" class="easyui-textbox" /></td>
                            <td><input id="DATA36" runat="server" name="DATA36" class="easyui-textbox" /></td>
                            <td><input id="DATA37" runat="server" name="DATA37" class="easyui-textbox" /></td>
                            <td><input id="DATA38" runat="server" name="DATA38" class="easyui-textbox" /></td>
                        </tr>     
                     </table>
                    <table style="margin:0px auto">                   
                        <tr>
                            <td colspan="6" style="height:30px"></td>

                        </tr>
                    
                        <tr>
                            <td colspan="2">最大误差：</td>
                            <td colspan="4"><input id="MAXERROR" runat="server" name="MAXERROR" class="easyui-textbox" /></td>
                        </tr>
                        <tr>
                            <td colspan="2">检定结果：</td>
                            <td colspan="4"><input id="TEXTED" runat="server" name="TEXTED" class="easyui-textbox" value="合格" /></td>
                        </tr>   
                        <tr>
                            <td colspan="6" style="height:60px"></td>
                        </tr>
                    </table>   
                </div>            
            </div>
                <div style="padding:5px 0;text-align:right;padding-right:30px">
                    <a href="#" id="save" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem($('#hd_index').val())">保存</a>&nbsp;&nbsp;&nbsp;
                    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" id="cancel">取消</a>
	            </div>
        </form>
    </div>
    <script src="../js/sichang.js" type="text/javascript"></script>
    <script src="test.js"></script>
</body>
</html>

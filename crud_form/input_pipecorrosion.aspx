<%@ Page Language="C#" AutoEventWireup="true" CodeFile="input_pipecorrosion.aspx.cs" Inherits="easyui_crud_demo_show_form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../js/jquery.easyui.min.js" type="text/javascript"></script> 
    <script src="../js/datagrid-detailview.js" type="text/javascript"></script>   
</head>
<body>
    <form id="Form1" method="post" runat="server" enctype="multipart/form-data">
    <input type="hidden" value="1"  id="hd_index"  runat="server"/>
   <input name="KM" class="easyui-validatebox"  type="hidden"/>
    <input name="DM" class="easyui-validatebox" type="hidden"/>
    <input name="CREATEDATE" class="easyui-datebox" type="hidden"/>
	<table class="dv-table" style="width:100%;background:#fafafa;padding:5px;margin-top:5px;">
		<tr>
			<%--<td>矿别</td>
			<td><input name="KB" class="easyui-validatebox" required="true"/></td>
			<td>队名</td>
			<td><input name="DM" class="easyui-validatebox" required="true"/></td>--%>
			
			<td>起点名称</td>
			<td><input name="QDMC" class="easyui-validatebox" required="true"/></td>
			<td>终点名称</td>
			<td><input name="ZDMC" class="easyui-validatebox" /></td>
	
			<td>管道类别</td>
			<td>
			
			<select  name="GDLB" class="easyui-combobox" style="width:155px;">
				 <option value="稳-库">稳-库</option>        
			     <option value="放-脱">放-脱</option>        
			     <option value="计-放">计-放</option>
			     <option value="计-井">计-井</option>        
			     <option value="计-转">计-转</option>
			     
			      <option value="计-计">计-计</option>        
			     <option value="井-计">井-计</option>        
			     <option value="井-井">井-井</option>
			     <option value="脱-脱">脱-脱</option>        
			     <option value="脱-稳">脱-稳</option>
			     
			      <option value="转-放">转-放</option>        
			     <option value="转-计">转-计</option>        
			     <option value="转-脱">转-脱</option>
			     <option value="转-转">转-转</option>        
			     <option value="放-计">放-计</option>
			     
			      <option value="井-干管">井-干管</option>        
			     <option value="干管-井">干管-井</option>        
			     <option value="站内管道">站内管道</option>
			     <option value="注水干线">注水干线</option>        
			     <option value="注水支线">注水支线</option>
			     <option value="污水管线">污水管线</option>
			      <option value="注水支干线">注水支干线</option>        
			     <option value="注水加密干线">注水加密干线</option>        
			     <option value="注水加密支干线">注水加密支干线</option>
			     <option value="注水加密支线">注水加密支线</option>        
			     <option value="注入干线">注入干线</option>
			     
			      <option value="注入支干线">注入支干线</option>        
			     <option value="注入支线">注入支线</option>        
			     <option value="反冲洗水管线">反冲洗水管线</option>
			     <option value="回收水管线">回收水管线</option>        
			     <option value="其他">其他</option>
			     
			</select>
			</td>
		</tr>
		<tr>
			
			
			<td>管道名称</td>
			<td>
			
			<select  name="GDMC" class="easyui-combobox" style="width:155px;">
				 <option value="外输管线">外输管线</option>        
			     <option value="集油管线">集油管线</option>        
			     <option value="掺水管线">掺水管线</option>
			     <option value="热洗管道">热洗管道</option>        
			     <option value="污水管线">污水管线</option>
			     
			      <option value="注水管线">注水管线</option>        
			     <option value="注入管线">注入管线</option>        
			     <option value="清水管线">清水管线</option>
			     <option value="外输气管线">外输气管线</option>        
			     <option value="返输气管线">返输气管线</option>
			     
			      <option value="污油管线">污油管线</option>        
			     <option value="收油管线">收油管线</option>        
			     <option value="采暖管线">采暖管线</option>
			     <option value="其他">其他</option> 
			</select>
			</td>
			
		    <td>管道建设时间</td>
			<td><input name="GDJSSJ" class="easyui-datebox" /></td>
			<td>输送介质</td>
			<td>
			
			<select  name="SSJZ" class="easyui-combobox" style="width:155px;">
				 <option value="含油污水">含油污水</option>        
			     <option value="深度污水">深度污水</option>        
			     <option value="聚合物污水">聚合物污水</option>
			     <option value="三元污水">三元污水</option>        
			     <option value="清水">清水</option>
			      <option value="含水油">含水油</option>        
			     <option value="纯油">纯油</option>        
			     <option value="聚合物">聚合物</option>
			     <option value="三元">三元</option>        
			     <option value="天然气">天然气</option>
			      <option value="母液">母液</option>  
			     <option value="其他">其他</option> 
			</select>
			
			</td>
			
		</tr>
		<tr>
			<%--<td>管道规格</td>
			<td><input name="GDGG" class="easyui-validatebox" /></td>	--%>
			

			<td>管道长度</td>
			<td><input name="GDCD" class="easyui-numberbox" precision="2"/></td>
			<td>材质</td>
			<td>
			<select  name="GDCZ" class="easyui-combobox" style="width:155px;">
				 <option value="无缝钢管10">无缝钢管10</option>        
			     <option value="无缝钢管20">无缝钢管20</option>        
			     <option value="无缝钢管40">无缝钢管40</option>
			     <option value="无缝钢管50">无缝钢管50</option>        
			     <option value="无缝钢管16Mn">无缝钢管16Mn</option>
			     
			      <option value="无缝钢管20Mn">无缝钢管20Mn</option>        
			     <option value="不锈钢管">不锈钢管</option>        
			     <option value="焊接钢管Q215-A">焊接钢管Q215-A</option>
			     <option value="螺旋焊缝钢管">螺旋焊缝钢管</option>        
			     <option value="螺旋焊缝钢管Q235-A">螺旋焊缝钢管Q235-A</option>
			     
			      <option value="螺旋焊缝钢管Q235-B">螺旋焊缝钢管Q235-B</option>        
			     <option value="铸铁管">铸铁管</option>        
			     <option value="渗镍管">渗镍管</option>
			     <option value="双金属复合管">双金属复合管</option>        
			     <option value="A3钢">A3钢</option>
			     
			      <option value="树脂碳钢管">树脂碳钢管</option>        
			     <option value="液力柔性复合管">液力柔性复合管</option>        
			     <option value="连续柔性复合高压管">连续柔性复合高压管</option>
			     <option value="续增强塑料复合管">续增强塑料复合管</option>        
			     <option value="塑料合金复合管">塑料合金复合管</option>
			     
			      <option value="改性HDPE高密度聚乙烯管">改性HDPE高密度聚乙烯管</option>        
			     <option value="钢骨架塑料复合管">钢骨架塑料复合管</option>        
			     <option value="钢筋混凝土管">钢筋混凝土管</option>
			     <option value="玻璃钢管">玻璃钢管</option>        
			     <option value="内衬聚四氟乙烯不锈钢管">内衬聚四氟乙烯不锈钢管</option>
			     
			      <option value="玻璃钢不锈钢复合管">玻璃钢不锈钢复合管</option>  
			     <option value="其他">其他</option>
			     
			</select>
			</td>
			<td>穿孔时间</td>
			<td><input name="CKSJ" class="easyui-datebox" /></td>
            
            <td>管道规格   Ф</td>
            <td style="width:50px"><input name="GDGG1" id="GDGG1" class="easyui-validatebox" runat="server" style="width:50px"/></td>
            <td>×</td>
			<td style="width:100px"><input name="GDGG2" id="GDGG2" class="easyui-validatebox" runat ="server" style="width:50px"/></td>
		</tr>
		
		<tr>
			<td>穿孔所处地类</td>
			<td>
			
			<select  name="CKSCDL" class="easyui-combobox" style="width:155px;">
				 <option value="低洼地">低洼地</option>        
			     <option value="水泡子">水泡子</option>        
			     <option value="菜地">菜地</option>
			     <option value="林地">林地</option>        
			     <option value="耕地">耕地</option>
			      <option value="草地">草地</option>        
			     <option value="居民区">居民区</option>        
			     <option value="楼区">楼区</option>
			</select>
			</td>
			<td>穿孔原因</td>
			<td>
			<select  name="CKYY" class="easyui-combobox" style="width:155px;">
				 <option value="外腐蚀">外腐蚀</option>        
			     <option value="内腐蚀">内腐蚀</option>        
			     <option value="机械破坏">机械破坏</option>
			</select>
			
			</td>
			<td>穿孔位置</td>
			<td><input name="CKWZ" class="easyui-validatebox" /></td>
			
		</tr>
		
		<tr>
            <td>泄露量</td>
			<td><input name="XLL" class="easyui-numberbox" /></td>
			<td>处理方式</td>
			<td><input name="CLFS" class="easyui-validatebox" />	</td>
        </tr>
        <tr>
			<td>是否恢复</td>
			<td>
			<select  name="SFHF" class="easyui-combobox" style="width:155px;">
				 <option value="是">是</option>        
			     <option value="否">否</option>  
			</select>
			</td>
			<td>处理完成时间</td>
			<td><input name="CLWCSJ" class="easyui-datebox" /></td>
			<td>未处理原因</td>
			<td><input name="WCLYY" class="easyui-validatebox" /></td>
		</tr>
		<tr>
			<td>小队负责人</td>
			<td><input name="XDFZR" class="easyui-validatebox" />	</td>
			<td>联系方式</td>
			<td><input name="LXFS" class="easyui-validatebox" /></td>
			<td>是否有照片</td>
			<td>
			<select  name="SFYZP" class="easyui-combobox" style="width:155px;">
				 <option value="是">是</option>        
			     <option value="否">否</option>  
			</select>
			</td>
		</tr>
		<tr>

			<td>照片1</td>
			<td><input  type="file" name="PIC1" class="easyui-validatebox" />
             <input type="hidden" name="PICTURE1" class="easyui-validatebox" />
             </td>
			<td>照片2</td>
			<td><input  type="file" name="PIC2" class="easyui-validatebox" />
            <input type="hidden" name="PICTURE2" class="easyui-validatebox" />	</td>
			<td>照片3</td>
			<td><input  type="file" name="PIC3" class="easyui-validatebox" />
            <input type="hidden" name="PICTURE3" class="easyui-validatebox" /></td>
			
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
          if (userlevel == "6" || userlevel == "2") {
              $("form :input").attr("readonly", "readonly"); //设置控件为只读
              $("form :input[type='file']").hide(); //隐藏上传文件窗口
              $("form a").hide(); //隐藏保存和撤销按钮    
          }
      }); 
    
   </script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main_6.aspx.cs" Inherits="main" %>
<!--规划所其他工作人员主操作界面-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>地面工程信息管理平台</title>
    
    <link href="themes/default/easyui.css" rel="stylesheet" type="text/css" />  
    
    <link href="themes/icon.css" rel="stylesheet" type="text/css" />

    <script src="js/jquery-1.8.0.min.js" type="text/javascript"></script>

    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
  
    <script src="js/datagrid-detailview.js" type="text/javascript"></script>

    <script src="js/sichang.js" type="text/javascript"></script>
    
    <script src="js/export.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
<form id="form1" method="post" action="plan/ReloadMain.ashx">
    <div region="west" title="功能模块" style="width: 200px;" split="true">
        <div id="divTree" style="height: 480px;">
            <div title="地面档案管理" iconcls="icon-T_DMDA" style="overflow: auto;">
                <ul>   
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('房屋信息','crud_tables/show_house.aspx')">房屋信息</a>
                    </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('大事纪要','crud_tables/show_event.aspx')">大事纪要</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('维修记录','crud_tables/show_repair.aspx')">维修记录表</a> </li>
                        
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('管道腐蚀记录','crud_tables/show_pipecorrosion.aspx')">管道腐蚀记录</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('图幅资料','crud_tables/show_image.aspx')">图幅资料</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('加热炉','crud_tables/show_heater.aspx')">加热炉</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('机泵','crud_tables/show_pump.aspx')">机泵</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('罐、容器','crud_tables/show_container.aspx')">罐、容器</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('水井','crud_tables/show_waterWell.aspx')">水井</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('油井','crud_tables/show_oilWell.aspx')">油井</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('注入井','crud_tables/show_injectionWell.aspx')">注入井</a> </li>
                </ul>
            </div>
            <div id="div2" title="仪表管理" iconcls="icon-ok" style="overflow: auto;"  >
                <ul>
                    <li id="meter" style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('仪表信息','ybManage/meter/show_meter.aspx')">仪表基础信息</a> </li>
                    <li id="Instrument" style="list-style-type: none; line-height: 1.8;"><a id="a_Instrument" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('仪表检定','ybManage/metercheck/show_meter_check.aspx')">外送仪表检定</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a id="a6" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('故障维修','ybManage/meterrepair/show_meter_repair.aspx')">故障维修</a> </li>
                    <li id="Li1" style="list-style-type: none; line-height: 1.8;"><a id="a7" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('仪表检定文档','ybManage/test/show_test.aspx')">仪表检定文档</a> </li>
                    <li id="calibrator" style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('计量标准器','ybManage/calibrator/show_calibrator.aspx')">计量标准器</a></li>
               </ul>
            </div>
            <div title="资料提交系统" iconcls="icon-T_ZLTJ" style="overflow: auto;">
                <ul>                 
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('查看进度','datasubmit/viewProgress_6.aspx')">查看进度</a> </li>                  
                </ul>
            </div>
            
             <div title="电子档案存储查询系统" iconcls="icon-T_DZDA" style="overflow: auto;" >
               <ul>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('方案文档','crud_tables/archives/show_plan.aspx')">方案文档</a> </li>
                     <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('设计条件表','crud_tables/archives/show_desiConditionTable.aspx')">设计条件表</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('初设文档','crud_tables/archives/show_initplan.aspx')">初设文档</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('概算文档','crud_tables/archives/show_estimate.aspx')">概算文档</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('施工图文档','crud_tables/archives/show_ConstructionMain.aspx')">施工图文档</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('计划批复文档','crud_tables/archives/show_PlanReply.aspx')">计划批复文档</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('联络变更文档','crud_tables/archives/show_ContactChange.aspx')">联络变更文档</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('施工图文档借阅','crud_tables/archives/show_Construction1.aspx')">施工图文档借阅</a></li>    
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('校对审核记录文档','crud_tables/archives/show_proofcheck.aspx')">校对审核记录文档</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('委托资料','crud_tables/archives/show_ComInfMain.aspx')">委托资料</a></li> 
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('请示文档','crud_tables/archives/show_InstructionDocuments.aspx')">请示文档</a></li> 
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('会议纪要','crud_tables/archives/show_MeetingSummary.aspx')">会议纪要</a></li>                 
                </ul>
            </div>    
              <div id="div1" title="进度计划运行表" iconcls="icon-T_JDJH" style="overflow: auto;"  >
               <ul>
                   <li style="list-style-type: none;line-height: 1.8;">
                    <a id="a_dtz" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('自主设计','plan/planRun_dtz/show_planRun_dtz.aspx')">自主设计</a>  
					<ul>
                        <li style="list-style-type:square;line-height: 1.8;">
						    <a id="A4" runat="server" href="#" style="cursor: pointer;
                                text-decoration: none;" onclick="addTab('自主设计->规划阶段','plan/planRun_dtz/show_planRun_gh.aspx')">规划阶段</a>
					    </li>
					    <li style="list-style-type:square;line-height: 1.8;">
						    <a id="A5" runat="server" href="#" style="cursor: pointer;
                                text-decoration: none;" onclick="addTab('自主设计->设计阶段','plan/planRun_dtz/show_planRun_sj.aspx')">设计阶段</a>
					    </li>
                    </ul>
                    </li>
                    <li id="bdtz" runat="server" style="list-style-type  : none; line-height: 1.8;"><a id="a_bdtz" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('委托设计','plan/planrun_bdtz/show_planrun_bdtz.aspx')">委托设计</a> </li>
                    <li id="zcq" runat="server" style="list-style-type: none; line-height: 1.8;"><a id="a_zcq" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('中长期规划','plan/long_plan/show_long_plan.aspx')">中长期规划</a> </li>
                    <li id="buffer_dtz" runat="server" style="list-style-type: none; line-height: 1.8; display:none;"><a runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('废弃流程库-自主设计','plan/planRun_dtz/Buffer.aspx')">废弃流程库-自主设计</a> </li>
                    <li id="buffer_bdtz" runat="server" style="list-style-type: none; line-height: 1.8; display:none;"><a id="A1" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('废弃流程库-委托设计','plan/planrun_bdtz/Buffer.aspx')">废弃流程库-委托设计</a> </li>
                    <li id="buffer_zcq" runat="server" style="list-style-type: none; line-height: 1.8; display:none;"><a id="A2" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('废弃流程库-中长期规划','plan/long_plan/Buffer.aspx')">废弃流程库-中长期规划</a> </li>
               </ul>
            </div>     
             <div title="测控信息管理" iconcls="icon-ok" style="overflow: auto;">
                <ul>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('测控信息管理','measure/show_measure.aspx')">测控信息管理</a> </li>
                      <li style="list-style-type: none; line-height: 1.8;"><a id="a8" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('故障维修','measurerepair/show_measure_repair.aspx')">故障维修</a> </li>
                </ul>
            </div>
            <div title="考试" iconcls="icon-ok" style="overflow: auto;"  >
               <ul>
                    <li style="list-style-type: none; line-height: 1.8;"><a id="A3" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('录入试题','exam/_prepareExam.aspx')">考试</a> </li>
               </ul>
            </div>   
             <div title="文件共享" iconcls="icon-ok" style="overflow: auto;">
                <ul>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('文件共享','crud_tables/show_share.aspx')">文件共享</a> </li>
                </ul>
            </div>
                         
        </div>
    </div>
    <div region="center">
        <div class="easyui-tabs" id="tab">
            <div title="主页" closable="true" id="t1">
                <br />
                <br />
                <h3>
                    欢迎使用地面工程信息管理平台……</h3>
            </div>
        </div>
    </div>
    <div region="north" style="height: 55px; background-image: url(images/top/backpic.png)">
        <img alt="title" src="images/top/symbol.png" border="0" style="float: left; margin-top: 0px;
            margin-left: 40px; height: 52px;" />
         <span style="float: left; margin-top: 35px;
            margin-left: 40px; "> 当前登录用户：<asp:Label ID="labelname" runat="server" Text=""></asp:Label> 
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <a  href="./login.aspx" style="text-decoration: none;">退出</a>
           
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <a  href="./alterPsw.aspx"  target="_blank" style="text-decoration: none;" >修改密码</a> 
         </span>   
        
        <img alt="title" src="images/top/dmgc.png" border="0" style="float: left; margin-top: 0px;
            margin-left: 140px; height: 52px;" />
        <img alt="title" src="images/top/rightpic.png" border="0" style="float: right; margin-top: 0px;
            margin-right: 10px; height: 52px;" />
        <input id="Organization" value="" type="hidden" runat="server"/>
        <input id="userLevel" value="" type="hidden" runat="server" />
        <input type="hidden" id="num" runat="server"/>
    </div>

     <script type="text/javascript">
         $(function () {
             $("#tab").tabs({ fit: true });
             if ($("#num").val() > '0') {
                 var x1 = "进度计划运行表(" + $("#num").val() + ")";
                 $('#div1').attr('title', x1);
                 $('#div1').attr('data-options', 'selected:true');
                 $('#div1').attr('iconcls', 'icon-tip');
             }
             $('#divTree').addClass('easyui-accordion');
             $('#divTree').accordion({ border: false });

             var userLevel = $('#userLevel').val();
             var organization = $('#Organization').val();
             if (userLevel == '7' && organization == '设计室') {
                 $('#buffer_dtz').css("display", "block");
                 $('#buffer_bdtz').css("display", "block");
                 $('#buffer_zcq').css("display", "block");
             }
//             if (userLevel == '6' && organization == '仪表室')
//                $('#divTree').accordion('remove', 3);           
         });

         function saveurl() {
             $('#form1').form('submit', {
                 async: false,
                 success: function (data) {
                     var number = data.toString();
                     var dtz = "";
                     var bdtz = "";
                     var zcq = "";
                     var tag = 0;
                     for (var i = 0; i < number.length; i++) {
                         if (data[i] != ',') {
                             if (tag == 0)
                                 dtz += data[i];
                             if (tag == 1)
                                 bdtz += data[i];
                             if (tag == 2)
                                 zcq += data[i];
                         }
                         else
                             tag++;
                     }
                     document.getElementById("a_dtz").innerHTML = '自主设计(' + dtz.toString() + ")";
                     document.getElementById("a_bdtz").innerHTML = '委托设计(' + bdtz.toString() + ")";
                     document.getElementById("a_zcq").innerHTML = '中长期规划(' + zcq.toString() + ")";
                     var num = Number(dtz) + Number(bdtz) + Number(zcq);
                     var x1 = "进度计划运行表(" + num.toString() + ")";
                     if (num == 0)
                         $('#divTree').accordion('getPanel', 4).panel({ iconCls: 'icon-ok' });
                     $('#divTree').accordion('getPanel', 4).panel({ title: x1 });
                 }
             });
         } 
    </script>
</form>
</body>
</html>


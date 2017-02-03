<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main_0.aspx.cs" Inherits="main_0" %>
<!--后台管理主操作界面-->
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
    <script type="text/javascript">
         $(function() {
                $("#tab").tabs({ fit: true });
            });
    </script>

</head>
<body class="easyui-layout">
    <div region="west" title="功能模块" style="width: 200px;" split="true">
        <div class="easyui-accordion" style="width: 198px; height: 460px;">
            <div id="DMDN" title="地面档案管理" iconcls="icon-T_DMDA" style="overflow: auto;" selected="false">
                <ul>   
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('房屋信息','crud_tables/show_house.aspx')">房屋信息</a></li>
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
                    <li id="Instrument" style="list-style-type: none; line-height: 1.8;"><a id="a_Instrument" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('仪表检定','ybManage/metercheck/show_meter_check.aspx')">外送仪表检定</a> </li>
               </ul>
            </div>
            <div title="资料提交系统" iconcls="icon-T_ZLTJ" style="overflow: auto;" selected="false">
                <ul>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('发起调查','datasubmit/initSurvey.aspx')">发起调查</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('未通过调查','datasubmit/initSurveyReturnMain.aspx')">未通过调查</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('查看进度','datasubmit/viewProgress.aspx')">查看进度</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('历史调查记录','datasubmit/viewHistorySurvey_SZR.aspx')">历史调查记录</a> </li>               
                </ul>
            </div>
            
            <div title="电子档案存储查询系统" iconcls="icon-T_DZDA" style="overflow: auto;display:none; ">
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
             <input type="hidden" id="userLevel" runat="server"/>

              <div id="div1" title="进度计划运行表" iconcls="icon-T_JDJH" style="overflow: auto;"  >
               <ul>
                   <li style="list-style-type: none;line-height: 1.8;">
                    <a id="a_dtz" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('自主设计','plan/planRun_dtz/show_planRun_dtz.aspx')">自主设计</a>  
					<ul>
                        <li style="list-style-type:square;line-height: 1.8;">
						    <a id="A2" runat="server" href="#" style="cursor: pointer;
                                text-decoration: none;" onclick="addTab('自主设计->项目概要信息','crud_tables/show_project.aspx')">项目概要信息</a>
					    </li>
                        <li style="list-style-type:square;line-height: 1.8;">
						    <a id="A3" runat="server" href="#" style="cursor: pointer;
                                text-decoration: none;" onclick="addTab('自主设计->规划阶段','plan/planRun_dtz/show_planRun_gh.aspx')">规划阶段</a>
					    </li>
					    <li style="list-style-type:square;line-height: 1.8;">
						    <a id="A4" runat="server" href="#" style="cursor: pointer;
                                text-decoration: none;" onclick="addTab('自主设计->设计阶段','plan/planRun_dtz/show_planRun_sj.aspx')">设计阶段</a>
					    </li>
                    </ul>
                    </li>
                    <li id="bdtz" runat="server" style="list-style-type  : none; line-height: 1.8;"><a id="a_bdtz" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('委托设计','plan/planrun_bdtz/show_planrun_bdtz.aspx')">委托设计</a> </li>
                    <li id="zcq" runat="server" style="list-style-type: none; line-height: 1.8;"><a id="a_zcq" runat="server" href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('中长期规划','plan/long_plan/show_long_plan.aspx')">中长期规划</a> </li>
               </ul>
            </div>
            <div  title="后台管理" iconcls="icon-ok" style="overflow: auto;display:none;" selected="false">
                <ul id="managerUL" style="">
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('用户管理','crud_tables/show_user.aspx')">用户管理</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('组织机构管理','crud_tables/show_dept.aspx')">组织机构管理</a> </li>
                  
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
    </div>
    
</body>
</html>


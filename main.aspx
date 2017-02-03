<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="main" %>

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
        <div class="easyui-accordion" style="width: 198px; height: 350px;">
            <div title="地面档案管理" iconcls="icon-T_DMDA" style="overflow: auto;" selected="false">
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
                </ul>
            </div>
            <div title="电子档案存储查询系统" iconcls="icon-T_DZDA" style="overflow: auto;display:none; " selected="false">
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
                        text-decoration: none;" onclick="addTab('施工图文档','crud_tables/archives/show_Construction.aspx')">施工图文档</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('计划批复文档','crud_tables/archives/show_PlanReply.aspx')">计划批复文档</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('联络变更文档','crud_tables/archives/show_ContactChange.aspx')">联络变更文档</a></li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('施工图文档借阅','crud_tables/archives/show_Construction1.aspx')">施工图文档借阅</a></li>    
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('校对审核记录文档','crud_tables/archives/show_proofcheck.aspx')">校对审核记录文档</a></li>                
                </ul>
            </div>
            <%--<div title="资料提交系统" iconcls="icon-ok" style="overflow: auto;" selected="false">
                <ul>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('发起调查','datasubmit/initSurvey.aspx')">发起调查</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('查看进度','datasubmit/viewProgress.aspx')">查看进度</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('历史调查记录','datasubmit/viewHistorySurvey.aspx')">历史调查记录</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                    text-decoration: none;" onclick="addTab('调查审核','datasubmit/checkSurveyMain.aspx')">调查审核</a> </li>
                  
                </ul>
            </div>--%>
            
             <input type="hidden" id="userLevel" runat="server"/>
            <%--<div  title="后台管理" iconcls="icon-ok" style="overflow: auto;display:none;" selected="false">
                <ul id="managerUL" style="">
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('用户管理','crud_tables/show_user.aspx')">用户管理</a> </li>
                    <li style="list-style-type: none; line-height: 1.8;"><a href="#" style="cursor: pointer;
                        text-decoration: none;" onclick="addTab('tabs')">**管理</a> </li>
                  
                </ul>
            </div>--%>
            
           
           
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
    
    
 <script type="text/javascript">
     $(function() {
     
         var userlevel = $('#userLevel').val();
         //alert(userlevel);
         if (userlevel == "2") {
             $('#managerUL').css('display', 'block');
           
         } else if (userlevel == "1") {
         $('#managerUL').css('display', 'none');
        
         }
     })
   </script>
</body>
</html>


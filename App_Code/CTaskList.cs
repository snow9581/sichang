/*
 * 作者：高俊涛
 * 创建时间：2015-05-30
 * 功能：根据计划运行表数据确定当前用户的任务。项目数据存储在DataTable中。
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;
/// <summary>
/// Summary description for CAssignWork
/// </summary>
public class CTaskList
{
    public string userName;//用户名
    public string Organization;//组织机构
    public string userlevel;//用户等级
    public string workItem;//工作任务
    public string workUrl;//工作表单链接
	
    public CTaskList()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /*
     * 假设每个用户对于同一项目同时只能有1项任务。
     */

    public CTaskList(string s1, string s2)
    {
        userlevel = s1;
        Organization = s2;
    }
    private static int JudgeName(string name, string pname,string pnumber)//判断设计室员工是否提交了工作量
    { 
        DB db = new DB();
        string QSentence = "";
        if (pnumber != "" && pnumber != null)
        {
            QSentence = " and pnumber='" + pnumber + "' ";
        }
        string sql1 = "select * from T_COMMISSIONINFORMATION where PName='" + pname + "' " + QSentence + " and (SENDEE='" + name + "' OR CONSIGNER = '" + name + "')";
        if (db.GetCount(sql1) > 0)
        {
            return 1;//接收到委托
        }
        else
            return 0;//没有接收到委托
    }

    public CTaskList getSingleTaskMeterText(System.Data.DataRow projectData)//仪表检定结果
    {
        if (projectData["TEXTER"].ToString() == "")//如果检定员为空
        {
            this.workItem = "等待检定";
        }
        else if (projectData["CHECKER"].ToString() == "")//如果核检员为空
        {
            this.workItem = "等待核检";
        }
        else if (projectData["COMPETENT"].ToString() == "")//如果主管为空
        {
            this.workItem = "等待批阅";
        }
        else
        {
            this.workItem = "检定完毕";
        }
        return this;
    }

    public CTaskList getSingleTask(System.Data.DataRow projectData)
    {
        if (projectData["BLUEGRAPHARRIVALDATE"].ToString() != "" && projectData["SOLUAPPROVEDATE"].ToString() != "" && projectData["PNUMBER"].ToString() != "" && projectData["PLANINVESMENT"].ToString() != "")
        {
            this.workItem = "结束";
        }
        else if (userlevel == "2" && Organization=="规划室") //规划室主任
        {
            if (projectData["PLANFLAG"].ToString() != "2")
            {
                if (projectData["SOLUCOMPDATE_P"].ToString() != "" && projectData["SOLUCOMPDATE_R"].ToString() == "")//如果方案计划完成时间不为空，方案实际完成时间为空，则应该编写方案
                {
                    this.workItem = "等待中";
                    this.workUrl = "init_planRun_dtz.aspx";
                }
                else if (projectData["INSTAPPRSOLUTIONFILE"].ToString() != "" &&(projectData["DESICONDITIONTABLE"].ToString() == "" ||projectData["SOLUAPPROVEDATE"].ToString() == "" || projectData["PNUMBER"].ToString() == "" || projectData["PLANINVESMENT"].ToString() == ""))
                {
                    this.workItem = "上报方案";
                    this.workUrl = "planrun_part.aspx";
                }
                else if (projectData["PLANFLAG"].ToString() == "1" && (projectData["SOLUAPPROVEDATE"].ToString() == "" || projectData["PNUMBER"].ToString() == "" || projectData["PLANINVESMENT"].ToString() == ""))
                {
                    this.workItem = "上报方案";
                    this.workUrl = "write_planrun_free.aspx";
                }
                else
                {
                    this.workItem = "等待中";
                }
            }
            else
                this.workItem = "等待中";
        }
        else if (userlevel == "2" && Organization == "矿区室") //矿区室主任
        {
            //矿区室进行规划
            if (projectData["PLANFLAG"].ToString() == "2")
            {
                if (projectData["SOLUCOMPDATE_P"].ToString() != "" && projectData["SOLUCOMPDATE_R"].ToString() == "")//如果方案计划完成时间不为空，方案实际完成时间为空，则应该编写方案
                {
                    this.workItem = "等待中";
                    this.workUrl = "init_planRun_dtz.aspx";
                }
                else if (projectData["INSTAPPRSOLUTIONFILE"].ToString() != "" && (projectData["DESICONDITIONTABLE"].ToString() == "" || projectData["SOLUAPPROVEDATE"].ToString() == "" || projectData["PNUMBER"].ToString() == "" || projectData["PLANINVESMENT"].ToString() == ""))
                {
                    this.workItem = "上报方案";
                    this.workUrl = "planrun_part.aspx";
                }
                else
                    this.workItem = "等待中";
            }
            //矿区室进行设计
            else if (projectData["PLANFLAG_DESIGN"].ToString() == "1")
            {
                if (projectData["DESICONDITIONTABLE"].ToString() != "" && projectData["PNUMBER"].ToString() != "" && projectData["FINALSOLUTIONFILE"].ToString() != "" && projectData["DESICHIEF"].ToString() == "" && projectData["MAJORPROOFREADER"].ToString() == "")
                {
                    this.workItem = "指定负责人";
                    this.workUrl = "DesignatedDesignPerson.aspx";
                }
                else if ((projectData["DESICHIEF"].ToString() != "" || projectData["MAJORPROOFREADER"].ToString() != "") && projectData["MAJORDELEGATEDATE_R"].ToString() == "")
                {
                    this.workItem = "等待中";
                    this.workUrl = "DesignatedDesignPerson.aspx";
                }
                else if (projectData["INITIALDESISUBMITDATE_R"].ToString() != "" && (projectData["DESIAPPROVALARRIVALFILENUMBER"].ToString() == "" || projectData["DESIAPPRFILE"].ToString() == ""))
                {
                    this.workItem = "批复下达";
                    this.workUrl = "DesiApprovalArrival.aspx";
                }
                else if (projectData["DESIAPPROVALARRIVALFILENUMBER"].ToString() != "" && projectData["DESIAPPRFILE"].ToString() != "" && projectData["BUDGETADJUSTDATE_P"].ToString() == "")
                {
                    this.workItem = "等待中";
                    this.workUrl = "DesiApprovalArrival.aspx";
                }
                else if (projectData["BUDGETADJUSTDATE_R"].ToString() != "" && (projectData["PLANARRIVALFILENUMBER"].ToString() == "" || projectData["PLANARRIVALFILE"].ToString() == ""))
                {
                    this.workItem = "计划下达";
                    this.workUrl = "PlanArrival.aspx";
                }
                else if (projectData["PLANARRIVALFILENUMBER"].ToString() != "" && projectData["PLANARRIVALFILE"].ToString() != "" && projectData["WHITEGRAPHCHECKDATE_R"].ToString() == "")
                {
                    this.workItem = "等待中";
                    this.workUrl = "PlanArrival.aspx";
                }
                else
                    this.workItem = "等待中";
            }
            else
                this.workItem = "等待中";
        }
        else if (userName == projectData["SOLUCHIEF"].ToString())//方案负责人
        {
            if (projectData["SOLUCOMPDATE_P"].ToString() != "" && projectData["SOLUCOMPDATE_R"].ToString() == "")//如果方案计划完成时间不为空，方案实际完成时间为空，则应该编写方案
            {
                this.workItem = "编写方案";
                this.workUrl = "writePlan.aspx";
            }
            else if (projectData["CHECKSTATE"].ToString() == "0")
            {
                this.workItem = "重写方案";
                this.workUrl = "planReturn.aspx";
            }
            else if (projectData["CHECKSTATE"].ToString() == "")//所审还没进行之前，可以修改之前上传的表单
            {
                this.workItem = "等待中";
                this.workUrl = "writePlan.aspx";
            }
            else
            {
                this.workItem = "等待中";
            }
        }
        else if (userlevel == "4" && Organization == "规划室")   //如果所审计划时间确定、方案实际完成时间确定且实际所审时间还未确定，则应该进行实际所审。
        {
            if (projectData["PLANFLAG"].ToString() != "2")
            {
                if (projectData["CHECKSTATE"].ToString() == "" && projectData["SOLUCOMPDATE_R"].ToString() != "" && projectData["INSTCHECKDATE_P"].ToString() != "" && (projectData["INSTCHECKDATE_R"].ToString() == "" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == ""))
                {
                    this.workItem = "审查方案";
                    this.workUrl = "CheckPlanRun_dtz.aspx";
                }
                else if (projectData["CHECKSTATE"].ToString() == "0" && projectData["SOLUCOMPDATE_R"].ToString() != "" && projectData["INSTCHECKDATE_P"].ToString() != "" && projectData["INSTAPPRSOLUTIONFILE"].ToString() == "")
                {
                    this.workItem = "退回方案";
                }
                else if (projectData["CHECKSTATE"].ToString() == "1" && projectData["SOLUCOMPDATE_R"].ToString() != "" && projectData["INSTCHECKDATE_P"].ToString() != "" && projectData["INSTAPPRSOLUTIONFILE"].ToString() == "")
                {
                    this.workItem = "重新审查方案";
                    this.workUrl = "CheckPlanRun_dtz.aspx";
                }
                else
                    this.workItem = "等待中";
            }
            else
                this.workItem = "等待中";
        }
        else if (userlevel == "4" && Organization == "矿区室")   //如果所审计划时间确定、方案实际完成时间确定且实际所审时间还未确定，则应该进行实际所审。
        {
            if (projectData["PLANFLAG"].ToString() == "2")
            {
                if (projectData["CHECKSTATE"].ToString() == "" && projectData["SOLUCOMPDATE_R"].ToString() != "" && projectData["INSTCHECKDATE_P"].ToString() != "" && (projectData["INSTCHECKDATE_R"].ToString() == "" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == ""))
                {
                    this.workItem = "审查方案";
                    this.workUrl = "CheckPlanRun_dtz.aspx";
                }
                else if (projectData["CHECKSTATE"].ToString() == "0" && projectData["SOLUCOMPDATE_R"].ToString() != "" && projectData["INSTCHECKDATE_P"].ToString() != "" && projectData["INSTAPPRSOLUTIONFILE"].ToString() == "")
                {
                    this.workItem = "退回方案";
                }
                else if (projectData["CHECKSTATE"].ToString() == "1" && projectData["SOLUCOMPDATE_R"].ToString() != "" && projectData["INSTCHECKDATE_P"].ToString() != "" && projectData["INSTAPPRSOLUTIONFILE"].ToString() == "")
                {
                    this.workItem = "重新审查方案";
                    this.workUrl = "CheckPlanRun_dtz.aspx";
                }
                else
                    this.workItem = "等待中";
            }
            else
                this.workItem = "等待中";
        }
        else if (userlevel == "2" && Organization == "设计室")   //设计室主任
        {
            if (projectData["PLANFLAG_DESIGN"].ToString() == "0")
            {
                //if (projectData["PLANFLAG"].ToString() == "1" && (projectData["SOLUCOMPDATE_P"].ToString() == "" || projectData["DESICHIEF"].ToString() == ""))//如果方案计划完成时间不为空，方案实际完成时间为空，则应该编写方案
                //{
                //    this.workItem = "发起流程";
                //    this.workUrl = "init_planRun_free.aspx";
                //}
                //if (projectData["PLANFLAG"].ToString() == "1" && projectData["WORKLOADSUBMITDATE_P"].ToString() != "" && projectData["DESICHIEF"].ToString() != "" && projectData["SOLUCOMPDATE_R"].ToString() == "")//如果方案计划完成时间不为空，方案实际完成时间为空，则应该编写方案
                //{
                //    this.workItem = "等待中";
                //    this.workUrl = "init_planRun_free.aspx";
                //}
                if ((projectData["PLANFLAG"].ToString() == "0" || projectData["PLANFLAG"].ToString() == "2") && projectData["FINALSOLUTIONFILE"].ToString() != "" && projectData["PNUMBER"].ToString() != "" && projectData["DESICONDITIONTABLE"].ToString() != "" && (projectData["DESICHIEF"].ToString() == "" || projectData["MAJORPROOFREADER"].ToString() == ""))
                {
                    this.workItem = "指定负责人";
                    this.workUrl = "DesignatedDesignPerson.aspx";
                }
                else if ((projectData["PLANFLAG"].ToString() == "0" || projectData["PLANFLAG"].ToString() == "2") && projectData["DESICHIEF"].ToString() != "" && projectData["MAJORPROOFREADER"].ToString() != "" && projectData["WORKLOADSUBMITDATE_R"].ToString() == "")
                {
                    this.workItem = "等待中";
                    this.workUrl = "DesignatedDesignPerson.aspx";
                }
                else if (projectData["INITIALDESISUBMITDATE_R"].ToString() != "" && (projectData["DESIAPPROVALARRIVALFILENUMBER"].ToString() == "" || projectData["DESIAPPRFILE"].ToString() == ""))
                {
                    this.workItem = "批复下达";
                    this.workUrl = "DesiApprovalArrival.aspx";
                }
                else if (projectData["DESIAPPROVALARRIVALFILENUMBER"].ToString() != "" && projectData["DESIAPPRFILE"].ToString() != "" && projectData["BUDGETADJUSTDATE_P"].ToString() == "")
                {
                    this.workItem = "等待中";
                    this.workUrl = "DesiApprovalArrival.aspx";
                }
                else if (projectData["BUDGETADJUSTDATE_R"].ToString() != "" && (projectData["PLANARRIVALFILENUMBER"].ToString() == "" || projectData["PLANARRIVALFILE"].ToString() == ""))
                {
                    this.workItem = "计划下达";
                    this.workUrl = "PlanArrival.aspx";
                }
                else if (projectData["PLANARRIVALFILENUMBER"].ToString() != "" && projectData["PLANARRIVALFILE"].ToString() != "" && projectData["WHITEGRAPHCHECKDATE_R"].ToString() == "")
                {
                    this.workItem = "等待中";
                    this.workUrl = "PlanArrival.aspx";
                }
                else
                    this.workItem = "等待中";
            }
            else
                this.workItem = "等待中";
        }
        else if (userlevel == "2" && Organization == "综合室")  //综合室主任
        {
            if (projectData["PLANFLAG"].ToString() == "1" && projectData["BUDGETCHIEF"].ToString() == "")
            {
                this.workItem = "指定概算负责人";
                this.workUrl = "DesignatedBudgetPerson.aspx";
            }
            else if (projectData["FINALSOLUTIONFILE"].ToString() != "" && projectData["PNUMBER"].ToString() != "" && projectData["DESICONDITIONTABLE"].ToString() != "" && projectData["BUDGETCHIEF"].ToString() == "")
            {
                this.workItem = "指定概算负责人";
                this.workUrl = "DesignatedBudgetPerson.aspx";
            }
            else if (projectData["BUDGETCHIEF"].ToString() != ""&& projectData["BUDGETCOMPDATE_R"].ToString() == "")
            {
                this.workItem = "等待中";
                this.workUrl = "DesignatedBudgetPerson.aspx";
            }
            else if (projectData["BUDGETCOMPDATE_R"].ToString() != "" && projectData["INITIALDESISUBMITDATE_R"].ToString() == "")
            {
                this.workItem = "初设上报";
                this.workUrl = "InitialDesiSubmit.aspx";
            }
            else if (projectData["INITIALDESISUBMITDATE_R"].ToString() != "" && projectData["DESIAPPROVALARRIVALFILENUMBER"].ToString() == "")
            {
                this.workItem = "等待中";
                this.workUrl = "InitialDesiSubmit.aspx";
            }
            else if (projectData["DESIAPPROVALARRIVALFILENUMBER"].ToString() != "" && projectData["DESIAPPRFILE"].ToString() != "" && projectData["BUDGETADJUSTDATE_P"].ToString() == "")
            {
                this.workItem = "概算计划调整时间";
                this.workUrl = "BudgetAjustDate_P.aspx";
            }
            else if (projectData["BUDGETADJUSTDATE_P"].ToString() != "" && projectData["BUDGETADJUSTDATE_R"].ToString() == "")
            {
                this.workItem = "概算调整";
                this.workUrl = "BudgetAdjust.aspx";
            }
            else
                this.workItem = "等待中";
        }
        else if (userName == projectData["DESICHIEF"].ToString())//设计负责人      
        {
            //if(projectData["WORKLOADSUBMITDATE_R"].ToString() == ""&& projectData["PLANFLAG"].ToString() == "1")
            //{
            //    this.workItem = "初设工程量提交";
            //    this.workUrl = "MajorDelegateData_free.aspx";
            //}
            if (projectData["DESICHIEF"].ToString() != "" && projectData["WORKLOADSUBMITDATE_R"].ToString() == "")
            {
                this.workItem = "委托资料和工程量";
                this.workUrl = "MainOfCommissionAndWorkload.aspx";
            }
            else if (projectData["PLANARRIVALFILENUMBER"].ToString() != "" && (projectData["WHITEGRAPHCHECKDATE_R"].ToString() == "" || projectData["BLUEGRAPHDOCUMENT_R"].ToString() == "" || projectData["SECONDCOMMISSIONDATE"].ToString() == ""))
            {
                this.workItem = "施工白图校审和蓝图";
                this.workUrl = "MainOfWhiteGraphAndBlueGraph.aspx";
            }
            else if (projectData["BLUEGRAPHDOCUMENT_R"].ToString() != "" && projectData["WHITEGRAPHCHECKDATE_R"].ToString() != "" && projectData["SECONDCOMMISSIONDATE"].ToString() != "" && projectData["BLUEGRAPHARRIVALDATE"].ToString() == "")
            {
                this.workItem = "等待中";
                this.workUrl = "MainOfWhiteGraphAndBlueGraph.aspx";
            }
            else
                this.workItem = "等待中";
        }
        else if (userName == projectData["BUDGETCHIEF"].ToString() )//综合室概算负责人      
        {
            if(projectData["BUDGETCOMPDATE_R"].ToString() == "")
            {
                this.workItem = "编写概算文档";
                this.workUrl = "DraftBudgetFile.aspx";
            }
            else if (projectData["BUDGETCOMPDATE_R"].ToString() != "" && projectData["INITIALDESISUBMITDATE_R"].ToString() == "")
            {
                this.workItem = "等待中";
                this.workUrl = "DraftBudgetFile.aspx";
            }
            else
                this.workItem = "等待中";
        }
        else if (userlevel == "6" && (Organization == "设计室" || Organization == "矿区室"))//设计室各专业    
        {
            if (JudgeName(userName, projectData["PNAME"].ToString(), projectData["PNUMBER"].ToString()) == 1 && projectData["WORKLOADSUBMITDATE_R"].ToString() == "")
            {
                this.workItem = "工程量提交 ";
                this.workUrl = "SubmitWorkLoad.aspx";
            }
            else if (JudgeName(userName, projectData["PNAME"].ToString(), projectData["PNUMBER"].ToString()) == 1 && projectData["DESIAPPROVALARRIVALDATE"].ToString() != "" && projectData["DESIAPPROVALARRIVALFILENUMBER"].ToString() != "" && projectData["SECONDCOMMISSIONDATE"].ToString() == "")
            {
                this.workItem = "提交二次委托 ";
                this.workUrl = "ShowSecComFile.aspx";
            }
            else if (JudgeName(userName, projectData["PNAME"].ToString(), projectData["PNUMBER"].ToString()) == 1 && projectData["WHITEGRAPHCHECKDATE_R"].ToString() != "" && projectData["BLUEGRAPHDOCUMENT_R"].ToString() == "")
            {
                this.workItem = "上传蓝图 ";
                this.workUrl = "SubmitBlueGraph.aspx";
            }
            else
                this.workItem = "等待中";
        }
        else if (userlevel == "8" && Organization == "综合室")//综合室图纸管理人    
        {
            if (projectData["BLUEGRAPHDOCUMENT_R"].ToString() != "" && projectData["BLUEGRAPHARRIVALDATE"].ToString() == "")
            {
                this.workItem = "下发蓝图，记录时间";
                this.workUrl = "BlueGraphArrival.aspx";
            }
            else
            {
                this.workItem = "等待中";
            } 
        }
        else
        {
            this.workItem = "等待中";
        }               
        return this;
    }
    public CTaskList getSingleTask_longplan(System.Data.DataRow projectData)
    {
        if (Organization == "规划室" && userlevel == "6" && projectData["SOLUCHIEF"].ToString() == userName)
        {
            if (projectData["SOLUCOMPDATE_R"].ToString() == "" || projectData["INSTCHECKDATE_R"].ToString() == "" || projectData["FACTCHECKDATE_R"].ToString() == "" || projectData["DRAFTSOLUTIONFILE"].ToString() == "" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == "" || projectData["FACTAPPRSOLUTIONFILE"].ToString() == "" || projectData["DRAFTSOLUTIONFILE"].ToString() == "#" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == "#" || projectData["FACTAPPRSOLUTIONFILE"].ToString() == "#")
            {
                this.workItem = "进行中";
                this.workUrl = "long_plan2.aspx";
            }
            else if (projectData["SOLUSUBMITDATE"].ToString() != "" && projectData["SOLUCHECKDATE"].ToString() != "" && projectData["SOLUADVICEREPLYDATE"].ToString() != "" && projectData["SOLUAPPROVEDATE"].ToString() != "" && projectData["FINALSOLUTIONFILE"].ToString() != "" && projectData["FINALSOLUTIONFILE"].ToString() != "#")
            {
                this.workItem = "结束";
                this.workUrl = "long_plan2.aspx";
            }
            else
            {
                this.workItem = "等待中";
                this.workUrl = "long_plan2.aspx";
            }
        }
        else if (Organization == "规划室" && userlevel == "2")
        {
            if (projectData["SOLUSUBMITDATE"].ToString() == "" || projectData["SOLUCHECKDATE"].ToString() == "" || projectData["SOLUADVICEREPLYDATE"].ToString() == "" || projectData["SOLUAPPROVEDATE"].ToString() == "" || projectData["FINALSOLUTIONFILE"].ToString() == "" || projectData["FINALSOLUTIONFILE"].ToString() == "#")
            {
                if (projectData["SOLUCOMPDATE_R"].ToString() == "" || projectData["INSTCHECKDATE_R"].ToString() == "" || projectData["FACTCHECKDATE_R"].ToString() == "" || projectData["DRAFTSOLUTIONFILE"].ToString() == "" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == "" || projectData["FACTAPPRSOLUTIONFILE"].ToString() == "" || projectData["DRAFTSOLUTIONFILE"].ToString() == "#" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == "#" || projectData["FACTAPPRSOLUTIONFILE"].ToString() == "#")
                {
                    this.workItem = "等待中";
                }
                else
                {
                    this.workItem = "进行中";
                    this.workUrl = "long_plan1.aspx";
                }
            }
            else
            {
                this.workItem = "结束";
                this.workUrl = "long_plan1.aspx";
            }
        }
        else if (Organization == "矿区室" && userlevel == "6" && projectData["SOLUCHIEF"].ToString() == userName)
        {
            if (projectData["SOLUCOMPDATE_R"].ToString() == "" || projectData["INSTCHECKDATE_R"].ToString() == "" || projectData["FACTCHECKDATE_R"].ToString() == "" || projectData["DRAFTSOLUTIONFILE"].ToString() == "" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == "" || projectData["FACTAPPRSOLUTIONFILE"].ToString() == "" || projectData["DRAFTSOLUTIONFILE"].ToString() == "#" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == "#" || projectData["FACTAPPRSOLUTIONFILE"].ToString() == "#")
            {
                this.workItem = "进行中";
                this.workUrl = "long_plan2.aspx";
            }
            else if (projectData["SOLUSUBMITDATE"].ToString() != "" && projectData["SOLUCHECKDATE"].ToString() != "" && projectData["SOLUADVICEREPLYDATE"].ToString() != "" && projectData["SOLUAPPROVEDATE"].ToString() != "" && projectData["FINALSOLUTIONFILE"].ToString() != "" && projectData["FINALSOLUTIONFILE"].ToString() != "#")
            {
                this.workItem = "结束";
                this.workUrl = "long_plan2.aspx";
            }
            else
            {
                this.workItem = "等待中";
                this.workUrl = "long_plan2.aspx";
            }
        }
        else if (Organization == "矿区室" && userlevel == "2")
        {
            if (projectData["SOLUSUBMITDATE"].ToString() == "" || projectData["SOLUCHECKDATE"].ToString() == "" || projectData["SOLUADVICEREPLYDATE"].ToString() == "" || projectData["SOLUAPPROVEDATE"].ToString() == "" || projectData["FINALSOLUTIONFILE"].ToString() == "" || projectData["FINALSOLUTIONFILE"].ToString() == "#")
            {
                if (projectData["SOLUCOMPDATE_R"].ToString() == "" || projectData["INSTCHECKDATE_R"].ToString() == "" || projectData["FACTCHECKDATE_R"].ToString() == "" || projectData["DRAFTSOLUTIONFILE"].ToString() == "" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == "" || projectData["FACTAPPRSOLUTIONFILE"].ToString() == "" || projectData["DRAFTSOLUTIONFILE"].ToString() == "#" || projectData["INSTAPPRSOLUTIONFILE"].ToString() == "#" || projectData["FACTAPPRSOLUTIONFILE"].ToString() == "#")
                {
                    this.workItem = "等待中";
                }
                else
                {
                    this.workItem = "进行中";
                    this.workUrl = "long_plan1.aspx";
                }
            }
            else
            {
                this.workItem = "结束";
                this.workUrl = "long_plan1.aspx";
            }
        }
        else
        {
            if (projectData["SOLUSUBMITDATE"].ToString() != "" && projectData["SOLUCHECKDATE"].ToString() != "" && projectData["SOLUADVICEREPLYDATE"].ToString() != "" && projectData["SOLUAPPROVEDATE"].ToString() != "" && projectData["FINALSOLUTIONFILE"].ToString() != "" && projectData["FINALSOLUTIONFILE"].ToString() != "#")
            {
                this.workItem = "结束";
            }
            else
            {
                this.workItem = "等待中";
            }
        }
        return this;
    }
    public CTaskList getSingleTask_bdtz(System.Data.DataRow projectData)
    {
        if (projectData["BLUEGRAPHARRIVALDATE"].ToString() != "")
        {
            this.workItem = "结束";
        }
        else if (userlevel == "2" && Organization == "规划室")
        {
            if (projectData["YCZLSubmitDate"].ToString() == "" || projectData["CYZLSubmitDate"].ToString() == "" || projectData["DMZLDelegateDate"].ToString() == "")
            {
                this.workItem = "进行中";
                this.workUrl = "ghs0_Datasubmit.aspx";
            }
            else if (projectData["SoluCompDate_P"].ToString() == "" || projectData["SoluCheckDate_P"].ToString() == "")
            {
                this.workItem = "进行中";
                this.workUrl = "ghs4_Datasubmit.aspx";
            }
            else if (projectData["SOLUCOMPDATE_R"].ToString() == "")
            {
                this.workItem = "进行中";
                this.workUrl = "ghs1_Datasubmit.aspx";
            }
            else if (projectData["SOLUCHECKDATE_R"].ToString() == "")
            {
                this.workItem = "进行中";
                this.workUrl = "ghs2_Datasubmit.aspx";
            }
            else if (projectData["DESISUBMITDATE"].ToString() == "")
            {
                this.workItem = "进行中";
                this.workUrl = "ghs3_Datasubmit.aspx";
            }
            else
                this.workItem = "等待中";
        }
        else if (userlevel == "2" && Organization == "设计室")
        {
            if (projectData["INITIALDESISUBMITDATE_P"].ToString() == "" || projectData["BLUEGRAPHDOCUMENT_P"].ToString() == "")
            {
                this.workItem = "进行中";
                this.workUrl = " DesignGraphDate.aspx";
            }
            else if (projectData["INITIALDESISUBMITDATE_R"].ToString() == "")
            {
                this.workItem = "进行中";
                this.workUrl = " DesignFile.aspx";
            }
            else if (projectData["BLUEGRAPHDOCUMENT_R"].ToString() == "")
            {
                this.workItem = "进行中";
                this.workUrl = " GraphFile.aspx";
            }
            else
                this.workItem = "等待中";
        }
        else if (userlevel == "8" && Organization == "综合室")//综合室图纸管理人    
        {
            if (projectData["BLUEGRAPHDOCUMENT_R"].ToString() != "" && projectData["BLUEGRAPHARRIVALDATE"].ToString() == "")
            {
                this.workItem = "下发蓝图，记录时间";
                this.workUrl = "BlueGraphArrival.aspx";
            }
            else
            {
                this.workItem = "等待中";
            }
        }
        else
        {
            this.workItem = "等待中";
        }
        return this;
    }
}

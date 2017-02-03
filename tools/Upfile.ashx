<%@ WebHandler Language="C#" Class="Upfile" %>

using System;
using System.Web;
using System.IO;
using System.Data.OleDb;
using System.Data;
using System.Collections.Generic;

public class Upfile : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        int number = context.Request.Files.Count;
        int total = 0;
        int count = 0;
        string filename = "";
        string path = "";
        try
        {
            for (int i = 0; i < number; i++)
            {
                //获取文件
                HttpPostedFile file = context.Request.Files[i];
                //随机生成文件名
                filename = i.ToString();
                path = System.Web.HttpContext.Current.Server.MapPath(filename);
                while (File.Exists(path))
                {
                    int x = int.Parse(filename);
                    filename = (x + 1).ToString();
                    path = System.Web.HttpContext.Current.Server.MapPath(filename);
                }
                //保存文件至服务器
                path += ".xls";
                file.SaveAs(path);
                //解析
                Object[] result = GetTable(path);
                DataSet ds = null;
                if ((int)result[1] == 0)
                {
                    File.Delete(path);
                    context.Response.Write("<script>alert('上传失败');</script>");
                    context.Response.End();
                    return;
                }
                ds = (DataSet)result[0];
                //表名
                string table_name = "";
                //序列名
                string seq_name = "";
                //列字段
                List<string> table_columns = new List<string>();
                //数据段类型
                List<string> table_type = new List<string>();
                //需要从SESSION中获取的数据
                List<string> session_data = new List<string>();
                //需要当前时间的字段
                List<string> nowtime = new List<string>();
                //字段限制
                List<string> limit_columns = new List<string>();
                List<string>[] limit = new List<string>[10];
                //获取配置信息
                bool IsColumnsFinish = false;
                for (int m = 0; m < ds.Tables[0].Columns.Count; m++)
                {
                    if (ds.Tables[0].Columns[m].ColumnName.ToString() == "NULL")
                        IsColumnsFinish = true;
                    if (!IsColumnsFinish)
                    {
                        //提取列字段
                        table_columns.Add(ds.Tables[0].Columns[m].ColumnName.ToString());
                        //提取数据段类型
                        table_type.Add(ds.Tables[0].Rows[0][m].ToString());
                    }
                    else
                    {
                        //提取需要从SESSION中获取的数据
                        if (ds.Tables[0].Columns[m].ColumnName.ToString().Contains( "SESSION"))
                            session_data.Add(ds.Tables[0].Rows[0][m].ToString());
                        //提取表名
                        if (ds.Tables[0].Columns[m].ColumnName.ToString() == "TABLE_NAME")
                            table_name = ds.Tables[0].Rows[0][m].ToString();
                        //提取序列名
                        if (ds.Tables[0].Columns[m].ColumnName.ToString() == "SEQ_NAME")
                            seq_name = ds.Tables[0].Rows[0][m].ToString();
                        //提取需要获取当前时间的字段
                        if (ds.Tables[0].Columns[m].ColumnName.ToString() == "NOW")
                            nowtime.Add(ds.Tables[0].Rows[0][m].ToString());
                        //提取字段限制信息
                        if (ds.Tables[0].Columns[m].ColumnName.ToString().Contains("LIMIT_"))
                        {
                            limit_columns.Add(ds.Tables[0].Columns[m].ColumnName.ToString().Substring(6, ds.Tables[0].Columns[m].ColumnName.ToString().Length - 6));
                            limit[limit_columns.Count-1] = new List<string>(ds.Tables[0].Rows[0][m].ToString().Split(','));
                        }
                    }
                }
                if (table_name == "" || seq_name == "" || table_type.Count == 0 || table_columns.Count == 0)
                {
                    File.Delete(path);
                    context.Response.Write("<script>alert('模板损坏，请重新下载');</script>");
                    context.Response.End();
                    return;
                }
                //插入数据库
                DB db = new DB();
                total = ds.Tables[0].Rows.Count - 2;
                //
                for (int k = 2; k < ds.Tables[0].Rows.Count; k++)
                {
                    bool IsDataRight = true;
                    //获取ID
                    string id = db.GetDataTable("select " + seq_name + ".nextval from dual").Rows[0][0].ToString();
                    //SQL
                    string sql = "insert into " + table_name + " ";
                    string columns = "";
                    string values = "";
                    //拼接基本SQL
                    for (int m = 0; m < table_columns.Count; m++)
                    {
                        //检测字段限制
                        int index = Exist_int(table_columns[m], limit_columns);
                        if (index != -1)
                            if (!Exist(ds.Tables[0].Rows[k][m].ToString(), limit[index]))
                                IsDataRight = false;
                        //编辑SQL
                        if (ds.Tables[0].Rows[k][m].ToString() != "")
                        {
                            columns += table_columns[m] + ",";
                            if (table_type[m] == "date")
                                values += "to_date('" + ds.Tables[0].Rows[k][m].ToString() + "','yyyy-mm-dd'),";
                            else if (table_type[m] == "number")
                                values += ds.Tables[0].Rows[k][m].ToString() + ",";
                            else if (table_type[m] == "varchar")
                                values += "'" + ds.Tables[0].Rows[k][m].ToString() + "',";
                        }
                    }
                    //session信息拼入SQL
                    if (session_data.Count != 0)
                    {
                        for (int l = 0; l < session_data.Count; l++)
                        {
                            columns += session_data[l] + ",";
                            values += "'" + context.Session[session_data[l]] + "',";
                        }
                    }
                    //当前时间字段拼入SQL
                    if (nowtime.Count != 0)
                    {
                        for (int l = 0; l < nowtime.Count; l++)
                        {
                            columns += nowtime[l] + ",";
                            values += "to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),";
                        }
                    }
                    columns += "id";
                    values += id;
                    sql += "(" + columns + ") values (" + values + ")";
                    if (IsDataRight)
                        if (db.ExecuteSQL(sql))
                            count++;
                }
                //删除文件
                File.Delete(path);
            }
        }
        catch (Exception e)
        {
            SClog.insert("Upfile ", e.ToString());
            if (File.Exists(path))
                File.Delete(path);
        }
        context.Response.Write("<script>alert('上传了" + number + "个文档，共检测到" + total + "条数据，成功插入了" + count + "条数据');</script>");
        context.Response.End();
        return;

    }
    public bool Exist(string x,List<string> list)
    {
        for (int i = 0; i < list.Count; i++)
            if (x == list[i])
                return true;
        return false;
    }
    public int Exist_int(string x, List<string> list)
    {
        for (int i = 0; i < list.Count; i++)
            if (x == list[i])
                return i;
        return -1;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

    public Object[] GetTable(String path)
    {
        //输入EXCEL文件路径，输出DATATABLE
        //初始化
        
        OleDbConnection conn = null;
        OleDbDataAdapter oa = null;
        DataTable dt = null;
        int result = 1;
        ////////////////////////////////////
        //建立连接字
//        string str = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + path + ";" + ";Extended Properties=\"Excel 8.0;HDR=YES;IMEX=1\"";
        string str = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + path + ";" + ";Extended Properties=\"Excel 12.0;HDR=YES;IMEX=1\"";

        ////////////////////////////////////
        //sql语句意义不明
        string sql_F = "select * from [{0}]";
        DataSet ds = new DataSet();
        try
        {
            conn = new OleDbConnection(str);//建立链接
            conn.Open();

            string SheetName = "";//工作表的名字
            dt = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

            oa = new OleDbDataAdapter();
            for (int i = 0; i < dt.Rows.Count; i++)//循环每一个工作表
            {
                SheetName = (string)dt.Rows[i]["TABLE_NAME"];
                if (SheetName.Contains("$") && !SheetName.Replace("'", "").EndsWith("$"))
                {
                    continue;
                }
                oa.SelectCommand = new OleDbCommand(String.Format(sql_F, SheetName), conn);
                DataSet dsItem = new DataSet();
                oa.Fill(dsItem, SheetName);
                ds.Tables.Add(dsItem.Tables[0].Copy());
            }
            conn.Close();
            oa.Dispose();
            conn.Dispose();
        }
        catch(Exception e)
        {
            SClog.insert("Upfile ", e.ToString());
            result = 0;
        }
        Object[] x = new Object[2] { (Object)ds, (Object)result };
        return x;
    }
}
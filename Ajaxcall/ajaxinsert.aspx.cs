using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
namespace Ajaxcall
{
    public partial class ajaxinsert : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            //{
                BindGridviewData();
                //Label1.Text = Session["name"].ToString();
            //}
               
        }
        protected void BindGridviewData()
        {
            using (SqlConnection con = new SqlConnection("Data Source=dilshad;Integrated Security=true;Initial Catalog=chauhan"))
            {
                using (SqlCommand cmd = new SqlCommand("select * from sampleinfo", con))
                {
                    con.Open();
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    con.Close();
                    gvDetails.DataSource = ds;
                    gvDetails.DataBind();
                }
            }
        }
        [WebMethod]
        public static string InsertData(string username, string subj, string desc)
        {
            string msg = string.Empty;
            using (SqlConnection con = new SqlConnection("Data Source=dilshad;Integrated Security=true;Initial Catalog=chauhan"))
            {
                using (SqlCommand cmd = new SqlCommand("insert into sampleinfo(name,subject,description) VALUES(@name,@subject,@desc)", con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@name", username);
                    cmd.Parameters.AddWithValue("@subject", subj);
                    cmd.Parameters.AddWithValue("@desc", desc);
                    int i = cmd.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                        msg = "true";
                    }
                    else
                    {
                        msg = "false";
                    }
                }
            }
            return msg;
        }
        #region Insert sencond method start
        [WebMethod]
        public static void SaveUser(Employee objEmployee) //Insert data in database  
        {
            //https://www.c-sharpcorner.com/UploadFile/145c93/crud-operation-using-ajax-part-1/
            using (var con = new SqlConnection("Data Source = dilshad; Integrated Security = true; Initial Catalog = chauhan"))
            {
                using (var cmd = new SqlCommand("insert into sampleinfo(name,subject,description) VALUES(@name,@subject,@desc)", con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@name", objEmployee.name);
                    cmd.Parameters.AddWithValue("@subject", objEmployee.subject);
                    cmd.Parameters.AddWithValue("@desc", objEmployee.description);
                   
                    //cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }
        public class Employee
        {
            public int subjectid;
            public string name;
            public string subject;
            public string description;
           
         
        }
        #endregion
        #region bind data into table
        [WebMethod]
        public static Employee[] GetData() //Show the details of the data after insert in HTML Table  
        {
            //https://www.c-sharpcorner.com/UploadFile/145c93/crud-operation-using-ajax-part-1/
            var details = new List<Employee>();
            DataTable TableData = new DataTable();
            using (var con = new SqlConnection("Data Source = dilshad; Integrated Security = true; Initial Catalog = chauhan"))
            {
                const string query = "select * from sampleinfo order by subjectid desc";
                using (var cmd = new SqlCommand(query, con))
                {
                    using (var sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        TableData.Clear();
                        sda.Fill(TableData);
                        details.AddRange(from DataRow dtrow in TableData.Rows
                                         select new Employee
                                         {
                                             subjectid = Convert.ToInt32(dtrow["subjectid"]),
                                             name = dtrow["name"].ToString(),
                                             subject = dtrow["subject"].ToString(),
                                             description = dtrow["description"].ToString(),
                                            
                                         });
                    }
                }
            }
            return details.ToArray();
        }
        #endregion
    }
}
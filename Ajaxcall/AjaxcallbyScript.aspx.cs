using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Configuration;
namespace Ajaxcall
{
    public partial class AjaxcallbyScript : System.Web.UI.Page
    {
        static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["chauhanConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            //https://www.languagetechfunda.com/csharp/jquery-ajax-crud-select-insert-edit-update-delete-using-jquery-ajax-asp-net-c
            //http://www.codingfusion.com/Post/Jquery-JSON-Add-Edit-Update-Delete-in-Asp-Net
            // <script src="Appjsscript.js" type="text/javascript" lang="ja"></script>
        }
        [WebMethod]
        public static int InsertData(string name, string email, string age) //public static void InsertData(string name, string email, string age)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Sp_Jsoncrud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ind", 1);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@age", age);
            int i= cmd.ExecuteNonQuery();
            con.Close();
            return i;
        }
        [WebMethod]
        public static string GetEmpData()
        {
            con.Open();
            string _data = "";
            SqlCommand cmd = new SqlCommand("Sp_Jsoncrud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ind", 5);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                _data = JsonConvert.SerializeObject(ds.Tables[0]);
            }
            return _data;
        }
        [WebMethod]
        public static string BindRecordToEdit(int id)
        {
            //https://www.languagetechfunda.com/csharp/jquery-ajax-crud-select-insert-edit-update-delete-using-jquery-ajax-asp-net-c
            string _data = "";
            con.Open();
            SqlCommand cmd = new SqlCommand("Sp_Jsoncrud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ind", 2);
            cmd.Parameters.AddWithValue("@id", id);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                _data = JsonConvert.SerializeObject(ds.Tables[0]);
            }
            return _data;
        }
        [WebMethod]
        public static int UpdateData(int id, string name, int age, string email)
        {

            con.Open();
            SqlCommand cmd = new SqlCommand("Sp_Jsoncrud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ind", 3);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@age", age);
            cmd.Parameters.AddWithValue("@email", email);
            int i=cmd.ExecuteNonQuery();
            con.Close();
            return i;
        }
        [WebMethod]
        public static int Delete(int id)  // public static void Delete(int id)  you can also write this type of code note:this is code is not a  better way.
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Sp_Jsoncrud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ind", 4);
            cmd.Parameters.AddWithValue("@id", id);
            int i=cmd.ExecuteNonQuery();
            con.Close();
            return i;
        }
    }
}
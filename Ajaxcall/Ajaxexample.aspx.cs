using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Net;
namespace Ajaxcall
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // Label1.Text = Session["name"].ToString();
        }
        [System.Web.Services.WebMethod]
        public static string GetCurrentTime(string name)
        {
            return "Hello " + name + Environment.NewLine + "The Current Time is: "
                + DateTime.Now.ToString();
            
        }
        protected void btnsignin_Click(object sender, EventArgs e)
        {
            string UserName = "";
            string conn_string = "Data Source=DILSHAD;Initial Catalog=CHAUHAN;Integrated Security=True";
            SqlConnection con = new SqlConnection(conn_string);
            con.Open();
            string query = "select * from tbllogin where loginid= '" +txt_email.Value + "' and password='" +txt_psw.Value + "'";
            SqlCommand y = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(y);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                UserName = dt.Rows[0]["username"].ToString();
                Session["name"] = UserName;
                Response.Redirect("~/Fileupload.aspx");
                Session.RemoveAll();
               
            }
            else
            {
                Response.Redirect("Errorpage.aspx");
            }
            Response.Redirect("~/popup.aspx");
        }
        [WebMethod]
        
        public static string login( string username,string password)
        {
            string msg = string.Empty;
            string UserName = "";
            string conn_string = "Data Source=DILSHAD;Initial Catalog=CHAUHAN;Integrated Security=True";
            SqlConnection con = new SqlConnection(conn_string);
            con.Open();
            string query = "select * from tbllogin where loginid= '" + username + "' and password='" + password + "'";
            SqlCommand cmd = new SqlCommand(query, con);
            //int i=cmd.ExecuteNonQuery();
            //if(i==1)
            //{
            //    msg = "True";
            //}
            //else
            //{
            //    msg = "false";
            //}
            //return msg;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                //UserName = dt.Rows[0]["username"].ToString();
                //Session["name"] = UserName;
                ///Response.Redirect("~/ajaxinsert.aspx");
                //Session.RemoveAll();
                msg = "True";
                
            }
            else
            {
                msg = "false";
                //Response.Redirect("ajaxinsert.aspx");
            }
            return msg;
        }

    }
}
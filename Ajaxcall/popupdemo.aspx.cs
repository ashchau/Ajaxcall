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
    public partial class popupdemo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnlogin_Click(object sender, EventArgs e)
        {
            string UserName = "";
            string conn_string = "Data Source=DILSHAD;Initial Catalog=CHAUHAN;Integrated Security=True";
            SqlConnection con = new SqlConnection(conn_string);
            con.Open();
            string query = "select * from tbllogin where loginid= '" + txt_email.Value + "' and password='" + txt_psw.Value + "'";
           // string query = "select * from tbllogin where loginid= '" + txtname.Text + "' and password='" + txtpassword.Text + "'";
            SqlCommand y = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(y);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                UserName = dt.Rows[0]["username"].ToString();
                Session["name"] = UserName;
                Response.Redirect("~/Ajaxexample.aspx");
                Session.RemoveAll();

            }
            else
            {
                Response.Redirect("Errorpage.aspx");
            }

        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string UserName = "";
            string conn_string = "Data Source=DILSHAD;Initial Catalog=CHAUHAN;Integrated Security=True";
            SqlConnection con = new SqlConnection(conn_string);
            con.Open();
            string query = "select * from tbllogin where loginid= '" + txt_name.Text + "' and password='" + txt_password.Text + "'";
            SqlCommand y = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(y);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                UserName = dt.Rows[0]["username"].ToString();
                Session["name"] = UserName;
                Response.Redirect("~/ajaxinsert.aspx");
                Session.RemoveAll();

            }
            else
            {
                Response.Redirect("Errorpage.aspx");
            }
        }

        protected void btnnewlogin_Click(object sender, EventArgs e)
        {
            string UserName = "";
            string conn_string = "Data Source=DILSHAD;Initial Catalog=CHAUHAN;Integrated Security=True";
            SqlConnection con = new SqlConnection(conn_string);
            con.Open();
            string query = "select * from tbllogin where loginid= '" + txt_name.Text + "' and password='" + txt_password.Text + "'";
           // string query = "select * from tbllogin where loginid= '" + Text1.Value + "' and password='" + Password1.Value + "'";
            SqlCommand y = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(y);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                UserName = dt.Rows[0]["username"].ToString();
                Session["name"] = UserName;
                Response.Redirect("~/ajaxinsert.aspx");
                Session.RemoveAll();

            }
            else
            {
                Response.Redirect("Errorpage.aspx");
            }
        }
    }
}
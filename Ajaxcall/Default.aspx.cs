using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Serialization;
using System.Data.Entity;
using Newtonsoft.Json;
using System.Configuration;
namespace Ajaxcall
{
    public partial class Default : System.Web.UI.Page
    {
        static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["chauhanConnectionString"].ConnectionString);
       // static SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            //getData();
        }
        //using System.Web.Services;
        //==== Method to save data into database.
        [WebMethod]
        public static int saveData(string name, string email, string age)
        {
            try
            {
                int status = 0;
                using (chauhanEntities context = new chauhanEntities())
                {
                    New_Student obj = new New_Student();
                    obj.Name = name;
                    obj.Email = email;
                    obj.Age = age;
                    context.New_Student.Add(obj);
                    context.SaveChanges();
                    status = obj.Id;
                }
                return status;
               
            }
            catch
            {
                return -1;
            }
        }
        //==== Method to fetch data from database.
        //using System.Web.Script.Serialization;
        [WebMethod]
        public static string getData()
        {
            //http://www.codingfusion.com/Post/Jquery-JSON-Add-Edit-Update-Delete-in-Asp-Net
            string data = string.Empty;
            try
            {
                using (chauhanEntities context = new chauhanEntities())
                {
                    var obj = (from r in context.New_Student select r).ToList();
                    
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    data = serializer.Serialize(obj);
                }
                
                return data;
            }
            catch
            {
                return data;

            }
        }
        //==== Method to get values of selected record and bind in input controls for update.
        [WebMethod]
        public static string bindRecordToEdit(int id)
        {
            string data = string.Empty;
            try
            {

                using (chauhanEntities context = new chauhanEntities())
                {
                    var obj = context.New_Student.FirstOrDefault(r => r.Id == id);
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    data = serializer.Serialize(obj);
                }
                return data;
            }
            catch
            {
                return data;
            }
        }
        // Method to Edit data Second method
        //Edit WebMethod is used to Edit data from tblEmployee Table.

        [WebMethod]
        public static string Edit(int Id)
        {
            //https://www.languagetechfunda.com/csharp/jquery-ajax-crud-select-insert-edit-update-delete-using-jquery-ajax-asp-net-c
            string _data = "";
            con.Open();
            SqlCommand cmd = new SqlCommand("Sp_Jsoncrud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ind", 2);
            cmd.Parameters.AddWithValue("@id", Id);
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
        //==== Method to update data.
        [WebMethod]
        public static int updateData(string name, string email, string age, int id)
        {
            try
            {
                int status = 0;
                using (chauhanEntities context = new chauhanEntities())
                {
                    New_Student obj = context.New_Student.FirstOrDefault(r => r.Id == id);
                    obj.Name = name;
                    obj.Email = email;
                    obj.Age = age;
                    context.SaveChanges();
                    status = obj.Id;
                }
                return status;
            }
            catch
            {
                return -1;
            }
        }
        //===Second method to update record
        //Update WebMethod accept Id, Name, Address, Age values. Based on this Id update data in the tblEmployee Table.

        [WebMethod]
        public static void Update(int ID, string name, int age, string email)
        {

            con.Open();
            SqlCommand cmd = new SqlCommand("Sp_Jsoncrud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ind", 3);
            cmd.Parameters.AddWithValue("@id", ID);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@age", age);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.ExecuteNonQuery();
            con.Close();

        }
        //==== Method to Delete a record.
        [WebMethod]
        public static void deleteRecord(int id)
        {
            try
            {
                //using (chauhanEntities context = new chauhanEntities())
                //{
                //    var obj = context.New_Student.FirstOrDefault(r => r.Id == id);
                //    context.New_Student.DeleteObject(obj);

                //    context.SaveChanges();
                //} //second method in place of DeleteObject as Remove
                using (var context = new chauhanEntities())
                {
                    var temp = (from x in context.New_Student where x.Id == id select x).FirstOrDefault();
                    context.New_Student.Remove(temp);
                    context.SaveChanges();
                }
            }
            catch
            {
            }
        }
        //Delete WebMethod is used to delete data from the tblEmployee Table.


        [WebMethod]
        public static void Delete(int Id)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Sp_Jsoncrud", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ind", 4);
            cmd.Parameters.AddWithValue("@id", Id);
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BREACH_TECHNOVAS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtEmail == null || txtPassword == null)
            {
                Response.Write("<script>alert('TextBox not found! Check Login.aspx.');</script>");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email=@Email AND PasswordHash=@Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();

                if (count == 1)
                {
                    query = "SELECT Id FROM Users WHERE Email=@Email AND PasswordHash=@Password";
                    cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                    conn.Open();
                    int userid = Convert.ToInt32(cmd.ExecuteScalar());
                    conn.Close();

                    Session["uname"] = txtEmail.Text;
                    Session["uid"]= userid;

                    FormsAuthentication.SetAuthCookie(txtEmail.Text, false);
                    Response.Redirect("Transactions.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Invalid email or password');</script>");
                }
            }

        }
    }
}
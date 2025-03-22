using Microsoft.ML;
using System;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.ML.Data;
using System.Data.Entity.Core.Metadata.Edm;
using Microsoft.Ajax.Utilities;

namespace BREACH_TECHNOVAS
{
    public partial class Home : System.Web.UI.Page
    {
        private static MLContext mlContext = new MLContext();
        private static PredictionEngine<TransactionData, FraudPrediction> predictionEngine;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMLModel();
            
            if (Session["uname"]==null)
            {
                Response.Redirect("login.aspx");
            }
            else { 
                lblWelcome.Text = "Welcome " + Session["uname"];
            }
            }
        }
        private void LoadMLModel()
        {
            var modelPath = Server.MapPath("~/App_Data/FraudDetectionModel.zip");

            if (System.IO.File.Exists(modelPath))
            {
                var trainedModel = mlContext.Model.Load(modelPath, out var schema);
                predictionEngine = mlContext.Model.CreatePredictionEngine<TransactionData, FraudPrediction>(trainedModel);
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
        
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Response.Redirect("Logout.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
                float amount = float.Parse(txtAmount.Text);
            string location = txtLocation.Text;
            string deviceType = txtDeviceType.Text;

            var input = new TransactionData
            {
                Amount = amount,
                Location = (location),
                DeviceType = deviceType,
                TransactionTime = DateTime.Now.ToString()
            };

             bool isFraud = FraudDetectionTraining.PredictFraud(input);
                //bool isFraud = result.PredictedLabel;

                SaveTransaction(amount, location, deviceType, isFraud);
                lblResult.Text = isFraud ? "⚠️ Fraudulent Transaction Detected!" : "✅ Transaction is Safe.";
                GridView1.DataBind();

        }
        private void SaveTransaction(float amount, string location, string deviceType, bool isFraud)
        {
            string connString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\MyASM\\BREACH_TECHNOVAS\\BREACH_TECHNOVAS\\App_Data\\Database1.mdf;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO Transactions (UserId, Amount, Location, DeviceType, IsFraud) VALUES ('" + Session["uid"] + "','" + txtAmount.Text + "','" + txtLocation.Text + "','" + txtDeviceType.Text + "','" + Convert.ToString(isFraud) + "')";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                //cmd.Parameters.AddWithValue("@UserId", Session["uid"]);
                //cmd.Parameters.AddWithValue("@Amount", amount);
                //cmd.Parameters.AddWithValue("@Location", location);
                //cmd.Parameters.AddWithValue("@DeviceType", deviceType);
                //cmd.Parameters.AddWithValue("@IsFraud", isFraud ? 1 : 0);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}
public class TransactionData
{
    [LoadColumn(0)] public float Amount { get; set; }
    [LoadColumn(1)] public string Location { get; set; }
    [LoadColumn(2)] public string DeviceType { get; set; }
}

public class FraudPrediction : TransactionData
{
    [ColumnName("PredictedLabel")] public bool PredictedLabel { get; set; }
}

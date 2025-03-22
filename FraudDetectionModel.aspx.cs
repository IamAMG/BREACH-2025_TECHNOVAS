using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Linq;
using Microsoft.ML.OnnxRuntime;
using Microsoft.ML.OnnxRuntime.Tensors;

namespace BREACH_TECHNOVAS
{
    public partial class FraudDetectionModel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                var modelPath = HttpContext.Current.Server.MapPath("~/App_Data/knn_model.onnx");
                var session = new InferenceSession(modelPath);



                //var session = new InferenceSession(@"D:\MyASM\BREACH_TECHNOVAS\BREACH_TECHNOVAS\App_Data\knn_model.onnx");

                var input = new DenseTensor<float>(new float[] { 0.1f, 1.2f, -0.5f, 2.3f }, new[] { 1, 4 });
                var inputs = new NamedOnnxValue[] { NamedOnnxValue.CreateFromTensor("input", input) };

                using (var results = session.Run(inputs))
                {
                    var output = results.First().AsTensor<float>().ToArray();
                    Console.WriteLine($"Predicted Class: {output[0]}");
                    Label1.Text = output.ToString();
                }
            }
            catch (Exception ex) {
                Label1.Text = ex.Message;    
            }
        }
    }
}
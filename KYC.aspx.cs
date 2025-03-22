using System;
using System.IO;
using Tesseract;


namespace BREACH_TECHNOVAS
{
    public partial class OCR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                try
                {
                    // Save uploaded file to temporary location
                    string filePath = Server.MapPath("~/Uploads/") + FileUpload1.FileName;
                    FileUpload1.SaveAs(filePath);

                    // Specify the Tesseract tessdata path
                    string tessDataPath = @"C:\Program Files\Tesseract-OCR\tessdata";

                    // Perform OCR
                    string extractedText = ExtractTextFromImage(filePath, tessDataPath);

                    // Display extracted text
                    lblExtractedText.Text = extractedText;
                }
                catch (Exception ex)
                {
                    lblExtractedText.Text = "Error: " + ex.Message;
                }
            }
            else
            {
                lblExtractedText.Text = "Please upload an image file.";
            }
        }

        private string ExtractTextFromImage(string imagePath, string tessDataPath)
        {
            try
            {
                using (var engine = new TesseractEngine(tessDataPath, "eng", EngineMode.Default))
                {
                    using (var img = Pix.LoadFromFile(imagePath))
                    {
                        using (var page = engine.Process(img))
                        {
                            return page.GetText();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "OCR Error: " + ex.Message;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string base64String = Request.Form["imageData"];

            if (!string.IsNullOrEmpty(base64String))
            {
                try
                {
                    // Remove Base64 metadata
                    base64String = base64String.Replace("data:image/png;base64,", "");

                    // Convert Base64 string to byte array
                    byte[] imageBytes = Convert.FromBase64String(base64String);

                    // Save the image
                    string filePath = Server.MapPath("~/Uploads/") + "CapturedImage.png";
                    File.WriteAllBytes(filePath, imageBytes);

                    Response.Write("<script>alert('Image saved successfully!');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('No image captured!');</script>");
            }
        }
    }
}
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KYC.aspx.cs" Inherits="BREACH_TECHNOVAS.OCR" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>OCR Image Upload</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<style>
    body {
        background-color: #f8f9fa;
    }
    .sidebar {
        height: 100vh;
        background: #343a40;
        padding-top: 20px;
    }
    .sidebar a {
        color: white;
        text-decoration: none;
        padding: 10px 20px;
        display: block;
        transition: 0.3s;
    }
    .sidebar a:hover {
        background: #495057;
    }
    .content {
        padding: 30px;
    }
    .card {
        max-width: 600px;
        margin: auto;
    }
</style>
</head>
<body>
    <!-- Bootstrap JS -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <form id="form1" runat="server">
             <div class="container-fluid">
<div class="row">
        <!-- Sidebar -->
     <div class="col-md-3 col-lg-2 sidebar">
         <h4 class="text-center text-white">Dashboard</h4>
         <a href="Home.aspx">🏠 Home</a>
             <a href="Login.aspx">🏠 Login</a>
         <a href="Transactions.aspx">📋 Transactions</a>
         <a href="KYC.aspx">⚙️ KYC</a>
         <a href="Logout.aspx">🔓 Logout</a>
              <a href="FraudDetectionModel.aspx">⚙️ Fraud Detection</a>
     </div>
        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 content">
            <div class="card shadow p-4">
                <div class="mb-3">
            <h4>Upload Image for KYC</h4>
            </div>
                 <div class="mb-3">
                    <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="btnUpload" runat="server" Text="Extract Text" OnClick="btnUpload_Click" />
            &nbsp;<br /><br />
                     </div>
                 <div class="mb-3">
            <h4>Extracted Text:</h4>
            <asp:Label ID="lblExtractedText" runat="server" ForeColor="Blue"></asp:Label>
        </div>
                 <div class="mb-3">
            <h4>Webcam Capture</h4>

            <!-- Webcam Video -->
            <video id="video" width="400" height="300" autoplay></video>
            <br />
            <button type="button" onclick="captureImage()">Capture Image</button>

            <!-- Captured Image -->
            <canvas id="canvas" width="400" height="300" style="display: none;"></canvas>
            <br />
            <img id="capturedImage" style="border: 1px solid #000; width: 400px; height: 300px;" />

            <!-- Hidden Input for Sending Image Data -->
            <input type="hidden" id="imageData" name="imageData" />
                     </div>
                 <div class="mb-3">
            <br /><br />
            <asp:Button ID="btnWebCamCapture" runat="server" Text="Upload Image" OnClick="Button1_Click" />
        </div>
                </div>
    </form>
    <script>
        // Access the webcam
        navigator.mediaDevices.getUserMedia({ video: true })
            .then(function (stream) {
                document.getElementById("video").srcObject = stream;
            })
            .catch(function (error) {
                console.log("Error accessing camera: ", error);
            });

        // Capture image from webcam
        function captureImage() {
            var canvas = document.getElementById("canvas");
            var video = document.getElementById("video");
            var context = canvas.getContext("2d");

            context.drawImage(video, 0, 0, 400, 300);

            var imageData = canvas.toDataURL("image/png"); // Convert to Base64
            document.getElementById("capturedImage").src = imageData;
            document.getElementById("imageData").value = imageData;
        }
    </script>

</body>
</html>

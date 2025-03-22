<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="BREACH_TECHNOVAS.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
     
    <form runat="server">
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

                    <h2>You have been logged out.</h2>
                    <a href="Login.aspx">Login Again</a>
                    </div>
                </div>
            </div>
    </div>
</form>
        </div>
   <body>
</html>

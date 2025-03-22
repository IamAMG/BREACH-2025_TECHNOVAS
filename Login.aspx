<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BREACH_TECHNOVAS.Login" %>

<!DOCTYPE html>
<html>
<head>
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
                    <h2>Login</h2>
                </div>
                <div class="mb-3">
                    <asp:Label runat="server" Text="Email:"></asp:Label>
                </div>
                 <div class="mb-3">
                    <asp:TextBox ID="txtEmail" runat="server" Placeholder="Enter your email"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="*"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <asp:Label runat="server" Text="Password:"></asp:Label>
                </div>
                <div class="mb-3">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Enter your password"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="*"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
                </div>
        </div>
        </div>
                </div>
</div>
      </form>
        
</body>
</html>

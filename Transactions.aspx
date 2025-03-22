<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="BREACH_TECHNOVAS.Home" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Transaction Entry</title>
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
<body>   <!-- Bootstrap JS -->
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
                    <h2>
                        <asp:Label ID="lblWelcome" runat="server" Text="Welcome"></asp:Label>
                    </h2>
                </div>
                <div class="mb-3">
            <h2>Enter Transaction Details</h2>
                    </div>
                <div class="mb-3">
            <asp:Label ID="lblAmount" runat="server" Text="Amount: " />
            <asp:TextBox ID="txtAmount" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAmount" ErrorMessage="*"></asp:RequiredFieldValidator>
            </div>
                <div class="mb-3">

            <asp:Label ID="lblLocation" runat="server" Text="Location: " />
            <asp:TextBox ID="txtLocation" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLocation" ErrorMessage="*"></asp:RequiredFieldValidator>
            </div>
                <div class="mb-3">
            <asp:Label ID="lblDeviceType" runat="server" Text="Device Type: " />
            <asp:TextBox ID="txtDeviceType" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDeviceType" ErrorMessage="*"></asp:RequiredFieldValidator>
            </div>
                <div class="mb-3">
                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Save" />
                    &nbsp;<asp:Button ID="btnLogout" runat="server" OnClick="btnLogout_Click" Text="Log Out" />
            <br /><br />
                    </div>
                <div class="mb-3">
            <asp:Label ID="lblResult" runat="server" ForeColor="Red" />
            </div>
                <div class="mb-3">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="TransactionId" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="TransactionId" HeaderText="TransactionId" InsertVisible="False" ReadOnly="True" SortExpression="TransactionId" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                    <asp:BoundField DataField="TransactionDate" HeaderText="TransactionDate" SortExpression="TransactionDate" />
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                    <asp:BoundField DataField="DeviceType" HeaderText="DeviceType" SortExpression="DeviceType" />
                    <asp:CheckBoxField DataField="IsFraud" HeaderText="IsFraud" SortExpression="IsFraud" />
                </Columns>
                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                <RowStyle BackColor="White" ForeColor="#003399" />
                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                <SortedAscendingCellStyle BackColor="#EDF6F6" />
                <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                <SortedDescendingCellStyle BackColor="#D6DFDF" />
                <SortedDescendingHeaderStyle BackColor="#002876" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Transactions] WHERE [TransactionId] = @TransactionId" InsertCommand="INSERT INTO [Transactions] ([UserId], [Amount], [TransactionDate], [Location], [DeviceType], [IsFraud]) VALUES (@UserId, @Amount, @TransactionDate, @Location, @DeviceType, @IsFraud)" SelectCommand="SELECT * FROM [Transactions] WHERE ([UserId] = @UserId)" UpdateCommand="UPDATE [Transactions] SET [UserId] = @UserId, [Amount] = @Amount, [TransactionDate] = @TransactionDate, [Location] = @Location, [DeviceType] = @DeviceType, [IsFraud] = @IsFraud WHERE [TransactionId] = @TransactionId">
                <DeleteParameters>
                    <asp:Parameter Name="TransactionId" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UserId" Type="Int32" />
                    <asp:Parameter Name="Amount" Type="Decimal" />
                    <asp:Parameter Name="TransactionDate" Type="DateTime" />
                    <asp:Parameter Name="Location" Type="String" />
                    <asp:Parameter Name="DeviceType" Type="String" />
                    <asp:Parameter Name="IsFraud" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="UserId" SessionField="uid" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UserId" Type="Int32" />
                    <asp:Parameter Name="Amount" Type="Decimal" />
                    <asp:Parameter Name="TransactionDate" Type="DateTime" />
                    <asp:Parameter Name="Location" Type="String" />
                    <asp:Parameter Name="DeviceType" Type="String" />
                    <asp:Parameter Name="IsFraud" Type="Boolean" />
                    <asp:Parameter Name="TransactionId" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
                    </div>
        </div>
    </form>
</body>
</html>

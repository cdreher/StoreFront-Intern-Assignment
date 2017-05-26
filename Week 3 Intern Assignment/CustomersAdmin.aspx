<%@ Page Title="CustomersAdmin Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomersAdmin.aspx.cs" Inherits="Week_3_Intern_Assignment.CustomersAdmin" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <div class="jumbotron" style="border-style: double; border-width: 5px; border-color: navy; font-family: 'Agency FB'; font-variant: normal; text-transform: inherit;">
        <div class="row" style="height:10px">
            <a href="Default.aspx"><img alt="Back" src="golf%20ball.png" style="width: 50px; height: 50px; float:left" /></a>
            <a href="CustomerAdminDetails.aspx"><img alt="Next" src="golf%20ball%20(2).png" style="width: 50px; height: 50px; float:right" /> </a>
        </div>
        <h1 style="font-size: 40pt"><strong style="font-family: 'Agency FB'; color: #000080;">Golf Shop - CustomersAdmin</strong></h1>
        <p style="font-size: x-large; color: #4166F5;">This page allows you, the users, to see all current users...AND to even add new users!</p>
        <div class="row" style="height:10px">
            <img alt="" src="golfer.gif" style="width: 90px; height: 120px; float:right; margin-right: 100px; margin-top:-58px" />

        </div>
    </div>
        
    <div class ="row">
        <div class="col-md-6">
            <asp:GridView ID="CurrentUsersGrid" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="UserID" DataSourceID="SqlDataSource1" PageSize="50" BorderColor="#4166F5" BorderStyle="Dashed" BorderWidth="5px" Caption="All Current Users:" CaptionAlign="Top" Font-Names="Agency FB" RowHeaderColumn="UserID" CellPadding="5" CellSpacing="2" HorizontalAlign="Center">
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFormatString="CustomerAdminDetails.aspx?UserID={0}" Text="Edit" DataNavigateUrlFields="UserID"/>
                <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" ReadOnly="True" SortExpression="UserID" />
                <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
                <asp:BoundField DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" />
            </Columns>
            </asp:GridView>
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" SelectCommand="spGetUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </div>
        <div class ="col-md-6">
            <asp:DetailsView ID="AddUserDetailView" runat="server" DataSourceID="SqlDataSource2" Height="50px" Width="150px" AutoGenerateRows="False" BorderColor="#4166F5" BorderStyle="Dashed" BorderWidth="5px" Caption="Add New User:" CaptionAlign="Top" DataKeyNames="UserID" DefaultMode="Insert" Font-Bold="True" Font-Names="Agency FB" Font-Strikeout="False" HorizontalAlign="Center" CellPadding="5" CellSpacing="2" OnItemInserted ="AddUserDetailView_OnInserted">
                <Fields>
                    <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" ReadOnly="True" SortExpression="UserID" />
                    <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress" />
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" InsertCommand="spAddUser" InsertCommandType="StoredProcedure" SelectCommand="spGetUsers" SelectCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:Parameter Name="UserName" Type="String" />
                    <asp:Parameter Name="EmailAddress" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
       
    </div>
        
          
</asp:Content>

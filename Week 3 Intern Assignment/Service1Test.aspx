<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Service1Test.aspx.cs" Inherits="Week_3_Intern_Assignment.Service1Test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <div class="jumbotron" style="border-style: dashed; border-width: 5px; border-color: #4166F5 #4166f5 #4166F5 #4166f5; font-family: 'Agency FB'; font-variant: normal; text-transform: inherit;">
       <div class="row" style="height:10px">
        </div> 
       <h1 style="font-size: 40pt"><strong style="font-family: 'Agency FB'; color: #000080;">Service1Test</strong></h1>
    </div>
        
    <div class ="row">
            
        
        <asp:Label ID="Label1" runat="server" Text="Search Products"></asp:Label>
        <asp:TextBox ID="searchText" runat="server"></asp:TextBox>
        <asp:Button ID="SearchProducts" runat="server" Text="Search" OnClick="SearchProducts_Click" />
            
        
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
            
        
    </div>
    <div class ="row">
            
        
        <asp:Label ID="Label2" runat="server" Text="Product Details"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Product Details" />
            
        
    </div>
        
          
</asp:Content>

<%@ Page Title="ProductsAdmin Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductsAdmin.aspx.cs" Inherits="Week_3_Intern_Assignment.ProductsAdmin" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <div class="jumbotron" style="border-style: dashed; border-width: 5px; border-color: #4166F5 #4166f5 #4166F5 #4166f5; font-family: 'Agency FB'; font-variant: normal; text-transform: inherit;">
       <div class="row" style="height:10px">
           <a href="CustomerAdminDetails.aspx"><img alt="Back" src="golf%20ball.png" style="width: 50px; height: 50px; float:left" /></a>
            <a href="ProductAdminDetails.aspx"><img alt="Next" src="golf%20ball%20(2).png" style="width: 50px; height: 50px; float:right" /> </a>
        </div> 
       <h1 style="font-size: 40pt"><strong style="font-family: 'Agency FB'; color: #000080;">Golf Shop - ProductsAdmin</strong></h1>
        <p style="font-size: x-large; color: #4166F5;">This page displays the list of products in stock. It also gives you the ability to add a product to our shelves!</p>
    </div>
        
    <div class ="row">
        <div class="col-md-6">
            <asp:GridView ID="ProductGrid" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="Navy" BorderStyle="Double" BorderWidth="5px" Caption="List of Products:" CaptionAlign="Top" CellPadding="5" CellSpacing="2" DataKeyNames="ProductID" DataSourceID="SqlDataSource7" Font-Names="Agency FB" HorizontalAlign="Center" PageSize="50">
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="ProductID" DataNavigateUrlFormatString="ProductAdminDetails.aspx?ProductID={0}" Text="Edit" />
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
                    <asp:CheckBoxField DataField="isPublished" HeaderText="isPublished" SortExpression="isPublished" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                </Columns>
             </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" SelectCommand="spGetProducts" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="PublishedOnly" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
           
            
            
           
            
        </div>
        <div class ="col-md-6">
            <asp:DetailsView ID="AddProductDetailView" runat="server" AutoGenerateRows="False" DataKeyNames="ProductID" DataSourceID="SqlDataSource8" DefaultMode="Insert" Height="50px" Width="125px" BorderColor="Navy" BorderStyle="Double" BorderWidth="5px" Caption="Add Product:" CaptionAlign="Top" CellPadding="5" CellSpacing="2" Font-Bold="True" Font-Names="Agency FB" HorizontalAlign="Center" OnItemInserted ="AddProductDetailView_OnInsert">
                <Fields>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
                    <asp:BoundField DataField="ProdDescription" HeaderText="Description" SortExpression="ProdDescription" />
                    <asp:CheckBoxField DataField="isPublished" HeaderText="isPublished" SortExpression="isPublished" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" InsertCommand="spAddProduct" InsertCommandType="StoredProcedure" SelectCommand="spGetProducts" SelectCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:Parameter Name="ProductName" Type="String" />
                    <asp:Parameter Name="ProdDescription" Type="String" />
                    <asp:Parameter Name="isPublished" Type="Boolean" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="PublishedOnly" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        
       
   
       
    </div>
        
          
</asp:Content>

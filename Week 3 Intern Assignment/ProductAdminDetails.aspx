<%@ Page Title="ProductAdminDetails Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductAdminDetails.aspx.cs" Inherits="Week_3_Intern_Assignment.ProductAdminDetails" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="border-style: dashed; border-width: 5px; border-color: #4166f5 #4166F5 #4166f5 #4166f5; font-family: 'Agency FB'; font-variant: normal; text-transform: inherit; color: #4166F5;">
        <div class="row" style="height: 10px">
        </div>
        <h1 style="font-size: 40pt"><strong style="font-family: 'Agency FB'; color: #000080;">Golf Shop - ProductAdminDetails</strong></h1>
        <p style="font-size: x-large">This page allows&nbsp;you to see details of the selected user! If any portion of this page seems blank, go back to the<em> ProductsAdmin</em> Page and click<em> &quot;Edit&quot;</em> next to any user!</p>
        <p style="font-size: x-large">1) See the selected product from the <em>ProductsAdmin</em> Page.</p>
        <p style="font-size: x-large">2) Update the selected product by either changing its <em>Product Name, Description, isPublished or Price </em>properties<em>. </em></p>
        <p style="font-size: x-large">3) Delete the selected product by clicking <em>&quot;Delete&quot; </em>under the<em> Delete Product </em>table.</p>
        <p>&nbsp;</p>
    </div>

    <div class="row">
        <div class="col-md-4">

            <asp:DetailsView ID="ProductDetails" runat="server" AutoGenerateRows="False" BorderColor="Navy" BorderStyle="Double" BorderWidth="5px" Caption="Details for selected product:" CaptionAlign="Top" CellPadding="5" CellSpacing="2" DataKeyNames="ProductID" DataSourceID="SqlDataSource9" Font-Bold="False" Font-Names="Agency FB" Height="50px" HorizontalAlign="Center" Width="125px">
                <Fields>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                    <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
                    <asp:BoundField DataField="ProdDescription" HeaderText="ProdDescription" SortExpression="ProdDescription" />
                    <asp:CheckBoxField DataField="isPublished" HeaderText="isPublished" SortExpression="isPublished" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                    <asp:ImageField DataImageUrlField="ImageFile" HeaderText="ImageFile" SortExpression="ImageFile">
                        <ControlStyle Height="100px" Width="100px" />
                    </asp:ImageField>
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" SelectCommand="spGetProduct" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
        <div class="col-md-4">
            <div class="row">
                <asp:DetailsView ID="UpdateProductDetailView" runat="server" AutoGenerateRows="False" DataKeyNames="ProductID" DataSourceID="SqlDataSource10" DefaultMode="Edit" Height="50px" Width="125px" BorderColor="Navy" BorderStyle="Double" BorderWidth="5px" Caption="Update Product:" CaptionAlign="Top" CellPadding="5" CellSpacing="2" Font-Bold="True" Font-Names="Agency FB" HorizontalAlign="Center" OnItemUpdated="UpdateProductDetailView_OnUpdate">
                    <Fields>
                        <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
                        <asp:BoundField DataField="ProdDescription" HeaderText="Description" SortExpression="ProdDescription" />
                        <asp:CheckBoxField DataField="isPublished" HeaderText="isPublished" SortExpression="isPublished" />
                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                        <asp:CommandField ShowEditButton="True" />
                    </Fields>
                </asp:DetailsView>

                <asp:SqlDataSource ID="SqlDataSource10" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" SelectCommand="spGetProduct" SelectCommandType="StoredProcedure" UpdateCommand="spUpdateProduct" UpdateCommandType="StoredProcedure" OnSelecting="SqlDataSource10_Selecting">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ProductID" Type="Int32" />
                        <asp:Parameter Name="ProductName" Type="String" />
                        <asp:Parameter Name="ProdDescription" Type="String" />
                        <asp:Parameter Name="isPublished" Type="Boolean" />
                        <asp:Parameter Name="Price" Type="Decimal" />
                    </UpdateParameters>
                </asp:SqlDataSource>

            </div>
            <div class="row">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Agency FB" Text="Update ImageFile:" Font-Size="Large"></asp:Label>
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:Button ID="uploadImageButton" runat="server" OnClick="uploadImageButton_Click" Text="Upload" />
            </div>







        </div>
        <div class="col-md-4">
            <asp:DetailsView ID="DeleteProductDetailView" runat="server" AutoGenerateRows="False" BorderColor="Navy" BorderStyle="Double" BorderWidth="5px" Caption="Delete Product:" CaptionAlign="Top" CellPadding="5" CellSpacing="2" DataKeyNames="ProductID" DataSourceID="SqlDataSource11" Font-Bold="True" Font-Names="Agency FB" Height="50px" HorizontalAlign="Center" Width="125px" OnItemDeleted="DeleteProductDetailView_OnDelete">
                <Fields>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False" ReadOnly="True" SortExpression="ProductID" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource11" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" DeleteCommand="spDeleteProduct" DeleteCommandType="StoredProcedure" SelectCommand="spGetProduct" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="ProductID" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>



    </div>


</asp:Content>

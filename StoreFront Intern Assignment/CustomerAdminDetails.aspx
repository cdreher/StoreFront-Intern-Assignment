<%@ Page Title="CustomerAdminDetails Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerAdminDetails.aspx.cs" Inherits="Week_3_Intern_Assignment.CustomerAdminDetails" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <div class="jumbotron" style="border-style: double; border-width: 5px; border-color: navy; font-family: 'Agency FB'; font-variant: normal; text-transform: inherit; color: #4166F5;">
        <div class="row" style="height:10px">
            <a href="CustomersAdmin.aspx"><img alt="Back" src="golf%20ball.png" style="width: 50px; height: 50px; float:left" /></a>
            <a href="ProductsAdmin.aspx"><img alt="Next" src="golf%20ball%20(2).png" style="width: 50px; height: 50px; float:right" /> </a>
        </div>
        <h1 style="font-size: 40pt"><strong style="font-family: 'Agency FB'; color: #000080;">Golf Shop - CustomerAdminDetails</strong></h1>
        <p style="font-size: x-large">This page allows&nbsp;you to see details of the selected user! If any portion of this page seems blank, go back to the<em> CustomersAdmin</em> Page and click<em> &quot;Edit&quot;</em> next to any user!</p>
        <p style="font-size: x-large">1) See the selected user from the <em>CustomersAdmin</em> Page.</p>
        <p style="font-size: x-large">2) Update the selected user by either changing his/her<em> UserName or EmailAddress. </em></p>
        <p style="font-size: x-large">3) Delete the selected user by clicking <em>&quot;Delete&quot; </em>under the<em> Delete User </em>table.</p>
        <p style="font-size: x-large">4) See all addresses of the selected user.</p>
        <div class="row" style="height:10px">
            <img alt="" src="golfer.gif" style="width: 90px; height: 120px; float:right; margin-right: 100px; margin-top:-58px" />

        </div>
    </div>
        
    <div class ="row">
        <div class="col-md-3">
            <asp:DetailsView ID="UserDetails" runat="server" AutoGenerateRows="False" BorderColor="#4166F5" BorderStyle="Dashed" BorderWidth="5px" DataKeyNames="UserID" DataSourceID="SqlDataSource3" Font-Bold="False" Font-Names="Agency FB" Height="50px" HorizontalAlign="Left" Width="125px" Caption="Details for selected user:" CaptionAlign="Top" CellPadding="5" CellSpacing="2">
                <Fields>
                    <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" ReadOnly="True" SortExpression="UserID" />
                    <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" />
                    <asp:CheckBoxField DataField="IsAdmin" HeaderText="IsAdmin" SortExpression="IsAdmin" />
                    <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated" />
                    <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" SortExpression="CreatedBy" />
                    <asp:BoundField DataField="DateModified" HeaderText="DateModified" SortExpression="DateModified" />
                    <asp:BoundField DataField="ModifiedBy" HeaderText="ModifiedBy" SortExpression="ModifiedBy" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" SelectCommand="spGetUser" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="UserID" QueryStringField="UserID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class ="col-md-3">
           
            <asp:DetailsView ID="UpdateUserDetailView" runat="server" AutoGenerateRows="False" BorderColor="#4166F5" BorderStyle="Dashed" BorderWidth="5px" CellPadding="5" CellSpacing="2" DataKeyNames="UserID" DataSourceID="SqlDataSource4" DefaultMode="Edit" Font-Bold="True" Font-Names="Agency FB" Height="50px" HorizontalAlign="Right" Width="125px" Caption="Update User:" CaptionAlign="Top" OnItemUpdated ="UpdateUserDetailView_OnUpdate">
                <Fields>
                    <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" SortExpression="UserID" ReadOnly="True" />
                    <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" />
                    <asp:CommandField ShowEditButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" SelectCommand="spGetUser" SelectCommandType="StoredProcedure" UpdateCommand="spUpdateUser" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="UserID" QueryStringField="UserID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UserID" Type="Int32" />
                    <asp:Parameter Name="UserName" Type="String" />
                    <asp:Parameter Name="EmailAddress" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <div class ="col-md-2">
            <asp:DetailsView ID="DeleteUserDetailView" runat="server" AutoGenerateRows="False" BorderColor="#4166F5" BorderStyle="Dashed" BorderWidth="5px" Caption="Delete User:" CaptionAlign="Top" CellPadding="3" CellSpacing="1" DataKeyNames="UserID" DataSourceID="SqlDataSource5" Font-Bold="True" Font-Names="Agency FB" Height="50px" HorizontalAlign="Right" Width="130px" OnItemDeleted ="DeleteUserDetailView_OnDelete">
                <Fields>
                    <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" ReadOnly="True" SortExpression="UserID" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" DeleteCommand="spDeleteUser" DeleteCommandType="StoredProcedure" SelectCommand="spGetUser" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="UserID" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="UserID" QueryStringField="UserID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            
        </div>
        <div class ="col-md-4">
            <asp:GridView ID="UserAddressGrid" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BorderColor="#4166F5" BorderStyle="Dashed" BorderWidth="5px" Caption="User Addresses:" CaptionAlign="Top" CellPadding="3" DataKeyNames="AddressID" DataSourceID="SqlDataSource6" Font-Names="Agency FB" HorizontalAlign="Center" PageSize="50">
                <Columns>
                    <asp:BoundField DataField="AddressID" HeaderText="AddressID" InsertVisible="False" ReadOnly="True" SortExpression="AddressID" />
                    <asp:BoundField DataField="Address1" HeaderText="Address 1" SortExpression="Address1" />
                    <asp:BoundField DataField="Address2" HeaderText="Address 2" SortExpression="Address2" />
                    <asp:BoundField DataField="Address3" HeaderText="Address 3" SortExpression="Address3" />
                    <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                    <asp:BoundField DataField="StateAbbrev" HeaderText="State" SortExpression="StateAbbrev" />
                    <asp:BoundField DataField="ZipCode" HeaderText="Zip Code" SortExpression="ZipCode" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:StoreFrontConnectionString %>" SelectCommand="spGetUserAddresses" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="UserID" QueryStringField="UserID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
       
    </div>
        
          
</asp:Content>

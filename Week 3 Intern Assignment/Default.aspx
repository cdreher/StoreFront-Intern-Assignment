<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Week_3_Intern_Assignment.Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="border-style: dashed double dashed double; border-width: 5px; border-color: #000080 #4166f5 #000080 #4166f5; font-family: 'Agency FB'; font-variant: normal; text-transform: inherit;">
        <div class="row" style="height: 10px">
            <img alt="" src="C:\Users\dreherc\Documents\GitHub\StoreFront-Intern-Assignment\Week 3 Intern Assignment\Images\golfer-black.png" style="width: 155px; height: 139px; margin-left: -10px; margin-top: -25px" />

        </div>
        <h1 style="font-size: 40pt"><strong style="font-family: 'Agency FB'; color: #000080;">Golf Shop</strong></h1>
        <p style="font-size: x-large; color: #4166F5;">Welcome to our golf shop. We have the best merchandise around. Feel free to jump around and check things out!</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <p>
                <asp:Image ID="Image1" runat="server" src="https://www.golfdauphinhighlands.com/static/images/event_promo_box_golfcourseBG.jpg" Height="273px" Width="408px" ImageAlign="Left" />

            </p>
        </div>
        <div class="col-md-4">

            <asp:Image ID="Image2" runat="server" src="https://d2s0f1q6r2lxto.cloudfront.net/pub/ProTips/wp-content/uploads/2015/06/buying-golf-irons-300x200.jpg" Height="276px" Width="322px" ImageAlign="Right" />



        </div>
        <div class="col-md-4">
            <asp:Image ID="Image3" runat="server" src="https://d1nwosmzpc2sru.cloudfront.net/8e/f3/7b1f940641669351ae73f8efe753/bcg-go-rangeballsbucket.jpg" Height="275px" Width="380px" ImageAlign="Middle" />
        </div>

    </div>

</asp:Content>


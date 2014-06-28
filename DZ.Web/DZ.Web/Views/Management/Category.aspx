<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ManageSite.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<DZ.Web.Models.tCategory>>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="UCHead" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="UCMainContent" runat="server">
    <h2>
        所有分类</h2>
    <div >
        <% foreach (var item in Model)
           { %>
        <div class="category">
            <%: item.CategoryName %></div>
        <% } %>
    </div>
</asp:Content>

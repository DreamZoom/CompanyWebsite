<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<DZ.Web.Models.tCategory>>" %>

   <ul >
    <% foreach (var item in Model)
       { %>
    <li>
        <%: Html.ActionLink(item.CategoryName, "CateArticles", "T", new { id = item.Id }, new { })%></li>
    <% } %>
</ul>


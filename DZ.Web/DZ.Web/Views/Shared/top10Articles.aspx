<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DZ.Web.Models.tArticle>>" %>

<ul >
    <% foreach (var item in Model)
       { %>
    <li>
        <%: Html.ActionLink(item.Title, "Details", "T", new { id = item.Id }, new { })%></li>
    <% } %>
</ul>

<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<DZ.Web.Models.tTag>>" %>
<div>
    <% foreach (var item in Model)
       { %>
    <span>
        <%: item.TagName %>
    </span>
    <% } %>
</div>

<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DZ.Web.Models.tArticle>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="article-details">
        <div class="title">
            <h1>
                <%:Html.ActionLink(Model.Title, "details", new { Id = Model.Id })%></h1>
            <div class="other">
                <span>
                    <%: Model.Author%></span> <span>发表于<%: String.Format("{0:g}", Model.AddTime)%></span>
                <span>阅读(<%: Model.ReadCount%>) </span><span>顶(<%: Model.UpCount%>)</span><span> 踩(<%: Model.DownCount%>)
                </span>
            </div>
        </div>
        <div class="content">
            <%= Model.Body %>
        </div>
        <div class="tags">
            分类：
            <%foreach (var cate in Model.tCategories)
              { %><span><%:cate.CategoryName%></span><%} %>
        </div>
        <div class="tags">
            标签：
            <%foreach (var tag in Model.tTags)
              { %><span><%:tag.TagName %></span><%} %>
        </div>
        <div class="action">
            <%:Html.ActionLink("收藏该文", "Collect", "U", new { Id = Model.Id }, new { })%>
            <%:Html.ActionLink("顶一下("+Model.UpCount+")", "UpArticle", "T", new { Id = Model.Id }, new { })%>
            <%:Html.ActionLink("踩一下("+Model.DownCount+")", "DownArticle", "T", new { Id = Model.Id }, new { })%>
        </div>
        <div class="review">
        </div>
    </div>
</asp:Content>

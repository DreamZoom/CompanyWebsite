<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/USite.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DZ.Web.Models.tArticle>>" %>
<asp:Content ID="Content2" ContentPlaceHolderID="UCHead" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="UCMainContent" runat="server">

    <h2>
        文章管理</h2>
    <% foreach (var item in Model)
       { %>
    <div class="articles">
        <div>
            <div class="title">
                <b>
                  <%:Html.ActionLink(item.Title, "details", "T", new { Id = item.Id }, new { })%>  </b>
            </div>
            <div>
                <span class="floatRight">
                    <%: Html.ActionLink("取消收藏", "CancelCollect", new { id = item.Id })%>
                </span><span class="other">作者：<%: item.Author %>
                    发布日期：<i><%: String.Format("{0:g}", item.AddTime) %></i> 阅读(<%: item.ReadCount %>)
                    顶(<%: item.UpCount %>) 踩(<%: item.DownCount %>) </span>
            </div>
        </div>
    </div>
    <% } %>

</asp:Content>



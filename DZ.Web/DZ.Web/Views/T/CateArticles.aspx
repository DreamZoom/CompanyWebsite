<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DZ.Web.Models.tArticle>>" %>
<%@ Import Namespace="Webdiyer.WebControls.Mvc" %>
<%@ Import Namespace="DZ.Web.Models" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <link href="../../Content/pager.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <table style="width: 100%;" class="home-table-layout" border="0" cellpadding="0"
            cellspacing="0">
            <tr>
                <td class="tableleft" valign="top">
                    <div class="home-article-list">
                        <% 
                            db_companyEntities db = new db_companyEntities();

                            foreach (var item in Model)
                            { %>
                        <div class="home-article-list-item">
                            <span class="avatar">
                                <% var user = item.tAccounts.FirstOrDefault();
                                   if (user != null)
                                   {
                                       var avatar = db.tUserAvatars.FirstOrDefault(m => m.UserId == user.Id);
                                %>
                                <img src="<%:avatar.SmallAvatar %>" alt="<%:user.UserName %>" />
                                <%} %>
                            </span>
                            <div class="article">
                                <div class="title">
                                    <h3>
                                        <%:Html.ActionLink(item.Title, "details", "T", new { Id = item.Id }, new { })%></h3>
                                </div>
                                <div class="content">
                                    <% string str = new Regex(@"<(.|\n)+?>").Replace(item.Body.ToString(), "");
                                       if (str.Length > 200) str = str.Substring(0, 200);
                                    %>
                                    <%:str %>
                                </div>
                                <div class="foot">
                                    <span><b>
                                        <%=item.Author %></b></span><span>发表于</span><span><%: String.Format("{0:g}", item.AddTime) %>
                                        </span><span>阅读(<%: item.ReadCount %>)</span><span>顶(<%: item.UpCount %>)</span><span>踩(<%: item.DownCount %>)</span>
                                </div>
                            </div>
                            <div class="clear">
                            </div>
                            <%-- <%: item.Author %>
                            <%: item.Body %>
                            <%: String.Format("{0:g}", item.AddTime) %>
                            
                            
                            <%: item.DownCount %>
                            <%: item.State %>--%>
                        </div>
                        <% } %>
                    </div>
                    <div>
                    <%:Html.Pager((PagedList<tArticle>)Model, new PagerOptions() { FirstPageText="首页", NextPageText="下一页", PrevPageText="上一页", LastPageText="尾页", GoButtonText="跳转" }, new { id = "flickrpager" })%>
                    </div>
                </td>
                <td width="200px" valign="top">
                    <div class="right-sider">
                        
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

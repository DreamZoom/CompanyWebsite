<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    if (Request.IsAuthenticated) {
%>
      <b><%:Html.ActionLink(Page.User.Identity.Name, "index", "U")%></b>.
         <%: Html.ActionLink("退出系统", "LogOff", "Account") %> 
<%
    }
    else {
%> 
        <%: Html.ActionLink("登录", "LogOn", "Account") %> 
<%
    }
    
%>.<%:Html.ActionLink("收藏本页","index","U")%>.<%:Html.ActionLink("关于我们","about","home")%>

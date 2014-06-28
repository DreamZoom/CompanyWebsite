<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DZ.Web.Models.LogOnModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    
</asp:Content>
<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        没有账户？
        <%: Html.ActionLink("注册", "Register") %>
        加入我们吧。
    </p>
    <% using (Html.BeginForm())
       { %>
    <div>
        <%: Html.ValidationSummary(true, "登录失败。请更正错误并重试。", new { Class="msg-error"})%>
        <fieldset>
            <legend>登录 </legend>
            <div class="editor-label">
                <%: Html.LabelFor(m => m.UserName) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(m => m.UserName) %>
                <%: Html.ValidationMessageFor(m => m.UserName) %>
            </div>
            <div class="editor-label">
                <%: Html.LabelFor(m => m.Password) %>
            </div>
            <div class="editor-field">
                <%: Html.PasswordFor(m => m.Password) %>
                <%: Html.ValidationMessageFor(m => m.Password) %>
            </div>
            <div class="editor-label">
                <%: Html.CheckBoxFor(m => m.RememberMe) %>
                <%: Html.LabelFor(m => m.RememberMe) %>
            </div>
            <p>
                <input type="submit" value="登录" class="buttom" />
            </p>
        </fieldset>
    </div>
    <% } %>
</asp:Content>

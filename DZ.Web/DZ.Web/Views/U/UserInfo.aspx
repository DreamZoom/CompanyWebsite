<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/USite.Master" Inherits="System.Web.Mvc.ViewPage<DZ.Web.Models.tUserInfo>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="UCHead" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="UCMainContent" runat="server">
    <h2>
        用户信息</h2>
    <% using (Html.BeginForm())
       {%>
    <%: Html.ValidationSummary(true) %>
    <fieldset>
        
        <div class="editor-label">
            <%: Html.LabelFor(model => model.RealName) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.RealName) %>
            <%: Html.ValidationMessageFor(model => model.RealName) %>
        </div>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Sex) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.Sex) %>
            <%: Html.ValidationMessageFor(model => model.Sex) %>
        </div>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Birthday) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.Birthday) %>
            <%: Html.ValidationMessageFor(model => model.Birthday) %>
        </div>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Post) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.Post) %>
            <%: Html.ValidationMessageFor(model => model.Post) %>
        </div>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Address) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.Address) %>
            <%: Html.ValidationMessageFor(model => model.Address) %>
        </div>
        <p>
            <input type="submit" value="保存" />
        </p>
    </fieldset>
    <% } %>
   
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/USite.Master" Inherits="System.Web.Mvc.ViewPage<DZ.Web.Models.tUserContact>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="UCHead" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="UCMainContent" runat="server">
    <h2>
        联系方式</h2>
    <% using (Html.BeginForm())
       {%>
    <%: Html.ValidationSummary(true) %>
    <fieldset>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Phone) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.Phone) %>
            <%: Html.ValidationMessageFor(model => model.Phone) %>
        </div>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.QQ) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.QQ) %>
            <%: Html.ValidationMessageFor(model => model.QQ) %>
        </div>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Email) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.Email) %>
            <%: Html.ValidationMessageFor(model => model.Email) %>
        </div>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.MSN) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.MSN) %>
            <%: Html.ValidationMessageFor(model => model.MSN) %>
        </div>
        <p>
            <input type="submit" value="保存" />
        </p>
    </fieldset>
    <% } %>
   
</asp:Content>

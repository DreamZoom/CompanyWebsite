<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/USite.Master" Inherits="System.Web.Mvc.ViewPage<DZ.Web.Models.tArticle>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="UCHead" runat="server">
    <link href="/Scripts/KindEditor/themes/default/default.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/KindEditor/kindeditor-min.js" type="text/javascript"></script>
    <script src="../../Scripts/KindEditor/lang/zh_CN.js" type="text/javascript"></script>
    <script type="text/javascript">
        KindEditor.ready(function (K) {
            K.create('textarea[name="Body"]', {
                width: "720px",
                height: "300px",
                resizeType: 1,
                autoHeightMode: true,
                afterCreate: function () {
                    this.loadPlugin('autoheight');
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="UCMainContent" runat="server">
    <h2>
        编辑文章</h2>
    <% using (Html.BeginForm())
       {%>
    <%: Html.ValidationSummary(true) %>
    <fieldset>
        <div class="editor-label">
            标题
        </div>
        <div class="editor-field edit-title">
            <%: Html.TextBoxFor(model => model.Title, new { Class = "edit-title" })%>
            <%: Html.ValidationMessageFor(model => model.Title) %>
        </div>
        <div class="editor-label">
            内容
        </div>
        <div class="editor-field">
            <%: Html.TextAreaFor(model => model.Body) %>
            <%: Html.ValidationMessageFor(model => model.Body) %>
        </div>
        <div class="editor-label">
            标签
        </div>
        <div class="editor-field">
            <%
                string tags = "";
                foreach (var s in Model.tTags)
                {
                    tags += "," + s.TagName;
                }
                if (tags.Length > 1)
                {
                    tags = tags.Substring(1);
                }
            
            %>
            <%: Html.TextBox("tags", tags)%>*多个标签以逗号分隔.
        </div>

        <div class="editor-label">
            系统分类
        </div>
        <div class="editor-field">
            <%
                DZ.Web.Models.db_companyEntities db = new DZ.Web.Models.db_companyEntities();
                var cate = Model.tCategories.FirstOrDefault();
                
                List<SelectListItem> selectItems = new List<SelectListItem>();
                foreach (var cat in db.tCategories)
                {
                    if (cate != null && cat.CategoryName == cate.CategoryName)
                    {
                        selectItems.Add(new SelectListItem() { Text = cat.CategoryName, Value = cat.CategoryName, Selected = true });
                    }
                    else
                    {
                        selectItems.Add(new SelectListItem() { Text = cat.CategoryName, Value = cat.CategoryName });
                    }
                }
            %>
            <%: Html.DropDownList("Category", selectItems)%>
        </div>
        <p>
            <input type="submit" value="保存" />
        </p>
    </fieldset>
    <% } %>
</asp:Content>

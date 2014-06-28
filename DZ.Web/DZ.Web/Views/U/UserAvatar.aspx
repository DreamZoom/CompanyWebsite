<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/USite.Master" Inherits="System.Web.Mvc.ViewPage<DZ.Web.Models.tUserAvatar>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="UCHead" runat="server">
    <link href="../../Scripts/Uploadify/uploadify.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/Jcrop/css/jquery.Jcrop.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .crop_preview
        {
            position: absolute;
            left: 0px;
            top: 0px;
            width: 180px;
            height: 180px;
            overflow: hidden;
        }
         .crop_preview2
        {
            position: absolute;
            left: 0px;
            top: 0px;
            width: 80px;
            height: 80px;
            overflow: hidden;
        }
        .table-avatar
        {
            border:0 solid #fff;
        }
         .table-avatar td
         {
              border:0 solid #fff;
         }
        .left
        {
            width: 300px;
            
        }
      
        .style1
        {
            width: 257px;
        }
      
    </style>
    <script src="../../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../../Scripts/Uploadify/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Scripts/Jcrop/jquery.Jcrop.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            function showPreview(coords) {
                if (parseInt(coords.w) > 0) {
                    //计算预览区域图片缩放的比例，通过计算显示区域的宽度(与高度)与剪裁的宽度(与高度)之比得到
                    var rx = $("#preview_box").width() / coords.w;
                    var ry = $("#preview_box").height() / coords.h;

                    var rx2 = $("#preview_box2").width() / coords.w;
                    var ry2 = $("#preview_box2").height() / coords.h;

                    $("#crop_x").val(coords.x);
                    $("#crop_y").val(coords.y);
                    $("#crop_w").val(coords.w);
                    $("#crop_h").val(coords.h);
                    $("#crop_bw").val($("#useravatar").width());
                    $("#crop_bh").val($("#useravatar").height());

                    //通过比例值控制图片的样式与显示
                    $("#crop_preview").css({
                        width: Math.round(rx * $("#useravatar").width()) + "px", //预览图片宽度为计算比例值与原图片宽度的乘积
                        height: Math.round(rx * $("#useravatar").height()) + "px",  //预览图片高度为计算比例值与原图片高度的乘积
                        marginLeft: "-" + Math.round(rx * coords.x) + "px",
                        marginTop: "-" + Math.round(ry * coords.y) + "px"
                    });

                    $("#crop_preview2").css({
                        width: Math.round(rx2 * $("#useravatar").width()) + "px", //预览图片宽度为计算比例值与原图片宽度的乘积
                        height: Math.round(rx2 * $("#useravatar").height()) + "px",  //预览图片高度为计算比例值与原图片高度的乘积
                        marginLeft: "-" + Math.round(rx2 * coords.x) + "px",
                        marginTop: "-" + Math.round(ry2 * coords.y) + "px"
                    });
                }
            }

            $("#uploadify").uploadify({
                'buttonText': '上传头像',
                'queueSizeLimit': 1,
                'multi': false,
                'fileDesc': 'jpg,gif',
                'fileExt': '*.jpg;*.gif',
                height: 30,
                swf: '/scripts/uploadify/uploadify.swf',
                cancelImg: '/scripts/uploadify/uploadify-cancel.png',
                uploader: '/U/Uploadify', //图片上传处理器
                width: 120,
                onUploadComplete: function (file) {
                    console.log(file.name + "--" + file.size);

                },
                onUploadSuccess: function (file, data, response) {

                    result = $.parseJSON(data);
                    if (result && result.result) {
                        $("#useravatar").attr("src", result.path);
                        $("#crop_preview").attr("src", result.path);
                        $("#crop_preview2").attr("src", result.path);
                        $("#useravatar").Jcrop({
                            onChange: showPreview,
                            onSelect: showPreview,
                            aspectRatio: 1,
                            setSelect: [0, 0, 100, 100]
                        });
                    }

                }

            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="UCMainContent" runat="server">
    <h2>
        用户头像</h2>
    <div style="padding: 10px">
        <table style="width: 100%;" class="table-avatar" border="0" cellpadding="0" 
            cellspacing="0">
            <tr>
                <td class="style1">
                    &nbsp;
                    <input id="uploadify" type="file" />
                </td>
                <td >
                </td>
            </tr>
            <tr>
                <td class="style1" valign="top">
                    <div>
                        <img id="useravatar" width="240px" src="" alt="头像" />
                    </div>
                </td>
                <td valign="top">
                    <div style=" position: relative; height:200px ">
                        <span id="preview_box" class="crop_preview">
                            <img id="crop_preview" src="<%:Model.BigAvatar %>" alt="" />
                        </span>

                    </div>
                    <div style=" position: relative; height:100px ">
                        <span id="preview_box2" class="crop_preview2">
                            <img id="crop_preview2" src="<%:Model.SmallAvatar %>" alt="" />
                        </span>

                    </div>
                </td>
            </tr>
        </table>
    </div>
    <% using (Html.BeginForm())
       {%>
    <%:Html.Hidden("crop_x") %>
    <%:Html.Hidden("crop_y") %>
    <%:Html.Hidden("crop_w") %>
    <%:Html.Hidden("crop_h") %>
    <%:Html.Hidden("crop_bw")%>
    <%:Html.Hidden("crop_bh") %>
    <hr />
    <p>
        <input type="submit" value="保存" />
    </p>
    <% } %>
</asp:Content>

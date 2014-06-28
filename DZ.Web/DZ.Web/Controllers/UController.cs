using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DZ.Web.Models;
using System.IO;
using System.Drawing;

namespace DZ.Web.Controllers
{
    /*
    * 
    * 用户中心
    * 
    * 发布文章
    * 个人信息
    **/
    public class UController : Controller
    {

        db_companyEntities db = new db_companyEntities();

        /// <summary>
        /// 用户首页
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);
                if (user != null)
                {
                    return View(user);
                }
            }
            return View(new tAccount());
        }

        #region  发布文章
        public ActionResult PostArticle()
        {
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult PostArticle(tArticle article)
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);
                if (user != null)
                {
                    //存文章
                    article.Author = user.UserName;
                    article.AddTime = DateTime.Now;

                    //添加标签
                    string tags = Request.Params["tags"];
                    if (!string.IsNullOrEmpty(tags))
                    {
                        string[] ts = tags.Split(',');
                        foreach (var s in ts)
                        {
                            if (!string.IsNullOrEmpty(s))
                            {
                                var tag = db.tTags.FirstOrDefault(m => m.TagName == s);
                                if (tag == null)
                                {
                                    article.tTags.Add(new tTag() { TagName = s });
                                }
                                else
                                {
                                    article.tTags.Add(tag);
                                }

                            }
                        }
                    }

                    //关联分类
                    string cateName = Request.Params["Category"];
                    if (!string.IsNullOrEmpty(cateName))
                    {
                        var cate = db.tCategories.FirstOrDefault(m => m.CategoryName == cateName);
                        if (cate != null)
                        {
                            article.tCategories.Add(cate);
                        }
                    }

                    //关联到用户
                    user.tArticles.Add(article);

                    db.SaveChanges();
                }
            }
            return View(article);
        }
        #endregion

        #region 查看文章
        public ActionResult Articles()
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);
                if (user != null)
                {
                    return View(user.tArticles);
                }
            }
            return View("error");
        }
        #endregion


        #region 编辑文章
        public ActionResult EditArticle(int Id)
        {
            if (User.Identity.IsAuthenticated)
            {
                var article = db.tArticles.Where(m => m.Author == User.Identity.Name).FirstOrDefault(m => m.Id == Id);
                if (article != null)
                {
                    return View(article);
                }
            }
            return View("error");
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult EditArticle(int Id, tArticle article)
        {
            if (User.Identity.IsAuthenticated)
            {
                var old_article = db.tArticles.Where(m => m.Author == User.Identity.Name).FirstOrDefault(m => m.Id == Id);
                if (old_article != null)
                {
                    old_article.Title = article.Title;
                    old_article.Body = article.Body;
                    //添加标签
                    old_article.tTags.Clear();// 清除标签
                    string tags = Request.Params["tags"];
                    if (!string.IsNullOrEmpty(tags))
                    {
                        string[] ts = tags.Split(',');
                        foreach (var s in ts)
                        {
                            if (!string.IsNullOrEmpty(s))
                            {
                                var tag = db.tTags.FirstOrDefault(m => m.TagName == s);
                                if (tag == null)
                                {
                                    old_article.tTags.Add(new tTag() { TagName = s });
                                }
                                else
                                {
                                    old_article.tTags.Add(tag);
                                }
                            }
                        }
                    }

                    //关联分类
                    string cateName = Request.Params["Category"];
                    if (!string.IsNullOrEmpty(cateName))
                    {
                        var cate = db.tCategories.FirstOrDefault(m => m.CategoryName == cateName);
                        if (cate != null)
                        {
                            old_article.tCategories.Add(cate);
                        }
                    }

                    db.SaveChanges();
                    return RedirectToAction("index");
                }
            }
            return View("error");
        }
        #endregion


        #region 删除文章
        public ActionResult DeleteArticle(int Id)
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);
                if (user != null)
                {
                    var article = db.tArticles.FirstOrDefault(m => m.Id == Id);

                    if (article != null)
                    {
                        db.tArticles.DeleteObject(article);
                    }
                    db.SaveChanges();
                }
            }
            return View("error");
        }
        #endregion


        #region 用户信息
        public ActionResult UserInfo()
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);

                if (user != null)
                {
                    var old_userinfo = db.tUserInfoes.FirstOrDefault(m => m.UserId == user.Id);
                    if (old_userinfo != null)
                    {
                        return View(old_userinfo);
                    }
                }
            }
            return View();
        }

        [HttpPost]
        public ActionResult UserInfo(tUserInfo userinfo)
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);

                if (user != null)
                {
                    var old_userinfo = db.tUserInfoes.FirstOrDefault(m => m.UserId == user.Id);
                    if (old_userinfo != null)
                    {
                        old_userinfo.Post = userinfo.Post;
                        old_userinfo.RealName = userinfo.RealName;
                        old_userinfo.Sex = userinfo.Sex;
                        old_userinfo.Address = userinfo.Address;
                        old_userinfo.Birthday = userinfo.Birthday;
                    }
                    else
                    {
                        userinfo.UserId = user.Id;
                        db.tUserInfoes.AddObject(userinfo);
                    }
                    db.SaveChanges();
                }
            }
            return View(userinfo);
        }

        #endregion

        #region 用户头像
        public ActionResult UserAvatar()
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);

                if (user != null)
                {
                    var avatar = db.tUserAvatars.FirstOrDefault(m => m.UserId == user.Id);
                    if (avatar != null)
                    {
                        return View(avatar);
                    }
                }
            }
            return View("error");
        }

        [HttpPost]
        public ActionResult UserAvatar(tUserAvatar useravatar)
        {
            try
            {
                if (User.Identity.IsAuthenticated)
                {
                    var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);

                    if (user != null)
                    {
                        int x = int.Parse(Request.Params["crop_x"]);
                        int y = int.Parse(Request.Params["crop_y"]);
                        float w = float.Parse(Request.Params["crop_w"]);
                        float h = float.Parse(Request.Params["crop_h"]);
                        float bw = float.Parse(Request.Params["crop_bw"]);
                        float bh = float.Parse(Request.Params["crop_bh"]);


                        if (Session["useravater"] != null)
                        {
                            string oripath = Session["useravater"].ToString();
                            if (System.IO.File.Exists(oripath))
                            {
                                Image bmp = Bitmap.FromFile(oripath);
                                Bitmap bitmap = new Bitmap(bmp, new Size((int)bw, (int)bh));

                                string ext = ".jpg";
                                string name = Guid.NewGuid().ToString();
                                string name2 = Guid.NewGuid().ToString();
                                string path = "/upload/Avatar/";
                                string truePath = Server.MapPath(path);
                                string filepath = truePath + name + ext;
                                string filepath2 = truePath + name2 + ext;
                                string virtualPath = path + name + ext;
                                string virtualPath2 = path + name2 + ext;

                                if (!Directory.Exists(truePath))
                                {
                                    Directory.CreateDirectory(truePath);
                                }

                                Bitmap temp = CropImage(bitmap, x, y, w, h);

                                Bitmap bmp180 = new Bitmap(temp, new Size(180, 180));//180*180
                                Bitmap bmp80 = new Bitmap(temp, new Size(80, 80));//80*80
                                bmp180.Save(filepath);//保存
                                bmp80.Save(filepath2);//保存

                                var useravatar1 = db.tUserAvatars.FirstOrDefault(m => m.UserId == user.Id);
                                if (useravatar1 != null)
                                {
                                    ///修改
                                    useravatar1.SmallAvatar = virtualPath2;
                                    useravatar1.BigAvatar = virtualPath;
                                    db.SaveChanges();
                                    return RedirectToAction("UserAvatar");
                                }
                                else
                                {
                                    //add
                                    useravatar.UserId = user.Id;
                                    useravatar.SmallAvatar = virtualPath2;
                                    useravatar.BigAvatar = virtualPath;
                                    db.tUserAvatars.AddObject(useravatar);
                                    db.SaveChanges();
                                    return RedirectToAction("UserAvatar");
                                }
                            }
                        }
                    }
                }

            }
            catch
            {
            }
            return View(useravatar);
        }
        #region 图片裁剪

        public static Bitmap CropImage(Image image, float cropX, float cropY, float cropWidth, float cropHeight)
        {
            int originalWidth = image.Width;
            int originalHeight = image.Height;

            cropWidth = originalWidth - cropX > cropWidth ? cropWidth : originalWidth - cropX;
            cropHeight = originalHeight - cropY > cropHeight ? cropHeight : originalHeight - cropY;

            Bitmap tempBmp = new Bitmap((int)cropWidth, (int)cropHeight);
            Graphics g = Graphics.FromImage(tempBmp);//cropX, cropY, (int)cropWidth, (int)cropHeight
            g.DrawImage(image, new RectangleF(0, 0, cropWidth, cropHeight), new RectangleF(cropX, cropY, cropWidth, cropHeight), GraphicsUnit.Pixel);

            return tempBmp;
        }

        #endregion
        #region 文件上传

        public ActionResult Uploadify()
        {
            if (Request.Files.Count > 0)
            {
                HttpPostedFileBase file = Request.Files[0];
                if (file != null && file.ContentLength > 0)
                {
                    string ext = file.FileName.Substring(file.FileName.LastIndexOf('.'));
                    string name = Guid.NewGuid().ToString();
                    string path = "/upload/temp/";
                    string truePath = Server.MapPath(path);
                    string filepath = truePath + name + ext;
                    string virtualPath = path + name + ext;
                    if (Directory.Exists(truePath))
                    {
                        Directory.CreateDirectory(truePath);
                    }
                    file.SaveAs(filepath);

                    Session["useravater"] = filepath;
                    return Json(new { result = true, path = virtualPath });
                }
                return Json(new { result = false, msg = "文件为空" });
            }
            return Json(new { result = false, msg = "文件未上传" });
        }

        #endregion
        #endregion

        #region 用户联系方式
        public ActionResult UserContact()
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);

                if (user != null)
                {
                    var old_usercontact = db.tUserContacts.FirstOrDefault(m => m.UserId == user.Id);
                    if (old_usercontact != null)
                    {
                        return View(old_usercontact);
                    }
                }
            }
            return View();
        }

        [HttpPost]
        public ActionResult UserContact(tUserContact usercontact)
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);

                if (user != null)
                {
                    var old_usercontact = db.tUserContacts.FirstOrDefault(m => m.UserId == user.Id);
                    if (old_usercontact != null)
                    {
                        old_usercontact.Email = usercontact.Email;
                        old_usercontact.MSN = usercontact.MSN;
                        old_usercontact.Phone = usercontact.Phone;
                        old_usercontact.QQ = usercontact.QQ;
                    }
                    else
                    {
                        usercontact.UserId = user.Id;
                        db.tUserContacts.AddObject(usercontact);
                    }
                    db.SaveChanges();
                }
            }
            return View(usercontact);
        }
        #endregion

        #region 我的收藏

        public ActionResult CollectArticles()
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);
                if (user != null)
                {
                    return View(user.CollectArticles);
                }
            }
            return View("error");
        }
        #endregion

        #region 收藏文章
        public ActionResult Collect(int Id)
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);
                if (user != null)
                {
                    var article = db.tArticles.FirstOrDefault(m => m.Id == Id);
                    if (article != null)
                    {
                        user.CollectArticles.Add(article);
                        db.SaveChanges();
                        return RedirectToAction("CollectArticles");
                    }

                }
            }
            return View("error");
        }
        #endregion

        #region 取消收藏
        public ActionResult CancelCollect(int Id)
        {
            if (User.Identity.IsAuthenticated)
            {
                var user = db.tAccounts.FirstOrDefault(m => m.UserName == User.Identity.Name);
                if (user != null)
                {
                    var article = db.tArticles.FirstOrDefault(m => m.Id == Id);
                    if (article != null)
                    {
                        user.CollectArticles.Remove(article);
                        db.SaveChanges();
                        return RedirectToAction("CollectArticles");
                    }

                }
            }
            return View("error");
        }
        #endregion
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DZ.Web.Models;
using Webdiyer.WebControls.Mvc;

namespace DZ.Web.Controllers
{
    /*
     * 文章查看、公共
     * 
     * */
    public class TController : Controller
    {
        db_companyEntities db = new db_companyEntities();

        //查看文章
        public ActionResult Details(int Id)
        {
            var article = db.tArticles.FirstOrDefault(m => m.Id == Id);
            if (article == null)return View("error");
          
            article.ReadCount++;
            db.SaveChanges();
            return View(article);
        }

        //顶文章
        public ActionResult UpArticle(int Id)
        {
            var article = db.tArticles.FirstOrDefault(m => m.Id == Id);
            if (article == null) return View("error");
            article.ReadCount--;
            article.UpCount++;
            db.SaveChanges();
            return RedirectToAction("Details", new { Id = article.Id });
        }

        //踩文章
        public ActionResult DownArticle(int Id)
        {
            var article = db.tArticles.FirstOrDefault(m => m.Id == Id);
            if (article == null) return View("error");
            article.ReadCount--;
            article.DownCount++;
            db.SaveChanges();
            return RedirectToAction("Details", new { Id = article.Id });
        }

        //阅读排行
        public ActionResult ReadRank()
        {
            int pageIndex = 1;
            if (Request.Params["pageIndex"] != null)
            {
                pageIndex = int.Parse(Request.Params["pageIndex"]);
            }
            ViewData["pageIndex"] = pageIndex;
            ViewData["recordCount"] = db.tArticles.Count();

            var list = db.tArticles.OrderByDescending(m => m.ReadCount).ToPagedList(pageIndex, 20);
          
            return View(list);
        }
        //精品推荐
        public ActionResult UpRank()
        {
            int pageIndex = 1;
            if (Request.Params["pageIndex"] != null)
            {
                pageIndex = int.Parse(Request.Params["pageIndex"]);
            }
            ViewData["pageIndex"] = pageIndex;
            ViewData["recordCount"] = db.tArticles.Count();

            var list = db.tArticles.OrderByDescending(m => m.UpCount).ToPagedList(pageIndex, 20);
          
            return View(list);
        }

        //分类文章
        public ActionResult CateArticles(int cateId)
        {
            var cate = db.tCategories.FirstOrDefault(m=>m.Id==cateId);
            int pageIndex = 1;
            if (Request.Params["pageIndex"] != null)
            {
                pageIndex = int.Parse(Request.Params["pageIndex"]);
            }
            ViewData["pageIndex"] = pageIndex;
            ViewData["recordCount"] = db.tArticles.Count();

            var list = cate.tArticles.OrderByDescending(m => m.AddTime).AsQueryable().ToPagedList(pageIndex, 20);
          

            return View(list);
        }

    }
}

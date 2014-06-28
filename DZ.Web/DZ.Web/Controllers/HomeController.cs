using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DZ.Web.Models;
using Webdiyer.WebControls.Mvc;
namespace DZ.Web.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        db_companyEntities db = new db_companyEntities();
        public ActionResult Index()
        {
            int pageIndex = 1;
            if (Request.Params["pageIndex"] != null)
            {
                pageIndex = int.Parse(Request.Params["pageIndex"]);
            }
            ViewData["pageIndex"] = pageIndex;
            ViewData["recordCount"] = db.tArticles.Count();

            var list = db.tArticles.OrderByDescending(m => m.AddTime).ToPagedList(pageIndex, 20);
            var top10 = db.tArticles.OrderByDescending(m => m.ReadCount).Take(10);
            ViewData["top10"] = top10;
            ViewData["categorys"] = db.tCategories;//文章类别
            ViewData["tags"] = db.tTags.Take(40);//标签

            return View(list);
        }

        public ActionResult About()
        {
            return View();
        }
    }
}

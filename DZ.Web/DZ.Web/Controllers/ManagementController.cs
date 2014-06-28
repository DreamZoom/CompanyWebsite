using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DZ.Web.Models;
namespace DZ.Web.Controllers
{
    /*
     * 后台管理界面
     * 
     * 
     * 
     * 
     * */
    public class ManagementController : Controller
    {

        db_companyEntities db = new db_companyEntities();
        /// <summary>
        /// 管理首页
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }


        #region 分类管理
        /// <summary>
        /// 分类管理
        /// </summary>
        /// <returns></returns>
        public ActionResult Category()
        {
            return View(db.tCategories);
        }
        /// <summary>
        /// 添加分类
        /// </summary>
        /// <param name="categoryName"></param>
        /// <param name="parentid"></param>
        /// <returns></returns>
        public ActionResult AddCategory(string categoryName, int parentid)
        {
            var parentCategory = db.tCategories.FirstOrDefault(m=>m.ParentId==parentid);
            if (parentCategory != null)
            {
                tCategory category = new tCategory() { CategoryName = categoryName, ParentId = parentid, CategoryPath=parentCategory.CategoryPath+parentid };
                db.tCategories.AddObject(category);
                db.SaveChanges();
            }
            return RedirectToAction("Category");
        }
        public ActionResult EditCateory(string categoryName, int categoryid)
        {
            var category = db.tCategories.FirstOrDefault(m => m.Id == categoryid);
            if (category != null)
            {
                category.CategoryName = categoryName;
                db.SaveChanges();
            }
            return RedirectToAction("Category");
        }
        public ActionResult MoveCategory(int categoryid,int parentid)
        {
            var category = db.tCategories.FirstOrDefault(m => m.Id == categoryid);
            var parentCategory = db.tCategories.FirstOrDefault(m => m.ParentId == parentid);
            if (category != null && parentCategory!=null)
            {
                category.ParentId = parentCategory.Id;
                db.SaveChanges();
            }
            return RedirectToAction("Category");
        }
        public ActionResult DeleteCategory(int categoryid)
        {
            var category = db.tCategories.FirstOrDefault(m => m.Id == categoryid);
           
            if (category != null)
            {
                db.tCategories.DeleteObject(category);
                db.SaveChanges();
            }
            return RedirectToAction("Category");
        }
        #endregion



        /// <summary>
        /// 文章管理 
        /// </summary>
        /// <returns></returns>
        public ActionResult Articles()
        {
            var list = db.tArticles;
            return View(list);
        }

    }
}

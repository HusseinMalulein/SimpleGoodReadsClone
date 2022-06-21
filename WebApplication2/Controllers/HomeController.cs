using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using WebApplication2.EntityFramework.Classes;
using WebApplication2.Models;

namespace WebApplication2.Controllers
{
    public class HomeController : BaseController
    {
        private readonly GoodReadsDBContext _context;


        public HomeController(GoodReadsDBContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult FriendsList()
        {
            return View("~/Views/Console/FollowersList.cshtml");
        }
        public IActionResult ViewUser(int id)
        {

            ViewBag.IDPassedUser = id;
            return View("~/Views/Console/ViewUser.cshtml");

        }
        public IActionResult ViewPublisher(int id)
        {

            ViewBag.IDPassedUser = id;
            return View("~/Views/Console/ViewPublisher.cshtml");

        }
        public IActionResult Logout()
        {

            return View("~/Views/Home/index.cshtml");
        }
        public IActionResult BrowseBooks()
        {

            return View("~/Views/Console/BrowseBooks.cshtml");
        }
        public IActionResult Books()
        {
            return View("~/Views/Console/Books.cshtml");
        }
        public IActionResult MyBooks()
        {
            return View("~/Views/Console/MyBooks.cshtml");
        }
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        [HttpGet]
        public IActionResult GetLoggedInDetails()
        {
            try
            {
                int IDUser = GetUserID();
                var user = _context.Users.Where(o => o.UserID == IDUser).FirstOrDefault();

                var userinfo = new
                {
                    user.Username,
                    user.ImagePath,
                    isauthor = user.isauthor
                };
                return Ok(userinfo);
            }
            catch
            {
                return Unauthorized();
            }
        }
    }
}
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace WebApplication2.Controllers
{
    public class BaseController : Controller
    {

        public string UserName { get; set; }
        public string ImagePath { get; set; }

        public int GetUserID()
        {
            try
            {
                var identity = HttpContext.User.Identity as ClaimsIdentity;
                if (identity != null)
                {
                    this.UserName = identity.FindFirst("username").Value;
                    this.ImagePath = identity.FindFirst("imagepath").Value;
                    return int.Parse(identity.FindFirst("userid").Value);
                }
                return -1;
            }
            catch (Exception ex) { return -1; }
        }
     
    }
    public class LoggedInInfo
    {
        public string UserName { get; set; }
        public string ImagePath { get; set; }
    }
}

using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WebApplication2.EntityFramework.Classes;
using WebApplication2.EntityFramework.Tables;
using WebApplication2.Enums;
using WebApplication2.Models;

namespace WebApplication2.Controllers
{
    public class UsersController : BaseController
    {
        private readonly ILogger<HomeController> _logger;

        private readonly GoodReadsDBContext _context;

        public UsersController(ILogger<HomeController> logger, GoodReadsDBContext context)
        {
            _logger = logger;
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login([FromBody] LoginModel model)
        {
            var user = _context.Users.Where(o => o.Username == model.Username).FirstOrDefault();
            if (user == null)
            {
                return Ok(new ResponseModel((int)ErrorCodesEnum.UserNameDoesntExists, "User Name doesn't exist", new object()));
            }
            else
            {
                if (user.Password != model.Password)
                    return Ok(new ResponseModel((int)ErrorCodesEnum.UserNameDoesntExists, "Wrong Password", new object()));// zabeta ka wwrong pass
                else
                {
                    var tokenDescriptor = new SecurityTokenDescriptor
                    {
                        Subject = new ClaimsIdentity(new Claim[]
                         {
                            new Claim("userid",user.UserID.ToString()),
                            new Claim("username",user.Username.ToString()),
                            new Claim("imagepath",user.ImagePath.ToString())
                         }),
                        Expires = DateTime.UtcNow.AddDays(1),

                        SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(Encoding.UTF8.GetBytes("1234567890123977")), SecurityAlgorithms.HmacSha256Signature)
                    };
                    var tokenHandler = new JwtSecurityTokenHandler();
                    var securityToken = tokenHandler.CreateToken(tokenDescriptor);
                    var token = tokenHandler.WriteToken(securityToken);// middle ware ram
                    ImagePath = user.ImagePath;
                    UserName = user.Username;
                    return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Logged In Successfully", new object(), token));
                }

            }

        }

        [HttpPost]
        public IActionResult RegisterUser([FromBody] RegisterUserModel model)
        {

            Users user = new Users();
            user.FirstName = model.FirstName;
            user.LastName = model.LastName;
            user.Gender = model.Gender;
            user.Birthdate = DateTime.Parse(model.Birthdate);
            user.Username = model.Username;
            user.Password = model.Password;
            user.Email = model.Email;
            //user.Reviews = model.Reviews;
            user.CreatedAt = DateTime.Now;
            user.UpdatedAt = DateTime.Now;

            _context.Users.Add(user);
            _context.SaveChanges();

            return Ok(new { message = "Success", errorcode = 0 });//temporary

        }

        [HttpPost]
        public IActionResult RateText([FromBody] RateTextModel model)
        {
            //var text = _context.Texts.Where(o=>o.Text_ID == model.Text_ID);
            //var user = _context.Users.Where(s => s.UserID == model.User_ID);

            Ratings r = new Ratings();
            r.Rating = model.Rating;
            r.Text_ID = model.Text_ID;
            r.User_ID = model.User_ID;
            r.Created_At = DateTime.Now;
            r.Updated_At = DateTime.Now;

            _context.Ratings.Add(r);
            _context.SaveChanges();

            //return Ok(new { message = "Success", errorcode = 6 });//temporary
            return Ok(new { message = "", errorcode = 6 });
        }
    }
    public class RegisterUserModel
    {
        //public int UserID { get; set; } because autoincrement
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Birthdate { get; set; }
        public string Gender { get; set; }

        // public DateTime CreatedAt { get; set; } user is not responsible to fill those
        // public DateTime UpdatedAt { get; set; }
    }
    public class LoginModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class RateTextModel
    {

        public int Text_ID { get; set; }
        public int User_ID { get; set; }
        public int Rating { get; set; }

        // public DateTime CreatedAt { get; set; }
        // public DateTime UpdatedAt { get; set; }

    }



}

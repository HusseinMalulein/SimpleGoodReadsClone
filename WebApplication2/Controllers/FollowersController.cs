using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;
using WebApplication2.EntityFramework.Classes;
using WebApplication2.EntityFramework.Tables;
using WebApplication2.Enums;
using WebApplication2.Models;

namespace WebApplication2.Controllers
{
    public class FollowersController : BaseController
    {
        private readonly GoodReadsDBContext _context;

        public FollowersController(GoodReadsDBContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        [HttpPut]
        public IActionResult Follow(int userID)
        {
            int loggedInUserId = GetUserID();
            var newFollow = new Friendlings();
            newFollow.User_ID = loggedInUserId;
            newFollow.Friend_ID = userID;
            newFollow.Created_at = DateTime.Now;
            newFollow.Updated_at = DateTime.Now;
            _context.Friendlings.Add(newFollow);
            _context.SaveChanges();
            return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Followed Sucessfully", new object()));
        }
        [HttpPut]
        public IActionResult UnFollow(int userID)
        {
            int loggedInUserId = GetUserID();
            var follow = _context.Friendlings.Where(o => o.User_ID == loggedInUserId && o.Friend_ID == userID).FirstOrDefault();
            _context.Friendlings.Remove(follow);
            _context.SaveChanges();
            return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "UnFollowed Sucessfully", new object()));
        }
        [HttpGet]
        public IActionResult GetFollowersForUser(int id)
        {
            var friends = (from friend in _context.Friendlings
                           .Where(o => o.User_ID == id)
                           select new
                           {
                               userId = friend.Friend_ID,
                               ImagePath = friend.User.ImagePath,
                               name = friend.Friend.FirstName + ' ' + friend.Friend.LastName,
                               followeddate = friend.Created_at.ToString("yyyy-MM-dd")
                           }).ToList();
            return Ok(friends);
        }
        [HttpGet]
        public IActionResult SearchUsers(string searchtext)
        {
            int IDUser = GetUserID();
            if (string.IsNullOrEmpty(searchtext))
            {
                var myfollowers = (from friend in _context.Friendlings
                          .Where(o => o.User_ID == IDUser)
                                   select new
                                   {
                                       userId = friend.Friend_ID,
                                       name = friend.Friend.FirstName + ' ' + friend.Friend.LastName,
                                       followeddate = friend.Created_at.ToString("yyyy-MM-dd"),
                                       imgpath = friend.Friend.ImagePath,
                                       following = true
                                   }).ToList();
                return Ok(myfollowers);
            }
            var following = (from friend in _context.Friendlings
                            .Where(o => o.User_ID == IDUser
                              && (o.Friend.Username.Contains(searchtext) ||
                                o.Friend.LastName.Contains(searchtext))
                            )
                             select new
                             {
                                 userId = friend.Friend_ID,
                                 name = friend.Friend.FirstName + ' ' + friend.Friend.LastName,
                                 followeddate = friend.Created_at.ToString("yyyy-MM-dd"),
                                 imgpath = friend.Friend.ImagePath,
                                 following = true
                             }).ToList();

            var newToFollow = (from user in _context.Users
                           .Where(o => o.UserID != IDUser
                           && (o.Username.Contains(searchtext) ||
                               o.LastName.Contains(searchtext))
                           && !following.Select(o => o.userId).Contains(o.UserID))
                               select new
                               {
                                   userId = user.UserID,
                                   name = user.FirstName + ' ' + user.LastName,
                                   followeddate = "",
                                   imgpath = user.ImagePath,
                                   following = false
                               }).ToList();
            return Ok(following.Concat(newToFollow));
        }
        [HttpGet]
        public IActionResult GetFollowersListForLoggedInUser()
        {
            int IDUser = GetUserID();
            var friends = (from friend in _context.Friendlings
                           .Where(o => o.User_ID == IDUser)
                           select new
                           {
                               userId = friend.Friend.UserID,
                               name = friend.Friend.FirstName + ' ' + friend.Friend.LastName,
                               followeddate = friend.Created_at.ToString("yyyy-MM-dd"),
                               imgpath = friend.Friend.ImagePath
                           }).ToList();
            return Ok(friends);
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetConversationMessages(int idfriend)
        {
            int IDUser = GetUserID();
            var msgs = _context.Messages
                           .Include(o => o.IDSenderNavigation)
                           .Include(o => o.IDReceiverNavigation)
                           .Where(o => (o.IDSender == IDUser && o.IDReceiver == idfriend) ||
                           (o.IDSender == idfriend && o.IDReceiver == IDUser)).OrderBy(s => s.RegDate).ToList();

            var result = (from msg in msgs
                          select new
                          {
                              sender = msg.IDSenderNavigation.Username,
                              receiver = msg.IDReceiverNavigation.Username,
                              text = msg.Message,
                              regdate = msg.RegDate,
                              type = (msg.IDSender == IDUser) ? "sent" : "received"
                          }).ToList();
            return Ok(result);
        }
        [HttpGet]
        public IActionResult GetAnoynmousProfileDetails(int id)
        {
            var user = _context.Users.Where(o => o.UserID == id).FirstOrDefault();
            var loggedinUserID = GetUserID();
            var isfollowing = _context.Friendlings.Where(o => o.User_ID == loggedinUserID && o.Friend_ID == id).Count() > 0 ? true : false;
            if (user != null)
            {
                var info = new
                {
                    name = user.FirstName + ' ' + user.LastName,
                    memberdate = user.CreatedAt.ToString("yyyy-MM-dd"),
                    isfollowing = isfollowing,
                    imagePath = user.ImagePath
                };
                return Ok(info);
            }
            return Ok(new object());
        }

        [HttpPost]
        [Authorize]
        public IActionResult SendMessage([FromBody] SendMesssageMode model)
        {
            try
            {
                ///RecepientUserID
                Messages msg = new Messages();
                msg.IDSender = GetUserID();
                msg.IDReceiver = model.RecepientUserID;
                msg.RegDate = DateTime.Now;
                msg.Message = model.Text;
                _context.Messages.Add(msg);
                _context.SaveChanges();

                return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Message Sent Sucessfully", new object()));
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }

    }
    public class SendMesssageMode
    {
        public string Text { get; set; }
        public int RecepientUserID { get; set; }
    }
}

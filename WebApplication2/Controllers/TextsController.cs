using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Text.RegularExpressions;
using WebApplication2.EntityFramework.Classes;
using WebApplication2.EntityFramework.Tables;
using WebApplication2.Enums;
using WebApplication2.Models;

namespace WebApplication2.Controllers
{
    public class TextsController : BaseController
    {
        private readonly GoodReadsDBContext _context;

        public TextsController(GoodReadsDBContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        private int CalculateRating(List<Ratings> ratings)
        {
            try
            {
                var ratingsvalues = (from r in ratings
                                     group r by new
                                     {
                                         r.Rating
                                     }
                                     into grp
                                     select new
                                     {
                                         weightValue = grp.Count() * grp.Key.Rating,
                                         totalRatings = grp.Count(),
                                         ratingValue = grp.Key.Rating
                                     }).ToList();
                return Convert.ToInt16(ratingsvalues.Sum(o => o.weightValue) / ratingsvalues.Sum(o => o.totalRatings));
            }
            catch
            {
                return 0;
            }
        }
        public IActionResult TextDetails(int id)
        {
            ViewBag.IDPassedText = id;
            return View("~/Views/Console/TextDetails.cshtml");
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetTextDetails(int id)
        {
            int loggedinuserid = GetUserID();
            var text = _context.Texts.Where(o => o.Text_ID == id)
                .Include(o => o.Ratings)
                .Include(o => o.IDPublisherNavigation)
                .Include(o => o.Text_States)
                .FirstOrDefault();
            var rating = CalculateRating(text.Ratings.ToList());
            var result = new
            {
                PublisherName = text.IDPublisherNavigation.Name,
                PublishedDate = text.Published_date.Value.ToString("yyyy-MM-dd"),
                Text = text.Description,
                IDText = text.Text_ID,
                PublisherID = text.IDPublisher,
                Title = text.Title,
                RatingsCount = text.Ratings.Count(),
                ReviewsCount = text.Reviews.Count(),
                imagePath = text.ImagePath,
                Rating = rating,
                yourratings = text.Ratings.Where(o => o.User_ID == loggedinuserid).Count() > 0 ?
                text.Ratings.Where(o => o.User_ID == loggedinuserid).FirstOrDefault().Rating : -1,
                statesids = text.Text_States.Where(o => o.User_ID == loggedinuserid).Select(o => o.IDState).Distinct().ToList()
            };
            return Ok(result);
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetReviewsAndComments(int textid)
        {
            try
            {
                int iduser = GetUserID();
                var comments = (from rev in _context.Reviews
                              .Include(o => o.Comments)
                              .Include(o => o.User)
                                where rev.Text_ID == textid
                                select new
                                {
                                    username = rev.User.Username,
                                    userid = rev.User_ID,
                                    id = rev.Review_ID,
                                    rev.Body,
                                    showdelete = iduser == rev.User_ID ? true : false,
                                    date = rev.Created_At.ToString("yyyy-MM-dd"),
                                    imagePath = rev.User.ImagePath,
                                    Comments = (from com in rev.Comments
                                                where com.Parent_comment_ID.HasValue == false
                                                select new
                                                {
                                                    id = com.Comment_ID,
                                                    username = com.User.Username,
                                                    imagePath = com.User.ImagePath,
                                                    userid = com.User_ID,
                                                    body = com.Body,
                                                    showdelete = iduser == com.User_ID ? true : false,
                                                    date = com.Created_At.ToString("yyyy-MM-dd"),
                                                    Replies = (from rep in _context.Comments
                                                               where rep.Parent_comment_ID == com.Comment_ID
                                                               select new
                                                               {
                                                                   id = rep.Comment_ID,
                                                                   username = rep.User.Username,
                                                                   imagePath = rep.User.ImagePath,
                                                                   useid = rep.User_ID,
                                                                   showdelete = iduser == rep.User_ID ? true : false,
                                                                   body = rep.Body,
                                                                   date = rep.Created_At.ToString("yyyy-MM-dd")
                                                               }).ToList()
                                                })

                                }).ToList();
                return Ok(comments);
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }
        [HttpPost]
        [Authorize]
        public IActionResult Interact([FromBody] InteractModel model)
        {
            try
            {
                Comments com = new Comments();
                com.Body = model.Text;
                com.ReviewID = model.ReviewID;
                com.Created_At = DateTime.Now;
                com.Updated_At = DateTime.Now;
                com.User_ID = GetUserID();
                if (model.Type == "Reply")
                    com.Parent_comment_ID = model.CommentID;
                _context.Comments.Add(com);
                _context.SaveChanges();

                return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Added Sucessfully", new object()));
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }

        [HttpPost]
        [Authorize]
        public IActionResult AddReview([FromBody] ReviewModel model)
        {
            try
            {
                Reviews r = new Reviews();
                r.Created_At = DateTime.Now;
                r.Updated_At = DateTime.Now;
                r.User_ID = GetUserID();
                r.Body = model.Text;
                r.Text_ID = model.TextID;
                r.Title = model.Title;
                _context.Reviews.Add(r);
                _context.SaveChanges();

                return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Review Added Sucessfully", new object()));
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }
        [HttpPost]
        [Authorize]
        public IActionResult RateText([FromBody] RateTextModel model)
        {
            try
            {
                Ratings r = new Ratings();
                r.Created_At = DateTime.Now;
                r.Updated_At = DateTime.Now;
                r.User_ID = GetUserID();
                r.Rating = model.RatingValue;
                r.Text_ID = model.TextID;
                _context.Ratings.Add(r);
                _context.SaveChanges();

                return Ok(new ResponseModel((int)ErrorCodesEnum.Success, model.RatingValue + " Star Rating was Added Sucessfully", new object()));
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }
        [HttpPost]
        [Authorize]
        public IActionResult AddTextState([FromBody] TextStateModel model)
        {
            try
            {
                Text_States r = new Text_States();
                r.Created_At = DateTime.Now;
                r.Updated_At = DateTime.Now;
                r.User_ID = GetUserID();
                r.IDState = model.IDState;
                r.Text_ID = model.TextID;
                _context.Text_States.Add(r);
                _context.SaveChanges();
                return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Added Sucessfully", new object()));
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }


        [HttpDelete]
        [Authorize]
        public IActionResult RemoveTextState([FromBody] TextStateModel model)
        {
            try
            {
                int userid = GetUserID();
                var states = _context.Text_States.Where(o => o.User_ID == userid && o.IDState == model.IDState).ToList();
                _context.Text_States.RemoveRange(states);
                _context.SaveChanges();
                return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Removed Sucessfully", new object()));
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }
        [HttpDelete]
        [Authorize]
        public IActionResult DeleteComment([FromBody] DeleteModel model)
        {
            try
            {
                var comments = _context.Comments.Where(o => o.Comment_ID == model.commentid || o.Parent_comment_ID == model.commentid
                ).ToList();
                _context.Comments.RemoveRange(comments);
                _context.SaveChanges();
                return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Removed Sucessfully", new object()));
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }
        [HttpDelete]
        [Authorize]
        public IActionResult DeleteReview([FromBody] DeleteModel model)
        {
            try
            {
                var reviews = _context.Reviews.Where(o => o.Review_ID == model.reviewid).ToList();
                var commentstobeldelect = _context.Comments.Where(o => o.ReviewID == model.reviewid).ToList();
                _context.Reviews.RemoveRange(reviews);
                _context.SaveChanges();
                _context.Comments.RemoveRange(commentstobeldelect);
                _context.SaveChanges();
                return Ok(new ResponseModel((int)ErrorCodesEnum.Success, "Removed Sucessfully", new object()));
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }

        [HttpGet]
        [Authorize]
        public IActionResult GetGenres()
        {
            var books = (from genre in _context.Genres
                         select new
                         {
                             ID = genre.Genre_ID,
                             Name = genre.Genre_Name
                         }).ToList();
            return Ok(books);
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetTexts()
        {
            try
            {
                int iduser = GetUserID();
                if (iduser == -1)
                    return View("~/Views/Home/Index.cshtml");

                var books = (from book in _context.Texts
                           .Include(o => o.Text_Genres)
                           .Include(o => o.Reviews)
                           .Include(o => o.Ratings)
                           .Include(o => o.Text_States)
                             select new
                             {
                                 ID = book.Text_ID,
                                 Title = book.Title,
                                 Date = book.Created_At.ToString("yyyy-MM-dd"),
                                 Text = book.Description,
                                 Genre = book.Text_Genres.Select(o => o.Genre.Genre_Name).ToList(),
                                 RatingsCount = book.Ratings.Count(),
                                 ReviewsCount = book.Reviews.Count(),
                                 imagePath = book.ImagePath,
                                 PublisherName = book.IDPublisherNavigation.Name,
                                 statesids = book.Text_States.Where(o => o.User_ID == iduser).Select(o => o.IDState).Distinct().ToList()
                             }).ToList();
                return Ok(books);
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetTextsByGenre(int IDGenre)
        {
            int iduser = GetUserID();
            var books = (from book in _context.Texts
                       .Include(o => o.Text_Genres)
                       .Include(o => o.IDPublisherNavigation)
                       .Include(o => o.Ratings)
                       .Where(o => o.Text_Genres.Select(p => p.Genre_ID).Contains(IDGenre))
                         select new
                         {
                             ID = book.Text_ID,
                             Title = book.Title,
                             Text = book.Description,
                             Genre = book.Text_Genres.Select(o => o.Genre.Genre_Name).ToList(),
                             RatingsCount = book.Ratings.Count(),
                             ReviewsCount = book.Reviews.Count(),
                             imagePath = book.ImagePath,
                             PublisherName = book.IDPublisherNavigation.Name,
                             Date = book.Created_At.ToString("yyyy-MM-dd"),
                             statesids = book.Text_States.Where(o => o.User_ID == iduser).Select(o => o.IDState).Distinct().ToList()
                         }).ToList();
            return Ok(books);
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetPopularTexts()
        {
            var alltexts = _context.Texts.Include(o => o.Text_Genres)
                                         .Include(o => o.IDPublisherNavigation)
                                         .Include(o => o.Ratings).ToList();
            var books = (from book in alltexts
                        .OrderBy(p => CalculateRating(p.Ratings.ToList())).Take(3)
                         select new
                         {
                             id = book.Text_ID,
                             Title = book.Title,
                             PublishedDate = book.Published_date.Value.ToString("yyyy-MM-dd"),
                             rating = CalculateRating(book.Ratings.ToList()),
                             imagePath = book.ImagePath,
                             PublisherName = book.IDPublisherNavigation.Name
                         }).OrderByDescending(o => o.rating).ToList();
            return Ok(books);
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetTextsForUser()
        {
            try
            {
                int LoggedInUserID = GetUserID();
                var books = (from book in _context.Text_States
                           .Include(o => o.Text)
                           .Include(o => o.Text.Reviews)
                           .Include(o => o.Text.Ratings)
                           .Include(o => o.Text.Text_States)
                           .Include(o => o.Text.Text_Genres)
                             where book.User_ID == LoggedInUserID
                             select new
                             {
                                 ID = book.Text_ID,
                                 Title = book.Text.Title,
                                 Date = book.Created_At.ToString("yyyy-MM-dd"),
                                 Text = book.Text.Description,
                                 Genre = book.Text.Text_Genres.Select(o => o.Genre.Genre_Name).ToList(),
                                 RatingsCount = book.Text.Ratings.Count(),
                                 ReviewsCount = book.Text.Reviews.Count(),
                                 imagePath = book.Text.ImagePath,
                                 PublisherName = book.Text.IDPublisherNavigation.Name,
                                 statesids = book.Text.Text_States.Where(o => o.User_ID == LoggedInUserID).Select(o => o.IDState).Distinct().ToList()
                             }).ToList();
                return Ok(books);
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetTextsForUserByState(int idstate)
        {
            try
            {
                int LoggedInUserID = GetUserID();
                var books = (from book in _context.Text_States
                           .Include(o => o.Text)
                           .Include(o => o.Text.Reviews)
                           .Include(o => o.Text.Ratings)
                           .Include(o => o.Text.Text_States)
                           .Include(o => o.Text.Text_Genres)
                             where book.User_ID == LoggedInUserID
                             && book.IDState == idstate
                             select new
                             {
                                 ID = book.Text_ID,
                                 Title = book.Text.Title,
                                 Date = book.Created_At.ToString("yyyy-MM-dd"),
                                 Text = book.Text.Description,
                                 Genre = book.Text.Text_Genres.Select(o => o.Genre.Genre_Name).ToList(),
                                 RatingsCount = book.Text.Ratings.Count(),
                                 ReviewsCount = book.Text.Reviews.Count(),
                                 imagePath = book.Text.ImagePath,
                                 PublisherName = book.Text.IDPublisherNavigation.Name,
                                 State = book.IDStateNavigation.Name,
                                 statesids = book.Text.Text_States.Where(o => o.User_ID == LoggedInUserID).Select(o => o.IDState).Distinct().ToList()
                             }).ToList();
                return Ok(books);
            }
            catch (Exception ex)
            {
                return NoContent();
            }
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetPopularTextsByGenre(int genreId)
        {
            var alltexts = _context.Texts.Include(o => o.Text_Genres)
                        .Include(o => o.IDPublisherNavigation)
                        .Include(o => o.Ratings).ToList();
            var books = (from book in alltexts
                        .Where(o => o.Text_Genres.Select(p => p.Genre_ID).Contains(genreId))
                        .OrderBy(p => CalculateRating(p.Ratings.ToList()))
                         select new
                         {
                             ID = book.Text_ID,
                             Title = book.Title,
                             PublishedDate = book.Published_date.Value.ToString("yyyy-MM-dd"),
                             rating = CalculateRating(book.Ratings.ToList()),
                             PublisherName = book.IDPublisherNavigation.Name// update when updatong the model
                         }).ToList();
            return Ok(books);
        }


        [HttpPost]
        [Authorize]
        public IActionResult Search([FromBody] TextModel Text)
        {
            if (string.IsNullOrEmpty(Text.Text))
            {
                return GetTexts();
            }
            int loggedinuserid = GetUserID();
            MatchCollection matches = Regex.Matches(Text.Text, @"\b[\w']*\b");

            var words = from m in matches.Cast<Match>()
                        where !string.IsNullOrEmpty(m.Value)
                        select TrimSuffix(m.Value);
            var wordslist = words.ToList();
            List<Texts> matchingWholeTitle = new List<Texts>();
            List<Texts> matchingAny = new List<Texts>();

            #region Get Texts Matching Whole sentence

            matchingWholeTitle = _context.Texts
                   .Include(o => o.Text_Genres).ThenInclude(g => g.Genre)
                   .Where(stringToCheck => stringToCheck.Title.ToLower().Contains(Text.Text.Trim().ToLower())).ToList();

            #endregion

            #region Get TExts matching title any word

            foreach (string w in wordslist)
            {
                var matchinganywordtext = _context.Texts
                    .Include(o => o.Text_Genres).ThenInclude(g => g.Genre)
                    .Where(text => text.Title.ToLower().Contains(w.ToLower()) && !matchingWholeTitle.Select(o => o.Text_ID).ToList().Contains(text.Text_ID));
                var matching = matchinganywordtext.Where(o => !matchingWholeTitle.Select(o => o.Text_ID).ToList().Contains(o.Text_ID)).ToList();
                matchingAny.AddRange(matching);
            }
            #endregion 

            var books = (from book in matchingWholeTitle.Concat(matchingAny).Distinct()
                         select new
                         {
                             ID = book.Text_ID,
                             Title = book.Title,
                             Text = book.Description,
                             Genre = book.Text_Genres.Select(o => o.Genre.Genre_Name).ToList(),
                             Date = book.Created_At.ToString("yyyy-MM-dd"),
                             imagePath = book.ImagePath,
                             statesids = book.Text_States.Where(o => o.User_ID == loggedinuserid).Select(o => o.IDState).Distinct().ToList()
                         }).ToList();

            return Ok(books)
;
        }
        [HttpPost]
        [Authorize]
        [HttpPost]
        [HttpPost]
        public IActionResult SearchUserTexts([FromBody] TextModel Text)
        {
            List<Texts> anytexts = new List<Texts>();
            List<Texts> matchingWhole = new List<Texts>();

            int iduser = GetUserID();
            #region  matching  whole  title

            matchingWhole = _context.Text_States
                    .Include(o => o.Text)
                    .Include(o => o.Text.Text_Genres)
                    .ThenInclude(g => g.Genre)
                    .Where(text => text.Text.Title.Contains(Text.Text.Trim().ToLower()) && text.User_ID == iduser).Select(t => t.Text).ToList();

            #endregion

            #region  matching  any word

            MatchCollection matches = Regex.Matches(Text.Text, @"\b[\w']*\b");
            var words = from m in matches.Cast<Match>()
                        where !string.IsNullOrEmpty(m.Value)
                        select TrimSuffix(m.Value);
            var wordslist = words.ToList();
            List<Texts> final = new List<Texts>();
            foreach (string w in wordslist)
            {
                var matchingvalues = _context.Text_States
                    .Include(o => o.Text)
                    .Include(o => o.Text.Text_Genres)
                    .Where(s => s.Text.Title.Contains(w) && s.User_ID == iduser && !matchingWhole.Select(o => o.Text_ID).ToList().Contains(s.Text_ID)).Select(t => t.Text).ToList();
                anytexts.AddRange(matchingvalues);
            }

            #endregion

            var books = (from book in matchingWhole.Concat(anytexts)
                         select new
                         {
                             ID = book.Text_ID,
                             Title = book.Title,
                             Text = book.Description,
                             Genre = book.Text_Genres.Select(o => o.Genre.Genre_Name).ToList(),
                             Date = book.Created_At.ToString("yyyy-MM-dd"),
                             imagePath = book.ImagePath,
                             statesids = book.Text_States.Where(o => o.User_ID == iduser).Select(o => o.IDState).Distinct().ToList()
                         }).ToList();

            return Ok(books);
        }
        static string TrimSuffix(string word)
        {
            int apostropheLocation = word.IndexOf('\'');
            if (apostropheLocation != -1)
            {
                word = word.Substring(0, apostropheLocation);
            }

            return word;
        }
        public class TextModel
        {
            public string Text { get; set; }
        }
        public class InteractModel
        {
            public string Text { get; set; }
            public string Type { get; set; }

            public int ReviewID { get; set; }
            public int CommentID { get; set; }
        }
        public class RateTextModel
        {
            public int TextID { get; set; }
            public int RatingValue { get; set; }

            public int ReviewID { get; set; }
            public int CommentID { get; set; }
        }
        public class DeleteModel
        {
            public int commentid { get; set; }
            public int reviewid { get; set; }

        }
        public class TextStateModel
        {
            public int IDState { get; set; }
            public int TextID { get; set; }
        }
        public class ReviewModel
        {
            public string Text { get; set; }
            public int TextID { get; set; }
            public string Title { get; set; }

        }

    }
}

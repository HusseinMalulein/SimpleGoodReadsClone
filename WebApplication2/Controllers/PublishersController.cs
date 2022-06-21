using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;
using WebApplication2.EntityFramework.Classes;

namespace WebApplication2.Controllers
{
    public class PublishersController : BaseController
    {

        private readonly GoodReadsDBContext _context;

        public PublishersController(GoodReadsDBContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetTextsForPublisher(int id)
        {
            var books = (from book in _context.Texts
                       .Include(o => o.Text_Genres)
                       .Where(o => o.IDPublisher == id)
                         select new
                         {
                             ID = book.Text_ID,
                             Title = book.Title,
                             Text = book.Description,
                             publishedDate = book.Created_At.Date.ToString("yyyy-MM-dd")
                         }).ToList();
            return Ok(books);
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetProfileDetailsForPublisher(int id)
        {
            var publisher = _context.Publishers.Where(o => o.Publisher_ID == id).Include(o => o.Texts).FirstOrDefault();
            var publisherDetails = new
            {
                TextsCount = publisher.Texts.Count(),
                publisherName = publisher.Name,
                publisher.City,
                joinedDate = publisher.Created_At.ToString("yyyy-MM-dd")
            };
            return Ok(publisherDetails);
        }
    }
}

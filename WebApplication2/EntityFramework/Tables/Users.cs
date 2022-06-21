using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Users
    {
        public Users()
        {
            Comments = new HashSet<Comments>();
            FriendlingsFriend = new HashSet<Friendlings>();
            FriendlingsUser = new HashSet<Friendlings>();
            MessagesIDReceiverNavigation = new HashSet<Messages>();
            MessagesIDSenderNavigation = new HashSet<Messages>();
            Ratings = new HashSet<Ratings>();
            Reviews = new HashSet<Reviews>();
            Text_States = new HashSet<Text_States>();
        }

        public int UserID { get; set; }
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public DateTime? Birthdate { get; set; }
        public string Gender { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public string ImagePath { get; set; }
        public bool isauthor { get; set; }

        public virtual ICollection<Comments> Comments { get; set; }
        public virtual ICollection<Friendlings> FriendlingsFriend { get; set; }
        public virtual ICollection<Friendlings> FriendlingsUser { get; set; }
        public virtual ICollection<Messages> MessagesIDReceiverNavigation { get; set; }
        public virtual ICollection<Messages> MessagesIDSenderNavigation { get; set; }
        public virtual ICollection<Ratings> Ratings { get; set; }
        public virtual ICollection<Reviews> Reviews { get; set; }
        public virtual ICollection<Text_States> Text_States { get; set; }
    }
}

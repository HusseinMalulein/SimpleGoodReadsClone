using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Texts
    {
        public Texts()
        {
            Ratings = new HashSet<Ratings>();
            Reviews = new HashSet<Reviews>();
            Text_Authors = new HashSet<Text_Authors>();
            Text_Genres = new HashSet<Text_Genres>();
            Text_States = new HashSet<Text_States>();
        }

        public int Text_ID { get; set; }
        public int? IDPublisher { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime? Published_date { get; set; }
        public DateTime Created_At { get; set; }
        public DateTime Updated_At { get; set; }
        public string ImagePath { get; set; }

        public virtual Publishers IDPublisherNavigation { get; set; }
        public virtual ICollection<Ratings> Ratings { get; set; }
        public virtual ICollection<Reviews> Reviews { get; set; }
        public virtual ICollection<Text_Authors> Text_Authors { get; set; }
        public virtual ICollection<Text_Genres> Text_Genres { get; set; }
        public virtual ICollection<Text_States> Text_States { get; set; }
    }
}

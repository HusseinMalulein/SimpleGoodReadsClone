using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Reviews
    {
        public Reviews()
        {
            Comments = new HashSet<Comments>();
        }

        public int Review_ID { get; set; }
        public int User_ID { get; set; }
        public int Text_ID { get; set; }
        public string Title { get; set; }
        public string Body { get; set; }
        public DateTime Created_At { get; set; }
        public DateTime Updated_At { get; set; }

        public virtual Texts Text { get; set; }
        public virtual Users User { get; set; }
        public virtual ICollection<Comments> Comments { get; set; }
    }
}

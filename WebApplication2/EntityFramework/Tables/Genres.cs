using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Genres
    {
        public Genres()
        {
            Text_Genres = new HashSet<Text_Genres>();
        }

        public int Genre_ID { get; set; }
        public string Genre_Name { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public virtual ICollection<Text_Genres> Text_Genres { get; set; }
    }
}

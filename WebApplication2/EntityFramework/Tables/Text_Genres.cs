using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Text_Genres
    {
        public int Text_Genre_ID { get; set; }
        public int Text_ID { get; set; }
        public int Genre_ID { get; set; }
        public DateTime Created_At { get; set; }
        public DateTime Updated_At { get; set; }

        public virtual Genres Genre { get; set; }
        public virtual Texts Text { get; set; }
    }
}

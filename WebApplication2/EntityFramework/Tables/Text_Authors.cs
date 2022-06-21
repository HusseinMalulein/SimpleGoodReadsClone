using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Text_Authors
    {
        public int Text_Author_ID { get; set; }
        public int Text_ID { get; set; }
        public int Author_ID { get; set; }
        public DateTime Created_At { get; set; }
        public DateTime Updated_At { get; set; }

        public virtual Texts Text { get; set; }
    }
}

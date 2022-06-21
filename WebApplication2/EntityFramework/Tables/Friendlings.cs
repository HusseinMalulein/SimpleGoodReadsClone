using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Friendlings
    {
        public int Friendlings_ID { get; set; }
        public int User_ID { get; set; }
        public int Friend_ID { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }

        public virtual Users Friend { get; set; }
        public virtual Users User { get; set; }
    }
}

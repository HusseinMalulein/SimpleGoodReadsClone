﻿using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Ratings
    {
        public int Rating_ID { get; set; }
        public int User_ID { get; set; }
        public int Text_ID { get; set; }
        public int Rating { get; set; }
        public DateTime Created_At { get; set; }
        public DateTime Updated_At { get; set; }

        public virtual Texts Text { get; set; }
        public virtual Users User { get; set; }
    }
}

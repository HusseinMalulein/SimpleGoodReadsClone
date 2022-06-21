using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Publishers
    {
        public Publishers()
        {
            Texts = new HashSet<Texts>();
        }

        public int Publisher_ID { get; set; }
        public string Name { get; set; }
        public string City { get; set; }
        public DateTime Created_At { get; set; }
        public DateTime Updated_At { get; set; }

        public virtual ICollection<Texts> Texts { get; set; }
    }
}

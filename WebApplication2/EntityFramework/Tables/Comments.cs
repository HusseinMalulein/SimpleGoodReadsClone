using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Comments
    {
        public Comments()
        {
            InverseParent_comment = new HashSet<Comments>();
        }

        public int Comment_ID { get; set; }
        public int? Parent_comment_ID { get; set; }
        public int? ReviewID { get; set; }
        public int User_ID { get; set; }
        public string Body { get; set; }
        public DateTime Updated_At { get; set; }
        public DateTime Created_At { get; set; }

        public virtual Comments Parent_comment { get; set; }
        public virtual Reviews Review { get; set; }
        public virtual Users User { get; set; }
        public virtual ICollection<Comments> InverseParent_comment { get; set; }
    }
}

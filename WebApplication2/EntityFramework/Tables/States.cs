using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class States
    {
        public States()
        {
            Text_States = new HashSet<Text_States>();
        }

        public int ID { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Text_States> Text_States { get; set; }
    }
}

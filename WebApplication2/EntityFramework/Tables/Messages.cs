using System;
using System.Collections.Generic;

namespace WebApplication2.EntityFramework.Tables
{
    public partial class Messages
    {
        public int ID { get; set; }
        public int IDSender { get; set; }
        public int IDReceiver { get; set; }
        public string Message { get; set; }
        public DateTime RegDate { get; set; }

        public virtual Users IDReceiverNavigation { get; set; }
        public virtual Users IDSenderNavigation { get; set; }
    }
}

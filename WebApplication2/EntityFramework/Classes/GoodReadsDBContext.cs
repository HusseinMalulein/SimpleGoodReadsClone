using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using WebApplication2.EntityFramework.Tables;

namespace WebApplication2.EntityFramework.Classes
{
    public partial class GoodReadsDBContext : DbContext
    {
        public virtual DbSet<Comments> Comments { get; set; }
        public virtual DbSet<Friendlings> Friendlings { get; set; }
        public virtual DbSet<Genres> Genres { get; set; }
        public virtual DbSet<Messages> Messages { get; set; }
        public virtual DbSet<Publishers> Publishers { get; set; }
        public virtual DbSet<Ratings> Ratings { get; set; }
        public virtual DbSet<Reviews> Reviews { get; set; }
        public virtual DbSet<States> States { get; set; }
        public virtual DbSet<Text_Authors> Text_Authors { get; set; }
        public virtual DbSet<Text_Genres> Text_Genres { get; set; }
        public virtual DbSet<Text_States> Text_States { get; set; }
        public virtual DbSet<Texts> Texts { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        public GoodReadsDBContext(DbContextOptions<GoodReadsDBContext> options) : base(options)
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=Goodreads_Clone_DB;Persist Security Info=True;User ID=sa;Password=YourStrong**Passw0rd;Trust Server Certificate=True;Command Timeout=300");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Comments>(entity =>
            {
                entity.HasKey(e => e.Comment_ID);

                entity.HasIndex(e => e.User_ID, "Index_Comment_on_User_ID");

                entity.HasIndex(e => e.Parent_comment_ID, "Index_on_Parent_comment_ID");

                entity.Property(e => e.Body)
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.Created_At).HasColumnType("datetime");

                entity.Property(e => e.Updated_At).HasColumnType("datetime");

                entity.HasOne(d => d.Parent_comment)
                    .WithMany(p => p.InverseParent_comment)
                    .HasForeignKey(d => d.Parent_comment_ID)
                    .HasConstraintName("FK_Comments_Comments");

                entity.HasOne(d => d.Review)
                    .WithMany(p => p.Comments)
                    .HasForeignKey(d => d.ReviewID)
                    .HasConstraintName("FK_Comments_Reviews");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Comments)
                    .HasForeignKey(d => d.User_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Comments_Users");
            });

            modelBuilder.Entity<Friendlings>(entity =>
            {
                entity.HasKey(e => e.Friendlings_ID);

                entity.HasIndex(e => e.Friend_ID, "IX_Friendlings_Friend_ID");

                entity.HasIndex(e => new { e.Friend_ID, e.User_ID }, "IX_Friendlings_Friend_ID_User_ID");

                entity.HasIndex(e => e.User_ID, "IX_Friendlings_User_ID");

                entity.Property(e => e.Created_at).HasColumnType("datetime");

                entity.Property(e => e.Updated_at).HasColumnType("datetime");

                entity.HasOne(d => d.Friend)
                    .WithMany(p => p.FriendlingsFriend)
                    .HasForeignKey(d => d.Friend_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Friendlings_Followed");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.FriendlingsUser)
                    .HasForeignKey(d => d.User_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Friendlings_LoggedUser");
            });

            modelBuilder.Entity<Genres>(entity =>
            {
                entity.HasKey(e => e.Genre_ID);

                entity.HasIndex(e => e.Genre_Name, "IsUnique_Genre")
                    .IsUnique();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.Genre_Name)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");
            });

            modelBuilder.Entity<Messages>(entity =>
            {
                entity.Property(e => e.Message)
                    .IsRequired()
                    .HasColumnType("text");

                entity.Property(e => e.RegDate).HasColumnType("datetime");

                entity.HasOne(d => d.IDReceiverNavigation)
                    .WithMany(p => p.MessagesIDReceiverNavigation)
                    .HasForeignKey(d => d.IDReceiver)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Messages_ReceiverUsers");

                entity.HasOne(d => d.IDSenderNavigation)
                    .WithMany(p => p.MessagesIDSenderNavigation)
                    .HasForeignKey(d => d.IDSender)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Messages_SenderUsers");
            });

            modelBuilder.Entity<Publishers>(entity =>
            {
                entity.HasKey(e => e.Publisher_ID);

                entity.Property(e => e.City)
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.Created_At).HasColumnType("datetime");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(150)
                    .IsUnicode(false);

                entity.Property(e => e.Updated_At).HasColumnType("datetime");
            });

            modelBuilder.Entity<Ratings>(entity =>
            {
                entity.HasKey(e => e.Rating_ID);

                entity.HasIndex(e => e.Text_ID, "index_ratings_on_text_id");

                entity.HasIndex(e => e.User_ID, "index_ratings_on_user_id");

                entity.HasIndex(e => new { e.Text_ID, e.User_ID }, "index_ratings_on_user_id_and_text_id");

                entity.Property(e => e.Created_At).HasColumnType("datetime");

                entity.Property(e => e.Updated_At).HasColumnType("datetime");

                entity.HasOne(d => d.Text)
                    .WithMany(p => p.Ratings)
                    .HasForeignKey(d => d.Text_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Ratings_Text");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Ratings)
                    .HasForeignKey(d => d.User_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Ratings_Users");
            });

            modelBuilder.Entity<Reviews>(entity =>
            {
                entity.HasKey(e => e.Review_ID);

                entity.HasIndex(e => e.User_ID, "index_Reviews_On_User_ID");

                entity.HasIndex(e => e.Text_ID, "index_reviews_on_text_id");

                entity.HasIndex(e => new { e.User_ID, e.Text_ID }, "index_reviews_on_user_id_and_text_id");

                entity.Property(e => e.Body)
                    .HasMaxLength(2000)
                    .IsUnicode(false);

                entity.Property(e => e.Created_At).HasColumnType("datetime");

                entity.Property(e => e.Title)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Updated_At).HasColumnType("datetime");

                entity.HasOne(d => d.Text)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.Text_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Reviews_Texts");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.User_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Reviews_Users");
            });

            modelBuilder.Entity<States>(entity =>
            {
                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(250)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Text_Authors>(entity =>
            {
                entity.HasKey(e => e.Text_Author_ID);

                entity.HasIndex(e => e.Author_ID, "IX_Text_Authors_Author_ID");

                entity.HasIndex(e => new { e.Author_ID, e.Text_ID }, "IX_Text_Authors_Author_ID_and_Text_ID");

                entity.HasIndex(e => e.Text_ID, "IX_Text_Authors_Text_ID");

                entity.Property(e => e.Created_At).HasColumnType("datetime");

                entity.Property(e => e.Updated_At).HasColumnType("datetime");

                entity.HasOne(d => d.Text)
                    .WithMany(p => p.Text_Authors)
                    .HasForeignKey(d => d.Text_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Text_Authors_Texts");
            });

            modelBuilder.Entity<Text_Genres>(entity =>
            {
                entity.HasKey(e => e.Text_Genre_ID);

                entity.HasIndex(e => e.Text_ID, "IX_Text_Genre_Text_ID");

                entity.HasIndex(e => e.Genre_ID, "index_text_genre_on_user_id");

                entity.HasIndex(e => new { e.Text_ID, e.Genre_ID }, "index_text_genres_on_text_id_and_genre_id")
                    .IsUnique();

                entity.Property(e => e.Created_At).HasColumnType("datetime");

                entity.Property(e => e.Updated_At).HasColumnType("datetime");

                entity.HasOne(d => d.Genre)
                    .WithMany(p => p.Text_Genres)
                    .HasForeignKey(d => d.Genre_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Text_Genres_Genres");

                entity.HasOne(d => d.Text)
                    .WithMany(p => p.Text_Genres)
                    .HasForeignKey(d => d.Text_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Text_Genres_Texts");
            });

            modelBuilder.Entity<Text_States>(entity =>
            {
                entity.HasIndex(e => e.Text_ID, "Index_TextState_Text_ID");

                entity.HasIndex(e => e.User_ID, "Index_TextState_User-ID");

                entity.HasIndex(e => new { e.User_ID, e.Text_ID }, "Index_on_User_ID_and_Text_ID")
                    .IsUnique();

                entity.Property(e => e.Created_At).HasColumnType("datetime");

                entity.Property(e => e.Updated_At).HasColumnType("datetime");

                entity.HasOne(d => d.IDStateNavigation)
                    .WithMany(p => p.Text_States)
                    .HasForeignKey(d => d.IDState)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Text_States_States");

                entity.HasOne(d => d.Text)
                    .WithMany(p => p.Text_States)
                    .HasForeignKey(d => d.Text_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Text_States_Texs");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Text_States)
                    .HasForeignKey(d => d.User_ID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Text_States_Users");
            });

            modelBuilder.Entity<Texts>(entity =>
            {
                entity.HasKey(e => e.Text_ID);

                entity.HasIndex(e => e.Title, "IsUnique_Title")
                    .IsUnique();

                entity.Property(e => e.Created_At).HasColumnType("datetime");

                entity.Property(e => e.Description)
                    .HasMaxLength(2000)
                    .IsUnicode(false);

                entity.Property(e => e.ImagePath)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.Published_date).HasColumnType("date");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Updated_At).HasColumnType("datetime");

                entity.HasOne(d => d.IDPublisherNavigation)
                    .WithMany(p => p.Texts)
                    .HasForeignKey(d => d.IDPublisher)
                    .HasConstraintName("FK_Texts_Publishers");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.UserID);

                entity.HasIndex(e => e.Email, "IsUnique_email")
                    .IsUnique();

                entity.HasIndex(e => e.Username, "IsUnique_username")
                    .IsUnique();

                entity.Property(e => e.Birthdate).HasColumnType("date");

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(70)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Gender)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ImagePath)
                    .HasMaxLength(350)
                    .IsUnicode(false);

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(70)
                    .IsUnicode(false);

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(70)
                    .IsUnicode(false);

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.Username)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}

USE [master]
GO
/****** Object:  Database [Goodreads_Clone_DB]    Script Date: 6/20/2022 9:25:16 PM ******/
CREATE DATABASE [Goodreads_Clone_DB]
 CONTAINMENT = NONE
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Goodreads_Clone_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Goodreads_Clone_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Goodreads_Clone_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET  MULTI_USER 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Goodreads_Clone_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Goodreads_Clone_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Goodreads_Clone_DB] SET QUERY_STORE = OFF
GO
USE [Goodreads_Clone_DB]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Comment_ID] [int] IDENTITY(1,1) NOT NULL,
	[Parent_comment_ID] [int] NULL,
	[ReviewID] [int] NULL,
	[User_ID] [int] NOT NULL,
	[Body] [varchar](1000) NULL,
	[Updated_At] [datetime] NOT NULL,
	[Created_At] [datetime] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Comment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Friendlings]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friendlings](
	[Friendlings_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_ID] [int] NOT NULL,
	[Friend_ID] [int] NOT NULL,
	[Created_at] [datetime] NOT NULL,
	[Updated_at] [datetime] NOT NULL,
 CONSTRAINT [PK_Friendlings] PRIMARY KEY CLUSTERED 
(
	[Friendlings_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Genre_ID] [int] IDENTITY(1,1) NOT NULL,
	[Genre_Name] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_Genres] PRIMARY KEY CLUSTERED 
(
	[Genre_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDSender] [int] NOT NULL,
	[IDReceiver] [int] NOT NULL,
	[Message] [text] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publishers]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publishers](
	[Publisher_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[City] [varchar](150) NULL,
	[Created_At] [datetime] NOT NULL,
	[Updated_At] [datetime] NOT NULL,
 CONSTRAINT [PK_Publishers] PRIMARY KEY CLUSTERED 
(
	[Publisher_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[Rating_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_ID] [int] NOT NULL,
	[Text_ID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Created_At] [datetime] NOT NULL,
	[Updated_At] [datetime] NOT NULL,
 CONSTRAINT [PK_Ratings] PRIMARY KEY CLUSTERED 
(
	[Rating_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[Review_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_ID] [int] NOT NULL,
	[Text_ID] [int] NOT NULL,
	[Title] [varchar](200) NULL,
	[Body] [varchar](2000) NULL,
	[Created_At] [datetime] NOT NULL,
	[Updated_At] [datetime] NOT NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[Review_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NOT NULL,
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Text_Authors]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Text_Authors](
	[Text_Author_ID] [int] IDENTITY(1,1) NOT NULL,
	[Text_ID] [int] NOT NULL,
	[Author_ID] [int] NOT NULL,
	[Created_At] [datetime] NOT NULL,
	[Updated_At] [datetime] NOT NULL,
 CONSTRAINT [PK_Text_Authors] PRIMARY KEY CLUSTERED 
(
	[Text_Author_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Text_Genres]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Text_Genres](
	[Text_Genre_ID] [int] IDENTITY(1,1) NOT NULL,
	[Text_ID] [int] NOT NULL,
	[Genre_ID] [int] NOT NULL,
	[Created_At] [datetime] NOT NULL,
	[Updated_At] [datetime] NOT NULL,
 CONSTRAINT [PK_Text_Genres] PRIMARY KEY CLUSTERED 
(
	[Text_Genre_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Text_States]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Text_States](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Text_ID] [int] NOT NULL,
	[User_ID] [int] NOT NULL,
	[IDState] [int] NOT NULL,
	[Created_At] [datetime] NOT NULL,
	[Updated_At] [datetime] NOT NULL,
 CONSTRAINT [PK_Text_States] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Texts]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Texts](
	[Text_ID] [int] IDENTITY(1,1) NOT NULL,
	[IDPublisher] [int] NULL,
	[Title] [varchar](200) NOT NULL,
	[Description] [varchar](2000) NULL,
	[Published_date] [date] NULL,
	[Created_At] [datetime] NOT NULL,
	[Updated_At] [datetime] NOT NULL,
	[ImagePath] [varchar](500) NULL,
 CONSTRAINT [PK_Texts] PRIMARY KEY CLUSTERED 
(
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/20/2022 9:25:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](70) NOT NULL,
	[Password] [varchar](70) NOT NULL,
	[Email] [varchar](70) NOT NULL,
	[Birthdate] [date] NULL,
	[Gender] [varchar](50) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[ImagePath] [varchar](350) NULL,
	[isauthor] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([Comment_ID], [Parent_comment_ID], [ReviewID], [User_ID], [Body], [Updated_At], [Created_At]) VALUES (9, NULL, 3, 1, N'I agree with everything you said', CAST(N'2022-06-19T16:15:41.730' AS DateTime), CAST(N'2022-06-19T16:15:41.730' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[Friendlings] ON 

INSERT [dbo].[Friendlings] ([Friendlings_ID], [User_ID], [Friend_ID], [Created_at], [Updated_at]) VALUES (3, 1003, 1, CAST(N'2022-06-11T18:43:34.880' AS DateTime), CAST(N'2022-06-11T18:43:34.880' AS DateTime))
INSERT [dbo].[Friendlings] ([Friendlings_ID], [User_ID], [Friend_ID], [Created_at], [Updated_at]) VALUES (8, 1, 1003, CAST(N'2022-06-19T02:38:26.323' AS DateTime), CAST(N'2022-06-19T02:38:26.323' AS DateTime))
INSERT [dbo].[Friendlings] ([Friendlings_ID], [User_ID], [Friend_ID], [Created_at], [Updated_at]) VALUES (9, 1, 1004, CAST(N'2022-06-19T16:21:09.647' AS DateTime), CAST(N'2022-06-19T16:21:09.647' AS DateTime))
INSERT [dbo].[Friendlings] ([Friendlings_ID], [User_ID], [Friend_ID], [Created_at], [Updated_at]) VALUES (10, 1003, 1004, CAST(N'2022-06-19T16:49:37.213' AS DateTime), CAST(N'2022-06-19T16:49:37.213' AS DateTime))
INSERT [dbo].[Friendlings] ([Friendlings_ID], [User_ID], [Friend_ID], [Created_at], [Updated_at]) VALUES (11, 1003, 1005, CAST(N'2022-06-20T20:57:52.837' AS DateTime), CAST(N'2022-06-20T20:57:52.837' AS DateTime))
SET IDENTITY_INSERT [dbo].[Friendlings] OFF
GO
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([Genre_ID], [Genre_Name], [CreatedAt], [UpdatedAt]) VALUES (1, N'Horror', CAST(N'2021-12-12T00:00:00.000' AS DateTime), CAST(N'2022-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Genres] ([Genre_ID], [Genre_Name], [CreatedAt], [UpdatedAt]) VALUES (2, N'Fantasy', CAST(N'2022-04-04T00:00:00.000' AS DateTime), CAST(N'2022-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Genres] ([Genre_ID], [Genre_Name], [CreatedAt], [UpdatedAt]) VALUES (4, N'Crime', CAST(N'2022-04-04T00:00:00.000' AS DateTime), CAST(N'2022-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Genres] ([Genre_ID], [Genre_Name], [CreatedAt], [UpdatedAt]) VALUES (10, N'Children', CAST(N'2022-04-04T00:00:00.000' AS DateTime), CAST(N'2022-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Genres] ([Genre_ID], [Genre_Name], [CreatedAt], [UpdatedAt]) VALUES (12, N'War', CAST(N'2022-04-04T00:00:00.000' AS DateTime), CAST(N'2022-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Genres] ([Genre_ID], [Genre_Name], [CreatedAt], [UpdatedAt]) VALUES (13, N'Romance', CAST(N'2022-04-04T00:00:00.000' AS DateTime), CAST(N'2022-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Genres] ([Genre_ID], [Genre_Name], [CreatedAt], [UpdatedAt]) VALUES (14, N'Pschology', CAST(N'2022-04-05T00:00:00.000' AS DateTime), CAST(N'2022-04-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Genres] ([Genre_ID], [Genre_Name], [CreatedAt], [UpdatedAt]) VALUES (15, N'Educational', CAST(N'2022-06-06T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Genres] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([ID], [IDSender], [IDReceiver], [Message], [RegDate]) VALUES (1, 1, 1003, N'Hello', CAST(N'2022-06-11T20:19:59.800' AS DateTime))
INSERT [dbo].[Messages] ([ID], [IDSender], [IDReceiver], [Message], [RegDate]) VALUES (2, 1003, 1, N'Hi', CAST(N'2022-06-11T20:29:59.800' AS DateTime))
INSERT [dbo].[Messages] ([ID], [IDSender], [IDReceiver], [Message], [RegDate]) VALUES (3, 1, 1003, N'Do you recommend any book?', CAST(N'2022-06-19T02:37:53.093' AS DateTime))
INSERT [dbo].[Messages] ([ID], [IDSender], [IDReceiver], [Message], [RegDate]) VALUES (4, 1, 1003, N'I want to read a new book', CAST(N'2022-06-19T16:23:13.133' AS DateTime))
INSERT [dbo].[Messages] ([ID], [IDSender], [IDReceiver], [Message], [RegDate]) VALUES (5, 1003, 1005, N'Hello
', CAST(N'2022-06-20T20:58:03.360' AS DateTime))
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[Publishers] ON 

INSERT [dbo].[Publishers] ([Publisher_ID], [Name], [City], [Created_At], [Updated_At]) VALUES (2, N'First Publisher', N'Ankara', CAST(N'1986-09-26T00:00:00.000' AS DateTime), CAST(N'2022-06-02T00:30:51.027' AS DateTime))
INSERT [dbo].[Publishers] ([Publisher_ID], [Name], [City], [Created_At], [Updated_At]) VALUES (5, N'Pearson', N'London', CAST(N'1844-01-01T00:00:00.000' AS DateTime), CAST(N'2022-06-02T00:30:51.027' AS DateTime))
INSERT [dbo].[Publishers] ([Publisher_ID], [Name], [City], [Created_At], [Updated_At]) VALUES (6, N'Helena Rho', N'California', CAST(N'1999-10-10T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Publishers] ([Publisher_ID], [Name], [City], [Created_At], [Updated_At]) VALUES (7, N'Korey', N'Boston', CAST(N'2008-08-07T00:00:00.000' AS DateTime), CAST(N'2022-06-02T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Publishers] OFF
GO
SET IDENTITY_INSERT [dbo].[Ratings] ON 

INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (2, 1, 2, 2, CAST(N'2022-06-11T01:47:50.680' AS DateTime), CAST(N'2022-06-11T01:47:50.680' AS DateTime))
INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (4, 1003, 2, 5, CAST(N'2022-06-01T23:49:24.433' AS DateTime), CAST(N'2022-06-01T23:49:24.433' AS DateTime))
INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (5, 1, 2, 3, CAST(N'2022-06-19T14:42:23.467' AS DateTime), CAST(N'2022-06-19T14:42:23.467' AS DateTime))
INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (6, 1, 2, 4, CAST(N'2022-06-19T14:42:26.597' AS DateTime), CAST(N'2022-06-19T14:42:26.597' AS DateTime))
INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (7, 1, 2, 5, CAST(N'2022-06-19T14:42:29.067' AS DateTime), CAST(N'2022-06-19T14:42:29.067' AS DateTime))
INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (8, 1, 2, 5, CAST(N'2022-06-19T14:42:32.910' AS DateTime), CAST(N'2022-06-19T14:42:32.910' AS DateTime))
INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (9, 1, 5, 5, CAST(N'2022-06-19T15:01:13.067' AS DateTime), CAST(N'2022-06-19T15:01:13.067' AS DateTime))
INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (10, 1, 7, 5, CAST(N'2022-06-19T16:14:05.600' AS DateTime), CAST(N'2022-06-19T16:14:05.600' AS DateTime))
INSERT [dbo].[Ratings] ([Rating_ID], [User_ID], [Text_ID], [Rating], [Created_At], [Updated_At]) VALUES (11, 1003, 9, 4, CAST(N'2022-06-20T20:56:53.360' AS DateTime), CAST(N'2022-06-20T20:56:53.360' AS DateTime))
SET IDENTITY_INSERT [dbo].[Ratings] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

INSERT [dbo].[Reviews] ([Review_ID], [User_ID], [Text_ID], [Title], [Body], [Created_At], [Updated_At]) VALUES (1, 1, 2, N'Analysis', N'I like this book, I felt what the write was trying to say. Definitely recommend it for everyone.', CAST(N'2022-06-11T18:43:34.880' AS DateTime), CAST(N'2022-06-11T18:43:34.880' AS DateTime))
INSERT [dbo].[Reviews] ([Review_ID], [User_ID], [Text_ID], [Title], [Body], [Created_At], [Updated_At]) VALUES (3, 1, 7, N'Good Book', N'I found this book very useful', CAST(N'2022-06-19T16:15:12.660' AS DateTime), CAST(N'2022-06-19T16:15:12.660' AS DateTime))
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[States] ON 

INSERT [dbo].[States] ([ID], [Name]) VALUES (1, N'Want to Read')
INSERT [dbo].[States] ([ID], [Name]) VALUES (2, N'Currently Reading')
INSERT [dbo].[States] ([ID], [Name]) VALUES (3, N'Finished Reading')
SET IDENTITY_INSERT [dbo].[States] OFF
GO
SET IDENTITY_INSERT [dbo].[Text_Genres] ON 

INSERT [dbo].[Text_Genres] ([Text_Genre_ID], [Text_ID], [Genre_ID], [Created_At], [Updated_At]) VALUES (6, 11, 10, CAST(N'2022-06-06T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Text_Genres] ([Text_Genre_ID], [Text_ID], [Genre_ID], [Created_At], [Updated_At]) VALUES (7, 7, 14, CAST(N'2022-05-05T00:00:00.000' AS DateTime), CAST(N'2022-06-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Text_Genres] ([Text_Genre_ID], [Text_ID], [Genre_ID], [Created_At], [Updated_At]) VALUES (8, 2, 15, CAST(N'2022-03-03T00:00:00.000' AS DateTime), CAST(N'2022-03-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Text_Genres] ([Text_Genre_ID], [Text_ID], [Genre_ID], [Created_At], [Updated_At]) VALUES (9, 9, 13, CAST(N'2022-06-06T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Text_Genres] ([Text_Genre_ID], [Text_ID], [Genre_ID], [Created_At], [Updated_At]) VALUES (10, 12, 4, CAST(N'2022-06-06T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Text_Genres] ([Text_Genre_ID], [Text_ID], [Genre_ID], [Created_At], [Updated_At]) VALUES (11, 5, 2, CAST(N'2022-06-05T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Text_Genres] ([Text_Genre_ID], [Text_ID], [Genre_ID], [Created_At], [Updated_At]) VALUES (12, 13, 12, CAST(N'2022-05-05T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Text_Genres] OFF
GO
SET IDENTITY_INSERT [dbo].[Text_States] ON 

INSERT [dbo].[Text_States] ([ID], [Text_ID], [User_ID], [IDState], [Created_At], [Updated_At]) VALUES (7, 5, 1003, 1, CAST(N'2022-06-19T16:41:11.213' AS DateTime), CAST(N'2022-06-19T16:41:11.213' AS DateTime))
SET IDENTITY_INSERT [dbo].[Text_States] OFF
GO
SET IDENTITY_INSERT [dbo].[Texts] ON 

INSERT [dbo].[Texts] ([Text_ID], [IDPublisher], [Title], [Description], [Published_date], [Created_At], [Updated_At], [ImagePath]) VALUES (2, 2, N'No More Lies', N'Secrets and lies shadow a woman on the run in the second novel in the No More trilogy by Amazon Charts and Wall Street Journal bestselling author Kerry Lonsdale.

Jenna Mason’s life seems perfect: a successful career as an animator, a town house near the beach, and an adoring son, Josh, whose artistic talent looks as promising as his mother’s. But there’s something nobody realizes about Jenna. She used to be Lily Carson, a young mother on the run from a secret no one must ever know.', CAST(N'1997-06-26' AS Date), CAST(N'2022-06-02T00:30:51.027' AS DateTime), CAST(N'2022-06-02T00:30:51.027' AS DateTime), N'https://scontent.fesb8-1.fna.fbcdn.net/v/t39.30808-6/280557314_5196750827074382_3030723285393792198_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=4wyXWwsAWXMAX_MWdEk&_nc_ht=scontent.fesb8-1.fna&oh=00_AT_FTVrHRXyXO2oUdxn334uefnUcu2dt0pxsDSgkAY1j0g&oe=62B44EE0')
INSERT [dbo].[Texts] ([Text_ID], [IDPublisher], [Title], [Description], [Published_date], [Created_At], [Updated_At], [ImagePath]) VALUES (5, 5, N'The Druid', N'By exploring the potential power of an ancient spoken magic, a girl from the flax fields rises above her station in the first read in an epic new series by Wall Street Journal bestselling author Jeff Wheeler - author.
', CAST(N'2011-08-01' AS Date), CAST(N'2022-06-02T00:30:51.027' AS DateTime), CAST(N'2022-06-02T00:30:51.027' AS DateTime), N'https://scontent.fesb8-1.fna.fbcdn.net/v/t39.30808-6/280452102_5202178176531647_6615409302373113614_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=PXfp_nUSFfMAX9XmjcL&_nc_ht=scontent.fesb8-1.fna&oh=00_AT9-p-S6aSRwDBFrUc0oxqKEwyAN44IHmCSHTmrPeQK0HA&oe=62B424A6')
INSERT [dbo].[Texts] ([Text_ID], [IDPublisher], [Title], [Description], [Published_date], [Created_At], [Updated_At], [ImagePath]) VALUES (7, 6, N'American Seoul', N'Helena Rho was six years old when her family left Seoul, Korea, for America and its opportunities. Years later, her Korean-ness behind her, Helena had everything a model minority was supposed to want: she was married to a white American doctor and had a beautiful home, two children, and a career as an assistant professor of pediatrics. For decades she fulfilled the expectations of others. All the while Helena kept silent about the traumas—both professional and personal—that left her anxious yet determined to escape. It would take a catastrophic event for Helena to abandon her career at the age of forty, recover her Korean identity, and set in motion a journey of self-discovery.

In her powerful and moving memoir, Helena Rho reveals the courage it took to break away from the path that was laid out for her, to assert her presence, and to discover the freedom and joy of finally being herself.', CAST(N'2022-11-01' AS Date), CAST(N'2022-04-04T00:00:00.000' AS DateTime), CAST(N'2022-04-04T00:00:00.000' AS DateTime), N'https://scontent.fesb8-1.fna.fbcdn.net/v/t39.30808-6/281341611_5222936277789170_4217217737758283416_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=730e14&_nc_ohc=m0TwSeAoxH0AX_fME4-&_nc_ht=scontent.fesb8-1.fna&oh=00_AT8k-mP9j_X7CAB0B_WCRsvvQ2ujsQjvwDtVq8pdHY8zWQ&oe=62B3ECD5')
INSERT [dbo].[Texts] ([Text_ID], [IDPublisher], [Title], [Description], [Published_date], [Created_At], [Updated_At], [ImagePath]) VALUES (9, 2, N'The Unkown Beloved', N'In this Great Depression-era novel from bestselling author Amy Harmon, two allies race to find a killer before they become his next victims.', CAST(N'2022-04-04' AS Date), CAST(N'2022-04-04T00:00:00.000' AS DateTime), CAST(N'2022-04-04T00:00:00.000' AS DateTime), N'https://scontent.fesb8-1.fna.fbcdn.net/v/t39.30808-6/280695296_5202448836504581_6753512569868354311_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=730e14&_nc_ohc=OW-PabENFv0AX8pSS7L&_nc_ht=scontent.fesb8-1.fna&oh=00_AT__Ef0sizpdizGeWR0UpfchAD4fxSKzCDt3wFTnivq9Jg&oe=62B4F899')
INSERT [dbo].[Texts] ([Text_ID], [IDPublisher], [Title], [Description], [Published_date], [Created_At], [Updated_At], [ImagePath]) VALUES (11, 7, N'I Am Able to Shine', N'An affirmative, empowering story about embracing your identity and finding your voice, inspired in part by debut author Korey Watari’s experiences growing up Asian American, and illustrated by her husband, Mike Wu, Pixar artist and creator of the Ellie series.', CAST(N'2010-04-02' AS Date), CAST(N'2022-04-04T00:00:00.000' AS DateTime), CAST(N'2022-06-05T00:00:00.000' AS DateTime), N'https://scontent.fesb8-1.fna.fbcdn.net/v/t39.30808-6/280930095_5205759399506858_7218772744700356690_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=730e14&_nc_ohc=lLfQpggklIcAX9XNHoc&tn=kMKYNfiNoEp4JVYt&_nc_ht=scontent.fesb8-1.fna&oh=00_AT8To2oorakB-Ne0AB5lYK_Ec3jw4egZoKF3wEdubPt57w&oe=62B39D4F')
INSERT [dbo].[Texts] ([Text_ID], [IDPublisher], [Title], [Description], [Published_date], [Created_At], [Updated_At], [ImagePath]) VALUES (12, 5, N'Strangers We Know', N'The search for a serial killer leads a woman into the twisted tangle of her own family tree in a chilling novel by the #1 Amazon Charts bestselling author of The Missing Sister and Lies We Bury.

Adopted when she was only days old, Ivy Hon knows little about her lineage. But when she’s stricken with a mystery illness, the results of a genetic test to identify the cause attract the FBI. According to Ivy’s DNA, she’s related to the Full Moon Killer, who has terrorized the Pacific Northwest for decades. Ivy is the FBI’s hope to stop the enigmatic predator from killing again.

When an online search connects Ivy with her younger cousin, she heads to rural Rock Island, Washington, to meet the woman. Motivated by a secret desire to unmask a murderous relative, Ivy reaches out to what’s left of a family of strangers.

Discovering her mother’s tragic fate and her father’s disappearance is just the beginning. As Ivy ventures into a serial killer’s home territory, she realizes that she may be the next victim of poisonous blood ties', CAST(N'2022-02-02' AS Date), CAST(N'2022-06-06T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime), N'https://scontent.fesb8-1.fna.fbcdn.net/v/t39.30808-6/283145644_5222637491152382_5170282102597371145_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=730e14&_nc_ohc=ayau0SfNuQcAX9FmehJ&_nc_ht=scontent.fesb8-1.fna&oh=00_AT_wMX4x0li52689g8zMbEcaZUdwMTNuCVsVz2QqkuNCyw&oe=62B51348')
INSERT [dbo].[Texts] ([Text_ID], [IDPublisher], [Title], [Description], [Published_date], [Created_At], [Updated_At], [ImagePath]) VALUES (13, 5, N'A train to Moscow', N'In post-World War II Russia, a girl must decide if her dreams are truly worth the necessary price. Read the powerful novel of family secrets, loss, perseverance, and ambition from Elena Gorokhova.', CAST(N'2022-02-02' AS Date), CAST(N'2022-05-05T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime), N'https://scontent.fesb8-1.fna.fbcdn.net/v/t39.30808-6/279520662_5166878606728271_9065589224232712796_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=0fTtR7QqRzYAX_KnLU8&_nc_oc=AQmUK9c-4_mC9mYD0H49Ks27SHPPvKAsXjEs_sRg2lbMqAoU1iXxk4xOYl2PzlW53SY&_nc_ht=scontent.fesb8-1.fna&oh=00_AT85O_qmUtSmcHunU_VnyWFKly-fl_U9O-IKtofebgI-5A&oe=62B488BD')
SET IDENTITY_INSERT [dbo].[Texts] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [Birthdate], [Gender], [CreatedAt], [UpdatedAt], [ImagePath], [isauthor]) VALUES (1, N'Zahdir', N'Zahdir', N'Zahdir', N'Zahdir', N'Zahdir@gmail.com', CAST(N'2001-01-01' AS Date), N'male', CAST(N'2022-05-26T01:02:54.333' AS DateTime), CAST(N'2022-05-26T01:02:54.333' AS DateTime), N'https://www.bootdey.com/img/Content/avatar/avatar2.png', 0)
INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [Birthdate], [Gender], [CreatedAt], [UpdatedAt], [ImagePath], [isauthor]) VALUES (1003, N'Hussein', N'Hussein', N'Malulein', N'Hussein', N'hussein@gmail.com', CAST(N'1999-12-12' AS Date), N'male', CAST(N'2022-06-01T23:49:24.433' AS DateTime), CAST(N'2022-06-01T23:49:24.433' AS DateTime), N'https://bootdey.com/img/Content/avatar/avatar1.png', 0)
INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [Birthdate], [Gender], [CreatedAt], [UpdatedAt], [ImagePath], [isauthor]) VALUES (1004, N'Bassmah', N'Bassmah', N'Issa', N'Bassmah', N'Bassmah@gmail.com', CAST(N'2003-12-02' AS Date), N'Female', CAST(N'2022-06-02T00:30:51.027' AS DateTime), CAST(N'2022-06-02T00:30:52.520' AS DateTime), N'https://www.bootdey.com/img/Content/avatar/avatar3.png', 0)
INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [Birthdate], [Gender], [CreatedAt], [UpdatedAt], [ImagePath], [isauthor]) VALUES (1005, N'Helena', N'Helena', N'Rho', N'Helena', N'helena@outlook.com', CAST(N'1995-12-12' AS Date), N'Female', CAST(N'2022-06-06T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime), N'https://www.bootdey.com/img/Content/avatar/avatar3.png', 1)
INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [Birthdate], [Gender], [CreatedAt], [UpdatedAt], [ImagePath], [isauthor]) VALUES (1018, N'Korey', N'Korey', N'Watari', N'Korey', N'korey@gmail.com', CAST(N'1982-10-10' AS Date), N'Female', CAST(N'2022-04-03T00:00:00.000' AS DateTime), CAST(N'2022-06-06T00:00:00.000' AS DateTime), N'https://www.bootdey.com/img/Content/avatar/avatar3.png', 1)
INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [Birthdate], [Gender], [CreatedAt], [UpdatedAt], [ImagePath], [isauthor]) VALUES (1019, N'Mick', N'Mick', N'Mick', N'Mick', N'mick@gmail.com', CAST(N'1988-12-12' AS Date), N'Male', CAST(N'2022-06-20T19:26:57.213' AS DateTime), CAST(N'2022-06-20T19:26:57.217' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [Index_Comment_on_User_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [Index_Comment_on_User_ID] ON [dbo].[Comments]
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Index_on_Parent_comment_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [Index_on_Parent_comment_ID] ON [dbo].[Comments]
(
	[Parent_comment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Friendlings_Friend_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [IX_Friendlings_Friend_ID] ON [dbo].[Friendlings]
(
	[Friend_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Friendlings_Friend_ID_User_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [IX_Friendlings_Friend_ID_User_ID] ON [dbo].[Friendlings]
(
	[Friend_ID] ASC,
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Friendlings_User_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [IX_Friendlings_User_ID] ON [dbo].[Friendlings]
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IsUnique_Genre]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IsUnique_Genre] ON [dbo].[Genres]
(
	[Genre_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_ratings_on_text_id]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [index_ratings_on_text_id] ON [dbo].[Ratings]
(
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_ratings_on_user_id]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [index_ratings_on_user_id] ON [dbo].[Ratings]
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_ratings_on_user_id_and_text_id]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [index_ratings_on_user_id_and_text_id] ON [dbo].[Ratings]
(
	[Text_ID] ASC,
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_reviews_on_text_id]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [index_reviews_on_text_id] ON [dbo].[Reviews]
(
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_Reviews_On_User_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [index_Reviews_On_User_ID] ON [dbo].[Reviews]
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_reviews_on_user_id_and_text_id]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [index_reviews_on_user_id_and_text_id] ON [dbo].[Reviews]
(
	[User_ID] ASC,
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Text_Authors_Author_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [IX_Text_Authors_Author_ID] ON [dbo].[Text_Authors]
(
	[Author_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Text_Authors_Author_ID_and_Text_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [IX_Text_Authors_Author_ID_and_Text_ID] ON [dbo].[Text_Authors]
(
	[Author_ID] ASC,
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Text_Authors_Text_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [IX_Text_Authors_Text_ID] ON [dbo].[Text_Authors]
(
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_text_genre_on_user_id]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [index_text_genre_on_user_id] ON [dbo].[Text_Genres]
(
	[Genre_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_text_genres_on_text_id_and_genre_id]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [index_text_genres_on_text_id_and_genre_id] ON [dbo].[Text_Genres]
(
	[Text_ID] ASC,
	[Genre_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Text_Genre_Text_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [IX_Text_Genre_Text_ID] ON [dbo].[Text_Genres]
(
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Index_on_User_ID_and_Text_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
ALTER TABLE [dbo].[Text_States] ADD  CONSTRAINT [Index_on_User_ID_and_Text_ID] UNIQUE NONCLUSTERED 
(
	[User_ID] ASC,
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Index_TextState_Text_ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [Index_TextState_Text_ID] ON [dbo].[Text_States]
(
	[Text_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Index_TextState_User-ID]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE NONCLUSTERED INDEX [Index_TextState_User-ID] ON [dbo].[Text_States]
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IsUnique_Title]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IsUnique_Title] ON [dbo].[Texts]
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IsUnique_email]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IsUnique_email] ON [dbo].[Users]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IsUnique_username]    Script Date: 6/20/2022 9:25:37 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IsUnique_username] ON [dbo].[Users]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_isauthor]  DEFAULT ((0)) FOR [isauthor]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Comments] FOREIGN KEY([Parent_comment_ID])
REFERENCES [dbo].[Comments] ([Comment_ID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Comments]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Reviews] FOREIGN KEY([ReviewID])
REFERENCES [dbo].[Reviews] ([Review_ID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Reviews]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
ALTER TABLE [dbo].[Friendlings]  WITH CHECK ADD  CONSTRAINT [FK_Friendlings_Followed] FOREIGN KEY([Friend_ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Friendlings] CHECK CONSTRAINT [FK_Friendlings_Followed]
GO
ALTER TABLE [dbo].[Friendlings]  WITH CHECK ADD  CONSTRAINT [FK_Friendlings_LoggedUser] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Friendlings] CHECK CONSTRAINT [FK_Friendlings_LoggedUser]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_ReceiverUsers] FOREIGN KEY([IDReceiver])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_ReceiverUsers]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_SenderUsers] FOREIGN KEY([IDSender])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_SenderUsers]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [FK_Ratings_Text] FOREIGN KEY([Text_ID])
REFERENCES [dbo].[Texts] ([Text_ID])
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [FK_Ratings_Text]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [FK_Ratings_Users] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [FK_Ratings_Users]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Texts] FOREIGN KEY([Text_ID])
REFERENCES [dbo].[Texts] ([Text_ID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Texts]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Users] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Users]
GO
ALTER TABLE [dbo].[Text_Authors]  WITH CHECK ADD  CONSTRAINT [FK_Text_Authors_Texts] FOREIGN KEY([Text_ID])
REFERENCES [dbo].[Texts] ([Text_ID])
GO
ALTER TABLE [dbo].[Text_Authors] CHECK CONSTRAINT [FK_Text_Authors_Texts]
GO
ALTER TABLE [dbo].[Text_Genres]  WITH CHECK ADD  CONSTRAINT [FK_Text_Genres_Genres] FOREIGN KEY([Genre_ID])
REFERENCES [dbo].[Genres] ([Genre_ID])
GO
ALTER TABLE [dbo].[Text_Genres] CHECK CONSTRAINT [FK_Text_Genres_Genres]
GO
ALTER TABLE [dbo].[Text_Genres]  WITH CHECK ADD  CONSTRAINT [FK_Text_Genres_Texts] FOREIGN KEY([Text_ID])
REFERENCES [dbo].[Texts] ([Text_ID])
GO
ALTER TABLE [dbo].[Text_Genres] CHECK CONSTRAINT [FK_Text_Genres_Texts]
GO
ALTER TABLE [dbo].[Text_States]  WITH CHECK ADD  CONSTRAINT [FK_Text_States_States] FOREIGN KEY([IDState])
REFERENCES [dbo].[States] ([ID])
GO
ALTER TABLE [dbo].[Text_States] CHECK CONSTRAINT [FK_Text_States_States]
GO
ALTER TABLE [dbo].[Text_States]  WITH CHECK ADD  CONSTRAINT [FK_Text_States_Texs] FOREIGN KEY([Text_ID])
REFERENCES [dbo].[Texts] ([Text_ID])
GO
ALTER TABLE [dbo].[Text_States] CHECK CONSTRAINT [FK_Text_States_Texs]
GO
ALTER TABLE [dbo].[Text_States]  WITH CHECK ADD  CONSTRAINT [FK_Text_States_Users] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Text_States] CHECK CONSTRAINT [FK_Text_States_Users]
GO
ALTER TABLE [dbo].[Texts]  WITH CHECK ADD  CONSTRAINT [FK_Texts_Publishers] FOREIGN KEY([IDPublisher])
REFERENCES [dbo].[Publishers] ([Publisher_ID])
GO
ALTER TABLE [dbo].[Texts] CHECK CONSTRAINT [FK_Texts_Publishers]
GO
USE [master]
GO
ALTER DATABASE [Goodreads_Clone_DB] SET  READ_WRITE 
GO

USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_Users]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](max) NOT NULL,
	[UserName] [nvarchar](max) NOT NULL,
	[RoleId] [nvarchar](max) NOT NULL,
	[Company] [nvarchar](max) NULL,
	[Division] [nvarchar](max) NULL,
	[Department] [nvarchar](max) NULL,
	[SubDept] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[UserTypeId] [int] NULL,
	[DefaultLinkId] [int] NULL,
	[PrefLang] [bit] NULL,
	[AfterLoginSP] [nvarchar](max) NULL,
	[Permission] [nvarchar](max) NULL,
	[ReportingManager] [nvarchar](max) NULL,
	[IsResetPassword] [int] NULL,
	[EmailId] [nvarchar](max) NULL,
 CONSTRAINT [PK_Obp_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_Users] ADD  CONSTRAINT [DF_obps_Users_DefaultLinkId]  DEFAULT (NULL) FOR [DefaultLinkId]
GO
ALTER TABLE [dbo].[obps_Users] ADD  DEFAULT ((0)) FOR [PrefLang]
GO
ALTER TABLE [dbo].[obps_Users] ADD  DEFAULT (NULL) FOR [AfterLoginSP]
GO

USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_HelpDoc]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_HelpDoc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NULL,
	[GroupName] [nvarchar](max) NULL,
	[DisplayName] [nvarchar](max) NULL,
	[FileName] [nvarchar](max) NULL,
	[IsActive] [int] NULL,
	[UserType] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_HelpDoc] ADD  DEFAULT ((1)) FOR [IsActive]
GO

USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_FileUpload]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_FileUpload](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AutoId] [int] NULL,
	[FileName] [nvarchar](max) NULL,
	[Username] [nvarchar](max) NULL,
	[FilePath] [nvarchar](max) NULL,
	[FileNameDesc] [nvarchar](max) NULL,
	[Linkid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

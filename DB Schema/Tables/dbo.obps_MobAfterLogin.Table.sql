USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_MobAfterLogin]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_MobAfterLogin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AfterLoginSp] [nvarchar](max) NOT NULL,
	[Roleid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

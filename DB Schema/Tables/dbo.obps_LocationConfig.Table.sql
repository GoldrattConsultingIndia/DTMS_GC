USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_LocationConfig]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_LocationConfig](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[linkid] [nvarchar](50) NULL,
	[LocationColName] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

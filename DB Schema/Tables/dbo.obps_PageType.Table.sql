USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_PageType]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_PageType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PageType] [nvarchar](max) NOT NULL,
	[PageTypeId] [int] NULL,
	[GridCount] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_PageType] ADD  DEFAULT ((0)) FOR [GridCount]
GO

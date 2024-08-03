USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_gms_HolidayList]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_gms_HolidayList](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LocId] [int] NULL,
	[Date] [date] NULL,
	[ReplType] [nvarchar](10) NULL
) ON [PRIMARY]
GO

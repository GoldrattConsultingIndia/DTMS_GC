USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_DHS_TicketCycleTimeRep]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_DHS_TicketCycleTimeRep](
	[TM] [nvarchar](max) NULL,
	[TaskStatus] [nvarchar](max) NULL,
	[1-5Days] [int] NULL,
	[1-10Days] [int] NULL,
	[1-20Days] [int] NULL,
	[1-30Days] [int] NULL,
	[Over 30 Days] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

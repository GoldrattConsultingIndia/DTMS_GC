USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_tb_DailyTaskEmails]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_tb_DailyTaskEmails](
	[Ticket] [int] NOT NULL,
	[ClientName] [nvarchar](max) NULL,
	[MainTask] [nvarchar](max) NULL,
	[Activity] [nvarchar](max) NULL,
	[Activity_TaskStatus] [nvarchar](max) NULL,
	[Main_TaskStatus] [nvarchar](max) NULL,
	[Committed] [nvarchar](max) NULL,
	[Color] [nvarchar](max) NULL,
	[Owner] [nvarchar](max) NULL,
	[UserEmail] [nvarchar](max) NULL,
	[ManagerEmail] [varchar](31) NOT NULL,
	[SendFlg] [int] NOT NULL,
	[ProcessDate] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

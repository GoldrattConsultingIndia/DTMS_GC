USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_ClientTicketActionDDLValues]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_ClientTicketActionDDLValues](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TaskStatusValue] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

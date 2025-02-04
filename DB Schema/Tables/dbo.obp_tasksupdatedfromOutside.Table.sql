USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_tasksupdatedfromOutside]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_tasksupdatedfromOutside](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Taskid] [int] NULL,
	[ColumnName] [nvarchar](max) NULL,
	[CurrentValue] [nvarchar](max) NULL,
	[NewCurrentValue] [nvarchar](max) NULL,
	[ProcessDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

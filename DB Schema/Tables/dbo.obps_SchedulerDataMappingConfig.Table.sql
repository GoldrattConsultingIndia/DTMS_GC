USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_SchedulerDataMappingConfig]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_SchedulerDataMappingConfig](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextCol] [nvarchar](max) NULL,
	[StartdateCol] [nvarchar](max) NULL,
	[EnddateCol] [nvarchar](max) NULL,
	[SchedulerTypeCol] [nvarchar](max) NULL,
	[LinkId] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

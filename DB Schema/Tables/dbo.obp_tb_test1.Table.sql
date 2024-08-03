USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_tb_test1]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_tb_test1](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[TaskName] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[Createdby] [nvarchar](100) NULL,
	[Modifiedby] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obp_tb_test1] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO

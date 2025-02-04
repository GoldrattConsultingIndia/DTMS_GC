USE [obp_dtms]
GO
/****** Object:  Table [dbo].[tb_NewOrdersEmail]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_NewOrdersEmail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Distributor] [nvarchar](200) NULL,
	[DealerName] [nvarchar](200) NULL,
	[DemandNo] [nvarchar](100) NULL,
	[MaterialDescription] [nvarchar](200) NULL,
	[Qty] [decimal](18, 2) NULL,
	[OrderDate] [date] NULL,
	[Email] [nvarchar](200) NULL,
	[ind01] [int] NULL,
	[OrderStatus] [nvarchar](100) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_NewOrdersEmail] ADD  DEFAULT ((0)) FOR [ind01]
GO

USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_gms_Transactions]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_gms_Transactions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TransType] [nvarchar](15) NULL,
	[FromLocationCode] [int] NULL,
	[ToLocationCode] [int] NULL,
	[SkuCode] [int] NULL,
	[Quantity] [float] NULL,
	[FromLocationName] [nvarchar](100) NULL,
	[ToLocationName] [nvarchar](100) NULL,
	[TransNum] [nvarchar](100) NULL,
	[UpdateDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsConsumption] [bit] NULL
) ON [PRIMARY]
GO

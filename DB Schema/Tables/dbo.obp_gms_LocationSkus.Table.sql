USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_gms_LocationSkus]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_gms_LocationSkus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [int] NULL,
	[SkuId] [nvarchar](50) NULL,
	[SkuDescription] [nvarchar](200) NULL,
	[BufferSize] [float] NULL,
	[ReplTime] [int] NULL,
	[UomId] [nvarchar](max) NULL,
	[InvAtStite] [float] NULL,
	[InvAtTransit] [float] NULL,
	[InvAtProduction] [float] NULL,
	[DispOriginId1] [int] NULL,
	[DispOriginId2] [int] NULL,
	[DispOriginId3] [int] NULL,
	[MinReplenishmentQty] [int] NULL,
	[ReplenishmentMultiples] [int] NULL,
	[IsReplenish] [bit] NULL,
	[UpdateDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_gms_LocationSkus_temp]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_gms_LocationSkus_temp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [nvarchar](max) NULL,
	[SkuId] [nvarchar](50) NULL,
	[SkuDescription] [nvarchar](200) NULL,
	[BufferSize] [nvarchar](max) NULL,
	[ReplTime] [nvarchar](max) NULL,
	[UomId] [nvarchar](max) NULL,
	[InvAtStite] [nvarchar](max) NULL,
	[InvAtTransit] [nvarchar](max) NULL,
	[InvAtProduction] [nvarchar](max) NULL,
	[DispOriginId1] [nvarchar](max) NULL,
	[DispOriginId2] [nvarchar](max) NULL,
	[DispOriginId3] [nvarchar](max) NULL,
	[MinReplenishmentQty] [nvarchar](max) NULL,
	[ReplenishmentMultiples] [nvarchar](max) NULL,
	[IsReplenish] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[Username] [nvarchar](100) NULL,
	[Isvalid] [int] NULL,
	[reason] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

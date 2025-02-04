USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_gms_Skus_temp]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_gms_Skus_temp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[SkuCode] [nvarchar](50) NULL,
	[SkuDescription] [nvarchar](300) NULL,
	[CreatedDate] [datetime] NULL,
	[IsValid] [int] NULL,
	[Reason] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

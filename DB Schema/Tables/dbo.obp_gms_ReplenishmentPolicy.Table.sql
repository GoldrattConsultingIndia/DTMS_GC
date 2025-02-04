USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_gms_ReplenishmentPolicy]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_gms_ReplenishmentPolicy](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[PolicyName] [nvarchar](max) NOT NULL,
	[Mon] [bit] NULL,
	[Tue] [bit] NULL,
	[Wed] [bit] NULL,
	[Thur] [bit] NULL,
	[Fri] [bit] NULL,
	[Sat] [bit] NULL,
	[Sun] [bit] NULL,
	[AllDays] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[Createdby] [nvarchar](100) NULL,
	[Modifiedby] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obp_gms_ReplenishmentPolicy] ADD  DEFAULT ((1)) FOR [AllDays]
GO
ALTER TABLE [dbo].[obp_gms_ReplenishmentPolicy] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO

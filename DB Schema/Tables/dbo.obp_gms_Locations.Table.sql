USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_gms_Locations]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_gms_Locations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LocationCode] [int] NULL,
	[LocationDescription] [nvarchar](200) NULL,
	[LocationType] [nvarchar](15) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Region] [nvarchar](50) NULL,
	[Pincode] [nvarchar](15) NULL,
	[DefaultOrigin] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[AutoInDays] [int] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ReplWeekDays] [nvarchar](max) NULL,
	[LocationPriority] [int] NOT NULL,
	[ReplPolicyName] [nvarchar](max) NOT NULL,
	[IsSmartReplAcitve] [bit] NOT NULL,
	[ReplHoldDays] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obp_gms_Locations] ADD  DEFAULT ((0)) FOR [LocationPriority]
GO
ALTER TABLE [dbo].[obp_gms_Locations] ADD  DEFAULT ('ALL') FOR [ReplPolicyName]
GO
ALTER TABLE [dbo].[obp_gms_Locations] ADD  DEFAULT ((0)) FOR [IsSmartReplAcitve]
GO
ALTER TABLE [dbo].[obp_gms_Locations] ADD  DEFAULT ((0)) FOR [ReplHoldDays]
GO

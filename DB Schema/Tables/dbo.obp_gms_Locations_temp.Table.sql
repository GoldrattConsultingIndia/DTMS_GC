USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_gms_Locations_temp]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_gms_Locations_temp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LocationCode] [nvarchar](max) NULL,
	[LocationDescription] [nvarchar](max) NULL,
	[LocationType] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[State] [nvarchar](max) NULL,
	[Region] [nvarchar](max) NULL,
	[Pincode] [nvarchar](max) NULL,
	[DefaultOrigin] [nvarchar](max) NULL,
	[AutoInDays] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ReplWeekDays] [nvarchar](max) NULL,
	[LocationPriority] [nvarchar](max) NULL,
	[ReplPolicyName] [nvarchar](max) NULL,
	[IsSmartReplAcitve] [nvarchar](max) NULL,
	[ReplHoldDays] [nvarchar](max) NULL,
	[IsValid] [int] NULL,
	[Reason] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

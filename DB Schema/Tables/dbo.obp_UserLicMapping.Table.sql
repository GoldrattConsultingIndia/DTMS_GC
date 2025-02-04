USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obp_UserLicMapping]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obp_UserLicMapping](
	[ClientId] [int] NULL,
	[UserName] [nvarchar](100) NULL,
	[UserEmail] [nvarchar](100) NULL,
	[Ind01] [int] NULL,
	[ClientName] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[DaysLeft] [int] NULL,
	[LicenseValidityDate] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

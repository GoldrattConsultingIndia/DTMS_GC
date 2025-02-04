USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_MobileConfig]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_MobileConfig](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Ddl1Sp] [nvarchar](max) NULL,
	[Ddl2Sp] [nvarchar](max) NULL,
	[Ddl3Sp] [nvarchar](max) NULL,
	[Linkid] [int] NULL,
	[ddl1text] [nvarchar](max) NULL,
	[ddl2text] [nvarchar](max) NULL,
	[ddl3text] [nvarchar](max) NULL,
	[GridDdlReq] [int] NULL,
	[GridDdlSp] [nvarchar](max) NULL,
	[IsGrid2Required] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_MobileConfig] ADD  DEFAULT ((0)) FOR [GridDdlReq]
GO
ALTER TABLE [dbo].[obps_MobileConfig] ADD  DEFAULT ('') FOR [GridDdlSp]
GO
ALTER TABLE [dbo].[obps_MobileConfig] ADD  DEFAULT ((0)) FOR [IsGrid2Required]
GO

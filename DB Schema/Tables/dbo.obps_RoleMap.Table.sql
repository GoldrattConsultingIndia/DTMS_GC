USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_RoleMap]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_RoleMap](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[ColName] [nvarchar](max) NOT NULL,
	[IsEditable] [bit] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[TableName] [nvarchar](max) NULL,
	[Displayorder] [int] NULL,
	[gridid] [int] NULL,
	[IsMobile] [int] NULL,
	[LinkId] [int] NULL,
	[IsVisible] [int] NULL,
	[VisibilityIndex] [int] NULL,
 CONSTRAINT [PK_Obp_RoleMap] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_RoleMap] ADD  CONSTRAINT [DF_Obp_RoleMap_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[obps_RoleMap] ADD  DEFAULT ((1)) FOR [IsMobile]
GO

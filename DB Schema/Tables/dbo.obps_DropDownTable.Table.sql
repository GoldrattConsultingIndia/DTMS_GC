USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_DropDownTable]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_DropDownTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ColumnId] [int] NOT NULL,
	[ColumnToInsert] [nvarchar](max) NULL,
	[ColumnToSelect] [nvarchar](max) NULL,
	[TableToSelect] [nvarchar](max) NULL,
	[IsId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

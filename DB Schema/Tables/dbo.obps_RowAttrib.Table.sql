USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_RowAttrib]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_RowAttrib](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableID] [int] NOT NULL,
	[TableName] [nvarchar](max) NOT NULL,
	[ColName] [nvarchar](max) NOT NULL,
	[MappedCol] [nvarchar](max) NOT NULL,
	[GridId] [int] NULL,
	[IsBackground] [int] NULL,
	[CellEditColName] [nvarchar](max) NULL,
	[LinkId] [int] NULL,
	[CellCtrlTypeColName] [nvarchar](max) NULL,
	[DdlCtrlSpColName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Obp_RowAttrib] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_RowAttrib] ADD  DEFAULT ((0)) FOR [IsBackground]
GO

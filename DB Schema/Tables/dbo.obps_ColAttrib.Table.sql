USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_ColAttrib]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_ColAttrib](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableID] [int] NOT NULL,
	[TableName] [nvarchar](max) NOT NULL,
	[ColName] [nvarchar](max) NOT NULL,
	[DisplayName] [nvarchar](max) NOT NULL,
	[ColControlType] [nvarchar](max) NOT NULL,
	[IsEditable] [bit] NOT NULL,
	[ColColor] [nvarchar](max) NULL,
	[FontColor] [int] NULL,
	[FontAttrib] [nchar](10) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBY] [nvarchar](max) NOT NULL,
	[ModifiedBy] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DropDownLink] [nvarchar](max) NULL,
	[GridId] [int] NULL,
	[ColumnWidth] [int] NULL,
	[LinkId] [int] NULL,
	[SortIndex] [int] NULL,
	[SortOrder] [nvarchar](max) NULL,
	[ToolTip] [nvarchar](max) NULL,
	[SummaryType] [nvarchar](100) NULL,
	[IsMobile] [int] NULL,
	[IsRequired] [int] NULL,
	[FormatCondIconId] [int] NULL,
	[MinVal] [int] NULL,
	[MaxVal] [int] NULL,
	[IsValidation] [bit] NULL,
	[DependentDDLColid] [int] NULL,
	[IsRefreshDDL] [int] NULL,
	[ValidationSP] [nvarchar](max) NULL,
 CONSTRAINT [PK_Obp_ColAttrib] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_ColAttrib] ADD  DEFAULT ('') FOR [SortOrder]
GO
ALTER TABLE [dbo].[obps_ColAttrib] ADD  DEFAULT ('') FOR [ToolTip]
GO
ALTER TABLE [dbo].[obps_ColAttrib] ADD  DEFAULT ((0)) FOR [IsRequired]
GO
ALTER TABLE [dbo].[obps_ColAttrib] ADD  DEFAULT ((0)) FOR [IsValidation]
GO
ALTER TABLE [dbo].[obps_ColAttrib] ADD  DEFAULT (NULL) FOR [DependentDDLColid]
GO
ALTER TABLE [dbo].[obps_ColAttrib] ADD  DEFAULT ((0)) FOR [IsRefreshDDL]
GO

USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_TopLinkExtended]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_TopLinkExtended](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Linkid] [int] NULL,
	[TabId] [int] NULL,
	[TabText] [nvarchar](max) NULL,
	[TabType] [varchar](1) NULL,
	[GridId] [int] NULL,
	[GridSp] [nvarchar](max) NULL,
	[GridTable] [nvarchar](max) NULL,
	[AllowAdd] [int] NULL,
	[AllowEdit] [int] NULL,
	[AllowDelete] [int] NULL,
	[DeleteSp] [nvarchar](max) NULL,
	[AfterSaveSp] [nvarchar](max) NULL,
	[AllowToolbar] [int] NULL,
	[IsExport] [int] NULL,
	[AllowFilterRow] [int] NULL,
	[AllowheaderFilter] [int] NULL,
	[AllowColumnChooser] [int] NULL,
	[AllowGroupPanel] [int] NULL,
	[RefreshEnabled] [int] NULL,
	[RefreshSp] [nvarchar](max) NULL,
	[IsYellowBtn] [int] NULL,
	[YellowBtnSp] [nvarchar](max) NULL,
	[IsGreenBtn] [int] NULL,
	[GreenBtnSp] [nvarchar](max) NULL,
	[IsRedBtn] [int] NULL,
	[RedBtnSp] [nvarchar](max) NULL,
	[AllowPaging] [int] NULL,
	[IsFormEdit] [int] NULL,
	[DependentGrid] [int] NULL,
	[AllowHScrollBar] [int] NULL,
	[CustomContextMenuTxt1] [nvarchar](max) NULL,
	[CustomContextMenuLinkId1] [nvarchar](max) NULL,
	[CustomContextMenuTxt2] [nvarchar](max) NULL,
	[CustomContextMenuLinkId2] [nvarchar](max) NULL,
	[CustomContextMenuTxt3] [nvarchar](max) NULL,
	[CustomContextMenuLinkId3] [nvarchar](max) NULL,
	[ToolBarDDLTxt1] [nvarchar](max) NULL,
	[ToolBarDDLTxt2] [nvarchar](max) NULL,
	[ToolBarDDLTxt3] [nvarchar](max) NULL,
	[ToolBarDDLSp1] [nvarchar](max) NULL,
	[ToolBarDDLSp2] [nvarchar](max) NULL,
	[ToolBarDDLSp3] [nvarchar](max) NULL,
	[ShowJobHistory] [int] NULL,
	[ValidationSp] [nvarchar](500) NULL,
	[GridRowButtonSp] [nvarchar](max) NULL,
	[GridRowButtonText] [nvarchar](max) NULL,
	[GridRowButtonColWidth] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((1)) FOR [TabId]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('A') FOR [TabType]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowAdd]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowEdit]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowDelete]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowToolbar]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [IsExport]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowFilterRow]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowheaderFilter]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowColumnChooser]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowGroupPanel]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [RefreshEnabled]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [IsYellowBtn]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [IsGreenBtn]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [IsRedBtn]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [AllowPaging]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((0)) FOR [IsFormEdit]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT (NULL) FOR [DependentGrid]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((1)) FOR [AllowHScrollBar]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [CustomContextMenuTxt1]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [CustomContextMenuLinkId1]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [CustomContextMenuTxt2]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [CustomContextMenuLinkId2]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [CustomContextMenuTxt3]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [CustomContextMenuLinkId3]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [ToolBarDDLTxt1]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [ToolBarDDLTxt2]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [ToolBarDDLTxt3]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [ToolBarDDLSp1]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [ToolBarDDLSp2]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ('') FOR [ToolBarDDLSp3]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT ((1)) FOR [ShowJobHistory]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT (NULL) FOR [ValidationSp]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT (NULL) FOR [GridRowButtonSp]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT (NULL) FOR [GridRowButtonText]
GO
ALTER TABLE [dbo].[obps_TopLinkExtended] ADD  DEFAULT (NULL) FOR [GridRowButtonColWidth]
GO

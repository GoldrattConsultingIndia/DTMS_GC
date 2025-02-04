USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_TopLinks]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_TopLinks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LinkName] [nvarchar](max) NOT NULL,
	[Type] [int] NULL,
	[MenuId] [int] NULL,
	[SortOrder] [int] NULL,
	[IsAfterLogin] [int] NULL,
	[IsImportEnabled] [int] NULL,
	[IsUploadEnabled] [int] NULL,
	[UploadPath] [nvarchar](max) NULL,
	[ImportErrorOutSp] [nvarchar](max) NULL,
	[ImportSavedOutSp] [nvarchar](max) NULL,
	[IsMobile] [int] NULL,
	[EnableUniversalSearch] [int] NULL,
	[ImportHelp] [nvarchar](max) NULL,
	[AllowedExtension] [nvarchar](max) NULL,
	[IsDependentTab] [int] NULL,
	[IsLocation] [int] NULL,
	[DdlSp] [nvarchar](max) NULL,
	[IsSamePage] [int] NULL,
	[TriggerGrid] [nvarchar](max) NULL,
	[RefreshGrid] [nvarchar](max) NULL,
	[ConditionalCRUDBtn] [nvarchar](max) NULL,
	[CondCRUDBtnAddSp] [nvarchar](max) NULL,
	[CondCRUDBtnEditSp] [nvarchar](max) NULL,
	[CondCRUDBtnDeleteSp] [nvarchar](max) NULL,
	[IsSpreadSheet] [int] NULL,
	[IsPivot] [int] NULL,
	[SchedulerTypeSP] [nvarchar](max) NULL,
	[IsExportToCsv] [int] NULL,
	[CSVSeperator] [nvarchar](5) NULL,
	[AllowPivotFieldChooser] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ((0)) FOR [IsImportEnabled]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ((0)) FOR [IsUploadEnabled]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ((0)) FOR [IsMobile]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT (NULL) FOR [ImportHelp]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT (NULL) FOR [AllowedExtension]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ('') FOR [ConditionalCRUDBtn]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ('') FOR [CondCRUDBtnAddSp]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ('') FOR [CondCRUDBtnEditSp]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ('') FOR [CondCRUDBtnDeleteSp]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ((0)) FOR [IsSpreadSheet]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ((0)) FOR [IsPivot]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ((0)) FOR [IsExportToCsv]
GO
ALTER TABLE [dbo].[obps_TopLinks] ADD  DEFAULT ((0)) FOR [AllowPivotFieldChooser]
GO

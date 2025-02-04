USE [obp_dtms]
GO
/****** Object:  Table [dbo].[obps_Charts]    Script Date: 2024-04-27 8:02:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obps_Charts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DivSp] [nvarchar](max) NOT NULL,
	[DivTitle] [nvarchar](max) NOT NULL,
	[Div1Charttype] [nvarchar](max) NULL,
	[Div2Charttype] [nvarchar](max) NULL,
	[Div3Charttype] [nvarchar](max) NULL,
	[Div4Charttype] [nvarchar](max) NULL,
	[Div5Charttype] [nvarchar](max) NULL,
	[Div6Charttype] [nvarchar](max) NULL,
	[Div1FilterSp] [nvarchar](max) NULL,
	[Div2FilterSp] [nvarchar](max) NULL,
	[Div3FilterSp] [nvarchar](max) NULL,
	[Div4FilterSp] [nvarchar](max) NULL,
	[Div5FilterSp] [nvarchar](max) NULL,
	[Div6FilterSp] [nvarchar](max) NULL,
	[Div1FilterText] [nvarchar](max) NULL,
	[Div2FilterText] [nvarchar](max) NULL,
	[Div3FilterText] [nvarchar](max) NULL,
	[Div4FilterText] [nvarchar](max) NULL,
	[Div5FilterText] [nvarchar](max) NULL,
	[Div6FilterText] [nvarchar](max) NULL,
	[IsSameFilter] [int] NULL,
	[DepenedentFilterDivs] [nvarchar](max) NULL,
	[IsSameChartType] [int] NULL,
	[DepenedentChartTypeDivs] [nvarchar](max) NULL,
	[LinkId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

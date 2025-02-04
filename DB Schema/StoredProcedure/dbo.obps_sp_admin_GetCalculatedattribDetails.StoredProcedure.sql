USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_GetCalculatedattribDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_admin_GetCalculatedattribDetails]  
AS  
BEGIN  
select C.id,C.ColName,C.DisplayName as DisplayColName,ColColor,GridId,ColumnWidth,M.DisplayName,T.LinkName,  
SortIndex,C.SortOrder,IsActive,C.IsMobile,ToolTip,SummaryType,FormatCondIconId 'Icon',MinVal,
MaxVal from obps_CalculatedColAttrib C  
inner join obps_TopLinks T on t.id=C.LinkId inner join obps_MenuName M  
on M.Id=T.MenuId where C.IsDeleted=0  
END  
GO

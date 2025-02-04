USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_UpdateCalcColAttribSettings]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_admin_UpdateCalcColAttribSettings]  
@linkid nvarchar(MAX)='',  
@colname nvarchar(MAX)='',  
@displayname nvarchar(MAX)='',  
@gridid nvarchar(MAX)='',  
@colcolour nvarchar(MAX)='',  
@colwidth nvarchar(MAX)='',  
@sortindex nvarchar(MAX)='',  
@sortorder nvarchar(MAX)='',  
@isactive nvarchar(MAX)='',  
@ismobile nvarchar(MAX)='',
@tooltip nvarchar(MAX)='',
@minval nvarchar(MAX)='',
@maxval nvarchar(MAX)='',
@summarytype nvarchar(MAX)='',
@formatcondicon nvarchar(MAX)='',
@id nvarchar(MAX)=''  
AS  
BEGIN  
  
update obps_CalculatedColAttrib set ColName=@colname,DisplayName=@displayname,ColColor=@colcolour,  
GridId=@gridid,ColumnWidth=@colwidth,LinkId=@linkid,SortIndex=@sortindex,SortOrder=@sortorder,  
ModifiedBy='admin',IsActive=@isactive,IsMobile=@ismobile ,ToolTip=@tooltip,MinVal=@minval,
MaxVal=@maxval,SummaryType=@summarytype,FormatCondIconId=@formatcondicon
where id=@id  
  
END  
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_adminGetlinkdetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_adminGetlinkdetails]    
AS    
BEGIN    
    
select LinkName,PageType,M.DisplayName 'menuname',SortOrder,    
case when IsAfterLogin=0 then 'false' else 'true' end IsAfterLogin,    
case when IsImportEnabled=0 then 'false' else 'true' end IsImportEnabled,    
case when IsMobile=0 then 'false' else 'true' end IsMobile,    
case when EnableUniversalSearch=0 then 'false' else 'true' end EnableUniversalSearch,    
case when IsLocation=0 then 'false' else 'true' end IsLocation,    
case when IsSamePage=0 then 'false' else 'true' end IsSamePage,    
case when ConditionalCRUDBtn=0 then 'false' else 'true' end ConditionalCRUDBtn,    
case when IsExportToCsv=0 then 'false' else 'true' end IsExportToCsv,    
CSVSeperator     
from obps_toplinks T inner join obps_MenuName M on T.MenuId=M.MenuId    
inner join obps_PageType P on P.PageTypeId=T.Type    
    
END

GO

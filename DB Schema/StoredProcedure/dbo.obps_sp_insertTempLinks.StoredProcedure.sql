USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_insertTempLinks]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_insertTempLinks]  
@sublinkid nvarchar(MAX)='',      
@noofcopies nvarchar(MAX)=''      
AS      
BEGIN  
declare @count int=1 ,@newid int     
declare @newlinkname nvarchar(MAX)=''      
      
truncate table obps_toplinks_temp   
truncate table obps_toplinkextended_temp   
      
while @count<=@noofcopies      
begin      
      
 SET @newlinkname='link'+convert(nvarchar,@count)     
 insert into obps_toplinks_temp      
 (LinkName,Type,MenuId,SortOrder,IsAfterLogin,IsImportEnabled,ImportErrorOutSp  
 ,ImportSavedOutSp,IsMobile,EnableUniversalSearch,ImportHelp,AllowedExtension,IsLocation  
 ,DdlSp,IsSamePage,TriggerGrid,RefreshGrid,ConditionalCRUDBtn,CondCRUDBtnAddSp,CondCRUDBtnEditSp  
 ,CondCRUDBtnDeleteSp,IsSpreadSheet,IsPivot,SchedulerTypeSP,IsExportToCsv,CSVSeperator,originallinkid )      
 (select @newlinkname,Type,MenuId,SortOrder,IsAfterLogin,IsImportEnabled,ImportErrorOutSp  
 ,ImportSavedOutSp,IsMobile,EnableUniversalSearch,ImportHelp,AllowedExtension,IsLocation  
 ,DdlSp,IsSamePage,TriggerGrid,RefreshGrid,ConditionalCRUDBtn,CondCRUDBtnAddSp,CondCRUDBtnEditSp  
 ,CondCRUDBtnDeleteSp,IsSpreadSheet,IsPivot,SchedulerTypeSP,IsExportToCsv,CSVSeperator,id   
 from obps_toplinks where id=@sublinkid)      
      
  set @newid=(SELECT @@IDENTITY)  
  
  insert into obps_toplinkextended_temp(  
Linkid,TabId,TabText,TabType,GridId,GridSp,GridTable,AllowAdd,AllowEdit,AllowDelete,DeleteSp,AfterSaveSp,AllowToolbar  
,IsExport,AllowFilterRow,AllowheaderFilter,AllowColumnChooser,AllowGroupPanel,RefreshEnabled,RefreshSp,IsYellowBtn,YellowBtnSp  
,IsGreenBtn,GreenBtnSp,IsRedBtn,RedBtnSp,AllowPaging,IsFormEdit,DependentGrid,AllowHScrollBar,CustomContextMenuLinkId1  
,CustomContextMenuLinkId2,CustomContextMenuLinkId3,CustomContextMenuTxt1,CustomContextMenuTxt2,CustomContextMenuTxt3)  
(select @newid,TabId,TabText,TabType,GridId,GridSp,GridTable,AllowAdd,AllowEdit,AllowDelete,DeleteSp,AfterSaveSp,AllowToolbar  
,IsExport,AllowFilterRow,AllowheaderFilter,AllowColumnChooser,AllowGroupPanel,RefreshEnabled,RefreshSp,IsYellowBtn,YellowBtnSp  
,IsGreenBtn,GreenBtnSp,IsRedBtn,RedBtnSp,AllowPaging,IsFormEdit,DependentGrid,AllowHScrollBar,CustomContextMenuLinkId1  
,CustomContextMenuLinkId2,CustomContextMenuLinkId3,CustomContextMenuTxt1,CustomContextMenuTxt2,CustomContextMenuTxt3   
from obps_TopLinkExtended where Linkid=@sublinkid)   
 SET @count=@count+1      
end      
END  

GO

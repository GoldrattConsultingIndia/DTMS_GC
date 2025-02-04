USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetAvailableCRUDButton]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_GetAvailableCRUDButton]  
@GridId nvarchar(2)='',  
@LinkId nvarchar(2)=''  
AS  
BEGIN  
DECLARE @IsAdd nvarchar(MAX),  
@IsEdit nvarchar(MAX),  
@IsDelete nvarchar(MAX),  
@IsExport nvarchar(MAX),  
@IsFilterRow nvarchar(MAX),  
@IsHeaderFilter nvarchar(MAX),  
@IsColumnChooser nvarchar(MAX),  
@IsPaging nvarchar(MAX),  
@GridAddName nvarchar(MAX),  
@GridEditName nvarchar(MAX),  
@GridDeleteName nvarchar(MAX),  
@GridExportName nvarchar(MAX),  
@GridFilterRowName nvarchar(MAX),  
@GridheaderFilterName nvarchar(MAX),  
@GridColumnChooserName nvarchar(MAX),  
@GridPagingName nvarchar(MAX),  
@GridGroupPanelName nvarchar(MAX),  
@colnamequery nvarchar(MAX),  
@colnamequery1 nvarchar(MAX),  
@colnamequery2 nvarchar(MAX),  
@colnamequery3 nvarchar(MAX),  
@colnamequery4 nvarchar(MAX),  
@colnamequery5 nvarchar(MAX),  
@colnamequery6 nvarchar(MAX),  
@colnamequery7 nvarchar(MAX),  
@colnamequery8 nvarchar(MAX),  
@IsUploadEnabled nvarchar(MAX),  
@IssearchPanel nvarchar(MAX),  
@IsGroupPanel nvarchar(MAX),  
@IsDependentTab nvarchar(MAX)  
  
SET @GridAddName='Grid'+@GridId+'AllowAdd'  
SET @GridEditName='Grid'+@GridId+'AllowEdit'  
SET @GridDeleteName='Grid'+@GridId+'AllowDelete'  
SET @GridExportName='Grid'+@GridId+'IsExport'  
SET @GridFilterRowName='Grid'+@GridId+'AllowFilterRow'  
SET @GridheaderFilterName='Grid'+@GridId+'AllowheaderFilter'  
SET @GridColumnChooserName='Grid'+@GridId+'AllowColumnChooser'  
SET @GridPagingName='Grid'+@GridId+'AllowPaging'  
SET @GridGroupPanelName='Grid'+@GridId+'AllowGroupPanel'  
  
SET @colnamequery=('(select @IsAdd='+@GridAddName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery,  N'@IsAdd NVARCHAR(MAX) output',  @IsAdd output  
  
SET @colnamequery1=('(select @IsEdit='+@GridEditName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery1,  N'@IsEdit NVARCHAR(MAX) output',  @IsEdit output  
  
SET @colnamequery2=('(select @IsDelete='+@GridDeleteName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery2,  N'@IsDelete NVARCHAR(MAX) output',  @IsDelete output  
  
SET @colnamequery3=('(select @IsExport='+@GridExportName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery3,  N'@IsExport NVARCHAR(MAX) output',  @IsExport output  
if @IsExport is null  
set @IsExport=0;  
  
SET @colnamequery4=('(select @IsFilterRow='+@GridFilterRowName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery4,  N'@IsFilterRow NVARCHAR(MAX) output',  @IsFilterRow output  
if @IsFilterRow is null  
set @IsFilterRow=0;  
  
SET @colnamequery5=('(select @IsHeaderFilter='+@GridheaderFilterName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery5,  N'@IsHeaderFilter NVARCHAR(MAX) output',  @IsHeaderFilter output  
if @IsHeaderFilter is null  
set @IsHeaderFilter=0;  
  
SET @colnamequery6=('(select @IsColumnChooser='+@GridColumnChooserName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery6,  N'@IsColumnChooser NVARCHAR(MAX) output',  @IsColumnChooser output  
if @IsColumnChooser is null  
set @IsColumnChooser=0;  
  
SET @colnamequery7=('(select @IsPaging='+@GridPagingName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery7,  N'@IsPaging NVARCHAR(MAX) output',  @IsPaging output  
if @IsPaging is null  
set @IsPaging=0;  
  
SET @IsUploadEnabled=(select IsUploadEnabled from obps_TopLinks where id=@LinkId)  
if @IsUploadEnabled is null  
set @IsUploadEnabled=0;  
  
SET @colnamequery8=('(select @IsGroupPanel='+@GridGroupPanelName+' from obps_TopLinks where ID='''+@LinkId +''')')  
EXEC Sp_executesql  @colnamequery8,  N'@IsGroupPanel NVARCHAR(MAX) output',  @IsGroupPanel output  
if @IsGroupPanel is null  
set @IsGroupPanel=0;  
  
SET @IssearchPanel=(select EnableUniversalSearch from obps_TopLinks where id=@LinkId)  
if @IssearchPanel is null  
set @IssearchPanel=0;  
  
SET @IsDependentTab=(select IsDependentTab from obps_TopLinks where id=@LinkId)  
if @IsDependentTab is null  
set @IsDependentTab=0;  
  
SELECT @IsAdd,@IsEdit,@IsDelete,@IsExport,@IsFilterRow,@IsHeaderFilter,@IsColumnChooser,@IsPaging,  
    @IsUploadEnabled,@IsGroupPanel,@IssearchPanel,@IsDependentTab  
END
GO

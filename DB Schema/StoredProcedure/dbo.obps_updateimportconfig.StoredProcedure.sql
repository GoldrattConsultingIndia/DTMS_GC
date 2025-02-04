USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_updateimportconfig]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_updateimportconfig]  
@id nvarchar(MAX)='',  
@toplinkid nvarchar(MAX)='',  
@tablename nvarchar(MAX)='',  
@temptablename nvarchar(MAX)='',  
@insertsp nvarchar(MAX)='',  
@genfilesp nvarchar(MAX)='',  
@deletesp nvarchar(MAX)='',  
@importerroroutsp nvarchar(MAX)='',  
@importsavedoutsp nvarchar(MAX)=''   
AS  
BEGIN  
if(@id='')  
 insert into obps_ExcelImportConfig(TableName,TempTableName,InsertSp,GenFileSp,DeleteSp,LinkId)  
 values(@tablename,@temptablename,@insertsp,@genfilesp,@deletesp,@toplinkid)  
ELSE   
 update obps_ExcelImportConfig set TableName=@tablename, TempTableName=@temptablename,  
   InsertSp=@insertsp,GenFileSp=@genfilesp,deletesp=@deletesp  
   where id=@id  
update obps_TopLinks set importerroroutsp=@importerroroutsp,importsavedoutsp=@importsavedoutsp, IsImportEnabled=1  
  where id=@toplinkid  
  
END 
GO

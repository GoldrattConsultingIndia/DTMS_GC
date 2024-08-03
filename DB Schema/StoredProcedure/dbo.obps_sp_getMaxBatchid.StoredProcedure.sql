USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getMaxBatchid]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec obps_sp_getMaxBatchid @tablename=N'26'  
  
CREATE PROCEDURE [dbo].[obps_sp_getMaxBatchid]    
@tablename nvarchar(MAX)=''   ,
@linkid nvarchar(MAX)=''
AS    
BEGIN    
DECLARE @str nvarchar(MAX)    
DECLARE @sout int=0    
set @tablename=(select TempTableName from obps_ExcelImportConfig where LinkId=@linkid)
set @str=('SELECT isnull(MAX(batchid),0) from '+@tablename)  
--select @str    
EXEC Sp_executesql  @str,N'@sout int output',  @sout output    
--if @sout is null  
--BEGIN  
-- SET @sout= 0  
--END  
--ELSE  
--BEGIN  
-- SELECT @sout  
--END  
END 
GO

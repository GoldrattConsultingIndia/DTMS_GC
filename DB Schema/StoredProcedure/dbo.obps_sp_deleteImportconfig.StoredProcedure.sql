USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_deleteImportconfig]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_deleteImportconfig]  
@id int='',  
@topid nvarchar(MAX)=''  
AS  
BEGIN  
select len(@topid)
if(len(@id)>0)  
DELETE from obps_ExcelImportConfig where id=@id   
if(len(@topid)>0)  
begin
select '1'
update obps_TopLinks set importerroroutsp='',importsavedoutsp='', IsImportEnabled=0
  where id=@topid  
  end
  
END
GO

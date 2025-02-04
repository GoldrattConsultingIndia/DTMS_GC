USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertUploadFile]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[obps_sp_InsertUploadFile]  
@LinkId nvarchar(MAX)='',  
@username nvarchar(MAX)='',  
@id nvarchar(MAX)='',  
@filePath nvarchar(MAX)='',
@filename nvarchar(MAX)='',
@newfilename nvarchar(MAX)=''
AS  
BEGIN  
 insert into obps_FileUpload(AutoId,Username,FilePath,Linkid,filename,filenamedesc)  
 values  
 (@id,@username,@filePath,@LinkId,@newfilename,@filename)  
END  
GO

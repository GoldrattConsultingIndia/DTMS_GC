USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getFileUploadPath]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getFileUploadPath]  
@LinkId nvarchar(MAX)=''
AS  
BEGIN  
----Folder Name should be '~/Upload/TestFolderName/' 
select Uploadpath from obps_TopLinks where id=@LinkId  
END  
GO

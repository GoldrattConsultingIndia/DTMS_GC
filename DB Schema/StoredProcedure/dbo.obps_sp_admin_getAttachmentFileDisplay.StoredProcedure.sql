USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_getAttachmentFileDisplay]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_admin_getAttachmentFileDisplay]  
  @Linkid nvarchar(MAX)=''  
  AS  
  BEGIN  
  
 SELECT UploadPath,AllowedExtension from obps_TopLinks where id=@Linkid  
  
  END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_InsertAttachmentFileSettings]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[obps_sp_admin_InsertAttachmentFileSettings]  
  @linkid nvarchar(MAX)='',  
  @uploadPath nvarchar(MAX)='',
  @allowedExtensions nvarchar(MAX)=''
  AS  
  BEGIN  
  
 update obps_TopLinks set uploadpath=@uploadPath,AllowedExtension=@allowedExtensions where id=@linkid  
  select '1'
  END
GO

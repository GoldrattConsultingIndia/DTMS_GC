USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getUserRoles]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getUserRoles]  
@id nvarchar(MAX)=''  
AS  
BEGIN  
 if @id<>''  
  select id,RoleId,RoleDescription from obps_RoleMaster where id=@id  
 else  
  select id,RoleId,RoleDescription from obps_RoleMaster  
END  
GO

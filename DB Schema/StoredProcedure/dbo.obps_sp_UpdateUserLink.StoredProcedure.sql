USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateUserLink]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[obps_sp_UpdateUserLink]    
@mainmenu nvarchar(MAX)='',    
@sublink nvarchar(MAX)='',    
@mainmenuid nvarchar(MAX)='',    
@sublinkid nvarchar(MAX)='',    
@isactive nvarchar(MAX)='',    
@id nvarchar(MAX)=''  ,  
@isrole nvarchar(MAX)=''  
AS    
BEGIN    
DECLARE @count nvarchar(MAX)    
 SET @count=(select count(*) from obps_UserLinks where id=@id)    
 IF @count>0     
 BEGIN    
  update obps_UserLinks set LinkName=@mainmenu,LinkId=@mainmenuid,     
  sublinkid=@sublinkid,IsActive=@isactive,isroleattached=@isrole where id=@id    
  if(@isrole=1)
	exec obps_sp_InsertRoleMapping @id    
 END    
END    
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertHelpDoc]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_InsertHelpDoc]    
@FileName nvarchar(MAX)='',    
@usertype nvarchar(MAX)='',    
@GpName nvarchar(MAX)=''    
AS    
BEGIN    
DECLARE @gpid int,@newid int=0    
 BEGIN TRY    
  if((select count(*) from obps_helpdoc where GroupName=@GpName)>0)    
   SET @gpid=(select max(groupid) from  obps_helpdoc where GroupName=@GpName)    
  ELSE    
   SET @gpid=(select max(groupid) from  obps_helpdoc)+1    
    
   INSERT INTO obps_helpdoc    
   (Groupid,GroupName,DisplayName,FileName,IsActive,UserType)    
   values    
   (@gpid,@GpName,@FileName,@FileName,1,@usertype)    
    
  SET @newid=(SELECT @@IDENTITY)     
    
  if(@newid>0)    
   select 'Data Saved'    
  else    
   select 'Not able to save the data'    
 END TRY      
 BEGIN CATCH      
  SELECT  ERROR_MESSAGE()       
 END CATCH     
    
END

GO

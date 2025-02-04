USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getClient]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getClient]        
@User_Name NVARCHAR(MAX)='',  
@linkid int='' ,          
@gridid nvarchar(MAX)=''        
AS        
BEGIN        
 DECLARE @SearchLetter int  ,@var_clientid nvarchar(max)     
 SET @SearchLetter =(Select id from obps_users where UserName=@User_Name)
 Set @var_clientid=(Select par1 from obps_SpPermissions where Linkid=@linkid and userid =  @SearchLetter)

 select id,clientname as name from obp_ClientMaster where id in (Select value from string_split(@var_clientid,','))         
 order by id asc        
 --select ID,clientname as name from obp_ClientMaster        
END    
GO

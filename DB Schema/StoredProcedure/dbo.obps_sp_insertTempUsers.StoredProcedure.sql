USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_insertTempUsers]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_insertTempUsers]  
@username nvarchar(MAX)='',  
@noofcopies nvarchar(MAX)=''  
AS  
BEGIN  
declare @count int=1  
declare @newusername nvarchar(MAX)=''  
  
truncate table obps_users_temp  
  
while @count<=@noofcopies  
begin  
  
 SET @newusername='user'+convert(nvarchar,@count)  
 insert into obps_Users_temp  
 (UserName,RoleId,Company,Division,Department,SubDept,UserTypeId,  
 DefaultLinkId,PrefLang,AfterLoginSP,Permission,ReportingManager,EmailId,originaluser)  
 (select @newusername,RoleId,Company,Division,Department,SubDept,UserTypeId,  
 DefaultLinkId,PrefLang,AfterLoginSP,Permission,ReportingManager,EmailId,@username   
 from obps_Users where UserName=@username)  
  
 SET @count=@count+1  
end  
  
END
GO

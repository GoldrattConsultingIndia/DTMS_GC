USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_SaveUserCopies]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_SaveUserCopies]  
AS  
BEGIN  
  
declare @userid int,@newuserid int  
declare @usrname nvarchar(MAX)='',@originalusername  nvarchar(MAX)=''  
  
insert into obps_Users  
(UserName,Userid,RoleId,Company,Division,Department,SubDept,Password,UserTypeId,DefaultLinkId,  
PrefLang,AfterLoginSP,Permission,ReportingManager,EmailId,isresetpassword)  
select UserName,1,RoleId,Company,Division,Department,SubDept,Password,UserTypeId  
,DefaultLinkId,PrefLang,AfterLoginSP,Permission,ReportingManager,EmailId,1  
from obps_Users_temp  
  
  
SET @userid=(select id from obps_Users where UserName=@originalusername)  
  
DECLARE user_cursor CURSOR  
FOR SELECT UserName FROM obps_Users_temp;  
  
OPEN user_cursor;  
  
FETCH NEXT FROM user_cursor INTO   
    @usrname;  
  
 WHILE @@FETCH_STATUS = 0  
    BEGIN  
   
  SET @newuserid=(select id from obps_Users where username=@usrname)  
  insert into obps_UserLinks(UserId,UserName,LinkId,LinkName,CreatedDate,CreatedBy,ModifiedBy,IsActive  
        ,IsDeleted,RoleId,sublinkid,IsRoleAttached)  
  select @newuserid,UserName,LinkId,LinkName,CreatedDate,CreatedBy,ModifiedBy,IsActive  
        ,IsDeleted,RoleId,sublinkid,IsRoleAttached from obps_UserLinks where UserId=@userid  
      
  
        FETCH NEXT FROM user_cursor INTO @usrname;  
    END;  
  
CLOSE user_cursor;  
  
DEALLOCATE user_cursor;  
  
truncate table obps_Users_temp

END  
GO

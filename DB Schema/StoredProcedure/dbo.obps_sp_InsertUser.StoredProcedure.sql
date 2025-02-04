USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertUser]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[obps_sp_InsertUser]    
@UserName nvarchar(MAX)='',    
@RoleId nvarchar(MAX)='',    
@companyName  nvarchar(MAX)='',    
@Division nvarchar(MAX)='',    
@Department nvarchar(MAX)='',    
@SubDept nvarchar(MAX)='',    
@Password nvarchar(MAX)='',    
@UserTypeId nvarchar(MAX)='',    
@DefaultLinkId nvarchar(MAX)='' ,  
@AfterLoginSp nvarchar(MAX)='',
@emailid nvarchar(MAX)=''  ,
@Reportingmgr nvarchar(MAX)=''

AS    
BEGIN    
 DECLARE @UserExist int=0;    
 set @UserExist=(select count(*) from obps_Users where UserName=@UserName)    
 if @UserExist>0    
  select 'User already exist'    
 else    
 BEGIN    
  INSERT INTO obps_Users(UserId,UserName,RoleId,Company,Division,Department,SubDept,Password,UserTypeId,DefaultLinkId,AfterLoginSP,EmailId,ReportingManager,IsResetPassword )    
  values    
  (1,@UserName,@RoleId,@companyName ,@Division,@Department,@SubDept,@Password,@UserTypeId,@DefaultLinkId,@AfterLoginSp,@emailid,@Reportingmgr,1 )    
  select 'User Added'    
 END    
END    

GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateUsertemp]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[obps_sp_UpdateUsertemp]        
@UserName nvarchar(MAX)='',        
@RoleId nvarchar(MAX)='',        
@Company nvarchar(MAX)='',     
@email  nvarchar(MAX)='',     
@Division nvarchar(MAX)='',        
@Department nvarchar(MAX)='',        
@SubDept nvarchar(MAX)='',        
@UserTypeId nvarchar(MAX)='',        
@DefaultLinkId nvarchar(MAX)='',        
@id nvarchar(MAX)=''  ,      
@AfterLoginSp nvarchar(MAX)='' ,    
@reportingmanager nvarchar(MAX)=''     
AS        
BEGIN        
        
DECLARE @count nvarchar(MAX)        
DECLARE @userselcount nvarchar(MAX)        
DECLARE @userlinkid nvarchar(MAX)=''        
        
 SET @count=(select count(*) from obps_Users where id=@id)        
 --IF @count>0         
 BEGIN        
  update obps_Users_temp set UserName=@UserName,RoleId=@RoleId,Company=@Company,Division=@Division,        
  Department=@Department,SubDept=@SubDept,emailid=@email,UserTypeId=@UserTypeId,DefaultLinkId=@DefaultLinkId,      
  AfterLoginSP=@AfterLoginSp,reportingmanager=@reportingmanager where ID=@id        
        
 END        
END 
GO

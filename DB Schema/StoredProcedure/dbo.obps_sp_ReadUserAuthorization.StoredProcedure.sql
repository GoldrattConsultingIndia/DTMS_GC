USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadUserAuthorization]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_ReadUserAuthorization]  
@linkid nvarchar(4)='',  
@username nvarchar(MAX)=''  
AS  
BEGIN  
  
DECLARE @isvalid int  
SET @isvalid=(select count(*) from obps_UserLinks where sublinkid=@linkid  
    and userid in(select id from obps_Users where UserName=@username))  
  
if(@isvalid>=1)
select 1  
else
select 0
  
END
GO

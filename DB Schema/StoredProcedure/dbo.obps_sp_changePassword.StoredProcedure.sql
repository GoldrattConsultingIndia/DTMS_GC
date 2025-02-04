USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_changePassword]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[obps_sp_changePassword]  
@Username NVARCHAR(MAX)=NULL,  
@currentpassword NVARCHAR(MAX)=NULL,  
@newpassword NVARCHAR(MAX)=NULL  
AS  
BEGIN  
  if(Exists( select Id from obps_Users  
   where UserName=@Username and Password=@currentpassword))  
   BEGIN  
  
   update obps_Users  
   SET Password=@newpassword ,
   IsResetPassword=0
   where UserName=@Username  
  
   select 1 as IsPasswordChanged  
  
   END  
   ELSE  
   BEGIN  
   select 0 as IsPasswordChanged  
  END  
END  
GO

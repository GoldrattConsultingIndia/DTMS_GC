USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_CheckResetPassword]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_CheckResetPassword]  
@usrname nvarchar(100)  
AS  
BEGIN  
 select IsResetPassword from obps_Users   
 where UserName=@usrname  
END
GO

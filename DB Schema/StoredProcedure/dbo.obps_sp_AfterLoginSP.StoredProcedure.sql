USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_AfterLoginSP]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_AfterLoginSP]
@usrname NVARCHAR(MAX)=''
AS
BEGIN
DECLARE @AfterLoginSP nvarchar(MAX)=''
SET @AfterLoginSP=(select AfterLoginSP from obps_Users where UserName=@usrname)
if(LEN(RTRIM(LTRIM(@AfterLoginSP)))>1)
exec @AfterLoginSP
END
GO

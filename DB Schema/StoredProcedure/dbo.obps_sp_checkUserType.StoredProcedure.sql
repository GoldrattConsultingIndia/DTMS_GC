USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_checkUserType]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_checkUserType]
@UserType nvarchar(MAX),
@id nvarchar(MAX)=''
AS
BEGIN
if @id<>''
BEGIN
	IF ((SELECT count(*) from obps_UserType where UserType=@UserType and id<>@id)>0)
	BEGIN
		select 0---user type exist in the db
	END
	ELSE
	BEGIN
		select 1---user type not exist in the db
	END								
END
ELSE
BEGIN
	IF ((SELECT count(*) from obps_UserType where UserType=@UserType)>0)
	BEGIN
		select 0---user type exist in the db
	END
	ELSE
	BEGIN
		select 1---user type not exist in the db
	END	
END
END
GO

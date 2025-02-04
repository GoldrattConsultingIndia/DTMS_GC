USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertUserRole]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_InsertUserRole]
@roleId NVARCHAR(MAX)='',
@groupName NVARCHAR(MAX)=''
AS
BEGIN
	DECLARE @RoleExist int=0;
	set @RoleExist=(select count(*) from obps_rolemaster where roleid=@roleId)
	if @RoleExist>0
		select 'Role already exist'
	else
	BEGIN
		INSERT INTO obps_RoleMaster(RoleId)
		values
		(@roleId)
		select 'Role Added'
	END
END
GO

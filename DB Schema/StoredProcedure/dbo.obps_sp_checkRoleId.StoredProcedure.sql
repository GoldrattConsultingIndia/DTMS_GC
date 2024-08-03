USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_checkRoleId]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_checkRoleId]
@RoleId nvarchar(MAX)
AS
BEGIN
IF ((SELECT count(*) from obps_RoleMaster where RoleId=@RoleId)>0)
BEGIN
    select 0---role exist in the db
END
ELSE
BEGIN
	select 1---role not exist in the db
END
END
GO

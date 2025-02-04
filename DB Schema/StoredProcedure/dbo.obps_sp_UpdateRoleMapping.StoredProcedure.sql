USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateRoleMapping]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_UpdateRoleMapping]
@id int='',
@index int=''
AS
BEGIN
BEGIN TRY
	update obps_RoleMap set VisibilityIndex=@index where id=@id
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE()
END CATCH
END
GO

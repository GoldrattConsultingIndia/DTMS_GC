USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_DeleteUserPermission]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_DeleteUserPermission]
@id int=0
AS
BEGIN
BEGIN TRY

	delete from obps_SpPermissions where id=@id

END TRY
BEGIN CATCH
	select ERROR_MESSAGE()
END CATCH
END

GO

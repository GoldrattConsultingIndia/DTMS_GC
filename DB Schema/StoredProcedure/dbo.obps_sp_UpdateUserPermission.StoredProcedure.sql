USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateUserPermission]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_UpdateUserPermission]
@id int=0,
@userid nvarchar(MAX)='',
@linkid nvarchar(MAX)='',
@gid nvarchar(MAX)='',
@par1 nvarchar(MAX)='',
@par2 nvarchar(MAX)='',
@par3 nvarchar(MAX)='',
@par4 nvarchar(MAX)='',
@par5 nvarchar(MAX)=''
AS
BEGIN
BEGIN TRY

	update obps_SpPermissions set userid=@userid,Linkid=@linkid,
		   gridid=@gid,Par1=@par1,Par2=@par2,Par3=@par3,
		   par4=@par4,par5=@par5 where id=@id

END TRY
BEGIN CATCH
	select ERROR_MESSAGE()
END CATCH
END
GO

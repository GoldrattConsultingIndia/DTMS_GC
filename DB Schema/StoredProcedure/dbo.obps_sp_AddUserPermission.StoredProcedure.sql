USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_AddUserPermission]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_AddUserPermission]
@userid int='',
@linkid int='',
@gid int='',
@par1 nvarchar(MAX)='',
@par2 nvarchar(MAX)='',
@par3 nvarchar(MAX)='',
@par4 nvarchar(MAX)='',
@par5 nvarchar(MAX)=''
AS
BEGIN

BEGIN TRY

	INSERT INTO obps_SpPermissions(UserId,Linkid,Gridid,Par1,Par2,Par3,Par4,Par5)
	VALUES(@userid,@linkid,@gid,@par1,@par2,@par3,@par4,@par5)

END TRY
BEGIN CATCH

	SELECT ERROR_MESSAGE()

END CATCH

END
GO

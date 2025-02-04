USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetToolbarOption]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_GetToolbarOption]
@GridId nvarchar(2)='',
@LinkId nvarchar(2)=''
AS
BEGIN
	DECLARE @IsAdd nvarchar(MAX),
	@IsEdit nvarchar(MAX),
	@IsToolbar nvarchar(MAX),
	@GridAddName nvarchar(MAX),
	@GridEditName nvarchar(MAX),
	@GridToolbarName nvarchar(MAX),
	@colnamequery1 nvarchar(MAX),
	@colnamequery2 nvarchar(MAX),
	@colnamequery3 nvarchar(MAX)

	SET @GridAddName='Grid'+@GridId+'AllowAdd'
	SET @GridEditName='Grid'+@GridId+'AllowEdit'
	SET @GridToolbarName='Grid'+@GridId+'AllowToolbar'

	SET @colnamequery1=('(select @IsAdd='+@GridAddName+' from obps_TopLinks where ID='''+@LinkId +''')')
	EXEC Sp_executesql  @colnamequery1,  N'@IsAdd NVARCHAR(MAX) output',  @IsAdd output

	SET @colnamequery2=('(select @IsEdit='+@GridEditName+' from obps_TopLinks where ID='''+@LinkId +''')')
	EXEC Sp_executesql  @colnamequery2,  N'@IsEdit NVARCHAR(MAX) output',  @IsEdit output

	SET @colnamequery3=('(select @IsToolbar='+@GridToolbarName+' from obps_TopLinks where ID='''+@LinkId +''')')
	EXEC Sp_executesql  @colnamequery3,  N'@IsToolbar NVARCHAR(MAX) output',  @IsToolbar output

	SELECT @IsToolbar,@IsAdd,@IsEdit
END
GO

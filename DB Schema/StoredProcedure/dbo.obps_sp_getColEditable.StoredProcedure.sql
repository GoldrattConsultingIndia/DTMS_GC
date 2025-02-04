USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getColEditable]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getColEditable]
@Gridname NVARCHAR(MAX)=NULL,
@colname NVARCHAR(MAX)=NULL,
@RoleId NVARCHAR(MAX)=NULL,
@LinkId NVARCHAR(MAX)=NULL
AS
BEGIN
	   DECLARE @query NVARCHAR(MAX),
	   @query_Isditid NVARCHAR(MAX),
	   @tabname NVARCHAR(MAX),
	   @cid NVARCHAR(MAX),
	   @indx int,
	   @spquery NVARCHAR(MAX) ,
	   @spname NVARCHAR(MAX),
	   @IsEdit NVARCHAR(20),
	   @colname_new NVARCHAR(MAX)

	SET NOCOUNT ON

	SET @indx=(select CHARINDEX ('__',@colname,0 ))
	SET @colname_new=(SELECT SUBSTRING(@colname, 1, @indx-1))

	SET @spquery=('(SELECT @spname='+@Gridname+' FROM Obps_LFLinks where '+@Gridname+'  is not null and LinkId='''+@LinkId+''')')
	EXEC Sp_executesql  @spquery,  N'@spname NVARCHAR(MAX) output',  @spname output

	SET @query_Isditid=('SELECT @IsEdit=IsEditable FROM Obps_RoleMap WHERE TableId in 
						(select TableId from Obps_TableId where TableName in(SELECT DISTINCT t.name 
	FROM sys.sql_dependencies d 
	INNER JOIN sys.procedures p ON p.object_id = d.object_id
	INNER JOIN sys.tables     t ON t.object_id = d.referenced_major_id
	where p.name='''+@spname+'''))and ColName='''+@colname_new+'''and RoleId='+@RoleId+'')

	EXEC Sp_executesql  @query_Isditid,  N'@IsEdit int output',  @cid output
	SELECT @cid

END
GO

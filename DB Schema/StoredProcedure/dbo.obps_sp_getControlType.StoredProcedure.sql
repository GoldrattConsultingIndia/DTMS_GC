USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getControlType]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getControlType]
@Gridname NVARCHAR(MAX)=NULL,
@colname NVARCHAR(MAX)=NULL
AS
BEGIN
	DECLARE @query NVARCHAR(MAX),
			   @query_control NVARCHAR(MAX),
			   @tabname NVARCHAR(MAX),
			   @cid NVARCHAR(MAX),
			   @spquery NVARCHAR(MAX) ,
			   @spname NVARCHAR(MAX)

    SET NOCOUNT ON;
 
	SET @spquery=('(SELECT @spname='+@Gridname+' FROM Obp_LFLinks where '+@Gridname+'  is not null)')
	EXEC Sp_executesql  @spquery,  N'@spname NVARCHAR(MAX) output',  @spname output

	SET @tabname=(SELECT DISTINCT t.name 
	FROM sys.sql_dependencies d 
	INNER JOIN sys.procedures p ON p.object_id = d.object_id
	INNER JOIN sys.tables     t ON t.object_id = d.referenced_major_id
	where p.name=@spname )

	SET @query_control=('SELECT @control = ColControlType FROM Obp_ColAttrib WHERE TableName='''+@tabname+'''
						and ColName='''+@colname+'''')
	EXEC Sp_executesql  @query_control,  N'@control NVARCHAR(MAX) output',  @cid output
	IF @cid='DropDownList' 
	BEGIN
		select '1'
	END
	ELSE
	BEGIN
		SELECT '0'
	END


END


GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateDataDetails_FirstGrid]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_UpdateDataDetails_FirstGrid]
      @Field NVARCHAR(MAX),
      @value NVARCHAR(MAX),
	  @key nvarchar(50)
AS
BEGIN

	  DECLARE @query NVARCHAR(MAX)
	  DECLARE @query_Key NVARCHAR(MAX)
	  DECLARE @tabname NVARCHAR(MAX)
	  DECLARE @pkey NVARCHAR(MAX)
      SET NOCOUNT ON;
 
	SET @tabname=(SELECT DISTINCT t.name 
	FROM sys.sql_dependencies d 
	INNER JOIN sys.procedures p ON p.object_id = d.object_id
	INNER JOIN sys.tables     t ON t.object_id = d.referenced_major_id
	where p.name='sp_getData_Grid1' )
	--SET @query_Key='SELECT TableKey FROM Obp_TableId WHERE TableName='+@tabname
	--SET @pkey=(SELECT @query_Key)
	
	SET @query_Key=('SELECT @key = TableKey FROM Obp_TableId WHERE TableName='''+@tabname+'''')
	--print @query_Key
	EXEC Sp_executesql  @query_Key,  N'@key NVARCHAR(MAX) output',  @pkey output
	--select @pkey
	 set @query='UPDATE '+@tabname+' set '+@Field+'='''+@value+''' where pid='+@key+''
	 print @query
	 EXEC (@query)
END
GO

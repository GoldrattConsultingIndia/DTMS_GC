USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_DeleteTable]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_DeleteTable]
@id nvarchar(MAX)
AS
BEGIN
	DECLARE @tabname nvarchar(MAX)='',@str nvarchar(MAX)=''
	SET @tabname=(select tablename from obps_TableId where TableId=@id)

	delete from obps_TableId where TableId=@id
	delete from obps_ColAttrib where TableID=@id
	delete from obps_RoleMap where TableID=@id
	SET @str='DROP table '+@tabname
	exec (@str)
END
GO

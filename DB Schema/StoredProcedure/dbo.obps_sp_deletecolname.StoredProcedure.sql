USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_deletecolname]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_deletecolname]
@colname nvarchar(MAX)='',
@tablename nvarchar(MAX)=''
AS
BEGIN
DECLARE @str nvarchar(MAX)=''
BEGIN TRY

	SET @str='ALTER TABLE '+@tablename+' DROP COLUMN '+@colname 
	exec (@str)

END TRY
BEGIN CATCH
	select ERROR_MESSAGE()
END CATCH

END
GO

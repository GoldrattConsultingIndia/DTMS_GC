USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_checkColNameExistance]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[obps_sp_checkColNameExistance]
@tablename nvarchar(MAX)='',
@colname nvarchar(MAX)=''
AS
BEGIN

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = @colname
          AND Object_ID = Object_ID(@tablename))
BEGIN
	SELECT '1'
END
ELSE
	SELECT '0'
END
GO

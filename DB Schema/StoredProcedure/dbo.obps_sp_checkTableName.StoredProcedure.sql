USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_checkTableName]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_checkTableName]    
@tablename NVARCHAR(MAX)=''    
AS    
BEGIN    
SET @tablename='obp_'+@tablename
truncate table obps_CreateTableTemp 
IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE --TABLE_SCHEMA = 'TheSchema' 
                 --AND 
TABLE_NAME = @tablename))
BEGIN
    select 0---table name exist in the db
END
ELSE
BEGIN
select 1---table name not exist in the db
END

END
GO

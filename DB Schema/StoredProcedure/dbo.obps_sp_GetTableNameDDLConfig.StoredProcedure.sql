USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetTableNameDDLConfig]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_GetTableNameDDLConfig]    
@linkid NVARCHAR(MAX)=''--,    
--@menuid NVARCHAR(MAX)=4    
AS    
BEGIN    
    
DECLARE @sp NVARCHAR(MAX)=''   
    
if object_id('TableNameTab','U') is not null    
 DROP TABLE TableNameTab    
    
CREATE TABLE TableNameTab(table_name nvarchar(MAX))    
    
DECLARE cursor_gridsp CURSOR
FOR select gridsp from obps_toplinkextended where Linkid=@linkid;

OPEN cursor_gridsp;

FETCH NEXT FROM cursor_gridsp INTO @sp;

WHILE @@FETCH_STATUS = 0
    BEGIN

	INSERT INTO TableNameTab    
	 SELECT NAME FROM SYSOBJECTS WHERE ID IN (SELECT SD.DEPID  FROM SYSOBJECTS SO,     
	 SYSDEPENDS SD WHERE SO.NAME = @sp AND SD.ID = SO.ID)


	FETCH NEXT FROM cursor_gridsp INTO @sp;
    END;

CLOSE cursor_gridsp;

DEALLOCATE cursor_gridsp;
    
select distinct table_name from TableNameTab    
    
END    

GO

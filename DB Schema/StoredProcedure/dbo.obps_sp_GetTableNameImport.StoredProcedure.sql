USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetTableNameImport]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_GetTableNameImport]      
@LinkId int=''      
AS      
BEGIN      
 select TempTableName from obps_ExcelImportConfig where linkid=@linkid  
 /*select  replace(TempTableName,'_temp','') TableName from obps_ExcelImportConfig where linkid=@linkid  */
  

END 
GO

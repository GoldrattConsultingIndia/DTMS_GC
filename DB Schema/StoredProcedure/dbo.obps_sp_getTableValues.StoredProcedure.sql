USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getTableValues]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getTableValues]    
AS    
BEGIN    
 select Columnname,DataType,AllowNulls as 'Allow Null',DefaultValue,UserColumn from obps_CreateTableTemp
END   
GO

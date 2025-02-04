USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetRoleMapDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_GetRoleMapDetails]  
 @tablename nvarchar(MAX)=''  
AS  
BEGIN  
 SELECT [RoleId], [ColName],data_type as 'datatype', 1, [IsEditable], [TableName], [Displayorder], [gridid]   
 FROM [obps_RoleMap] r inner join INFORMATION_SCHEMA.COLUMNS  i  
 on r.TableName=i.TABLE_NAME  
 WHERE [TableName]=@tablename  
END  
  
GO

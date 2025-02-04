USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetDDLDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_GetDDLDetails]  
AS  
BEGIN  
select D.id as 'id',M.DisplayName as 'menuname',LinkName,linkid,TableName,ColName,ColumnToInsert,ColumnToSelect,TableToSelect,case when IsId=1 then 1 else 0 end as'IsId'   
 from obps_DropDownTable D inner join obps_ColAttrib C  
 on D.ColumnId=C.ID  inner join obps_TopLinks T on T.id=C.LinkId
 inner join obps_MenuName M on M.menuid=T.menuid 
END  
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_GetRowattribDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_admin_GetRowattribDetails]  
AS  
BEGIN  
  
 select R.id,M.DisplayName,L.LinkName,R.TableName,ColName,MappedCol,R.GridId,IsBackground,CellEditColName,CellCtrlTypeColName,DdlCtrlSpColName  
 from obps_RowAttrib R inner join obps_TableId T on R.TableID=T.TableId  
 inner join obps_TopLinks L on L.id=R.LinkId inner join obps_MenuName M on L.MenuId=M.Id  
  
END
GO

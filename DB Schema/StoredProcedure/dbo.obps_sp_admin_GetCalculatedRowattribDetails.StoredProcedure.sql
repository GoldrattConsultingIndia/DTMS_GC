USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_GetCalculatedRowattribDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[obps_sp_admin_GetCalculatedRowattribDetails]  
AS  
BEGIN  
  
 select R.id,M.DisplayName,L.LinkName,ColName,MappedCol,R.GridId,IsBackground,CellEditColName  
 from obps_calculatedRowAttrib R inner join obps_TopLinks L on L.id=R.LinkId 
 inner join obps_MenuName M on L.MenuId=M.Id  
  
END
GO

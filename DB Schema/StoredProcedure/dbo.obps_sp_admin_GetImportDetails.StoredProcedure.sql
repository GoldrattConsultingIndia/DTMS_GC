USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_GetImportDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_admin_GetImportDetails]
AS
BEGIN
select I.Id,Displayname  as 'MainMenu',LinkName as 'SubMenu',
TableName,TempTableName,InsertSp from
obps_ExcelImportConfig I inner join obps_toplinks T on T.id=I.linkid 
inner join obps_MenuName M on T.MenuId=M.MenuId
END
GO

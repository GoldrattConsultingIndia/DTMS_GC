USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_getGanttSettingsDetailsDisplay]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[obps_sp_admin_getGanttSettingsDetailsDisplay]
  @id nvarchar(MAX)=''
  AS
  BEGIN

	SELECT GanttSp,DependencySp from obps_GanttConfiguration where LinkId=@id

  END
GO

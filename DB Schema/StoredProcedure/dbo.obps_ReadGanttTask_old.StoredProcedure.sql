USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_ReadGanttTask_old]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_ReadGanttTask_old]
@lnkId nvarchar(MAX)=''
AS
BEGIN

DECLARE @ganttsp nvarchar(MAX)

SET @ganttsp= (select GanttSp from obps_ganttconfiguration where LinkId=@lnkId)

exec @ganttsp

END
GO

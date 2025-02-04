USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_getGanttTask_old]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_getGanttTask_old]
@selData nvarchar(MAX)='',
@lnkId  nvarchar(MAX)=''
AS
BEGIN
--Gant -1
/* For Work Order Status*/
--exec obp_sp_PH_wogantt
/*End -  For Work Order Status */

--Gant -2
/*  For Resource Detail Status */

--exec obp_sp_PH_ResourceLoadDetailsGantt

/*End-   For Resource Detail Status */

--Gant -3
/*  For Resource Status */

--exec obp_sp_PH_ResourceLoadGantt

/*End-   For Resource Status */

DECLARE @ganttsp nvarchar(MAX)

SET @ganttsp= (select GanttSp from obps_ganttconfiguration where LinkId=@lnkId)
if @selData='' or @selData is null
	exec @ganttsp 
else
	exec @ganttsp @selData
END
GO

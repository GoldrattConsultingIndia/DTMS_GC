USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_admin_charttype]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[obps_admin_charttype]  
AS  
BEGIN  
select distinct id,charttypes from obps_ChartTypeMaster  
END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getPivotData]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getPivotData]
AS
BEGIN
select classification,Start_Date,demand from OBP_PRJ_011
END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getDDDataClassification]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getDDDataClassification]
AS
BEGIN
	select distinct ClientName,Id from obp_ClientMaster
END
GO

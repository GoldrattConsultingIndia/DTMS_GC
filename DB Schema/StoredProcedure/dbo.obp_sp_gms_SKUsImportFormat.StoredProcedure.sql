USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_SKUsImportFormat]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_SKUsImportFormat]
AS 
BEGIN
	select 'SkuCode'
	UNION
	SELECT 'SkuDescription'
END
GO

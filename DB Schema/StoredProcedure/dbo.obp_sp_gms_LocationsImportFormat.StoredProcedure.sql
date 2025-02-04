USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_LocationsImportFormat]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_LocationsImportFormat]
AS 
BEGIN
	select 'LocationCode'
	UNION
	select 'LocationDescription'
	UNION
	select 'LocationType'
	UNION
	select 'City'
	UNION
	select 'State'
	UNION
	select 'Region'
	UNION
	select 'Pincode'
	UNION
	select 'DefaultOrigin'
	UNION
	select 'AutoInDays'
	UNION
	select 'ReplWeekDays'
	UNION
	select 'LocationPriority'
	UNION
	select 'ReplPolicyName'
	UNION
	select 'IsSmartReplAcitve'
	UNION
	select 'ReplHoldDays'
END
GO

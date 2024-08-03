USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getDashboardRecords]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_getDashboardRecords]          
AS          
BEGIN   

select D.id 'id',Caption,displayname,linkname 
	from obps_Dashboards D
	left join obps_toplinks T on T.id=D.linkid
	left join obps_MenuName M on M.menuid=T.menuid
	

END
GO

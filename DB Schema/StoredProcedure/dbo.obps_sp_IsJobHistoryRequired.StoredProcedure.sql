USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_IsJobHistoryRequired]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_IsJobHistoryRequired]
@linkid nvarchar(4)='',
@username nvarchar(MAX)=''
AS
BEGIN

select ShowJobHistory from obps_TopLinkExtended
	where linkid=@linkid and gridid=1

END
GO

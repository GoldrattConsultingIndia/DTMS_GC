USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getSubLinkDashboard]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getSubLinkDashboard]
@linkid nvarchar(MAX)=''
AS
BEGIN

select Id,LinkName from obps_TopLinks where MenuId=@linkid

END
GO

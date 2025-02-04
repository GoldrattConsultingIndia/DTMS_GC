USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadCalendarDates]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_ReadCalendarDates]
@linkid nvarchar(MAX)='',
@username nvarchar(MAX)='',
@dateval nvarchar(MAX)='',
@loc nvarchar(25)=''
AS
BEGIN
DECLARE @tablename nvarchar(MAX)
SET @tablename=(select top 1 gridtable from obps_TopLinkExtended where Linkid=@linkid)

select date from obp_gms_HolidayList

END
GO

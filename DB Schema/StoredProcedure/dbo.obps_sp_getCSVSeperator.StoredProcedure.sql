USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getCSVSeperator]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getCSVSeperator]
@linkid nvarchar(MAX)='',
@username nvarchar(MAX)=''
AS
BEGIN

select CSVSeperator from obps_toplinks where id=@linkid

END
GO

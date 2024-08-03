USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_getLayout1GridDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_getLayout1GridDetails]
@usrname nvarchar(MAX)=''
AS
BEGIN

	DECLARE @spname NVARCHAR(MAX)

SET @spname=(select spName from obps_pagelayout where isActive=1)

exec @spname @usrname

END
GO

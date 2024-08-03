USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetAllowedExtensions]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_GetAllowedExtensions]
@linkid nvarchar(MAX)=''
AS
BEGIN

DECLARE @Values nvarchar(MAX)=''
SET @Values=(select AllowedExtension from obps_toplinks where id=@linkid)
	SELECT items
    FROM [dbo].[Split_Upload] (@Values, ',')
END
GO

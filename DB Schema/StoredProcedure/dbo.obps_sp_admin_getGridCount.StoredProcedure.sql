USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_getGridCount]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_admin_getGridCount]
@sublink int=0
AS
BEGIN
DECLARE @pagetype int,
@gcount int

SET @pagetype=(select type from obps_TopLinks where id=@sublink)

SET @gcount=(SELECT Gridcount from obps_PageType where PageTypeId=@pagetype)

select @gcount

END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_getPageLayout]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_getPageLayout]
AS
BEGIN
select layoutName,SpName from [dbo].[Obps_PageLayout] where IsActive=1
END


GO

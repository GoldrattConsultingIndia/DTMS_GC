USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getCondFormatIcon]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[obps_sp_getCondFormatIcon]
AS
BEGIN

select id,icon 'image' from obps_FormatCondIcon

END
GO

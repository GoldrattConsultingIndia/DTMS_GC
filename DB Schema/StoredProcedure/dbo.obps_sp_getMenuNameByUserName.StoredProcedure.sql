USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getMenuNameByUserName]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getMenuNameByUserName]
@userid int
AS
BEGIN

select distinct LinkId,LinkName from obps_UserLinks 
where UserId=@userid and  IsActive=1 and TRIM(LinkName)<>''

END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getAdminSubLink]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getAdminSubLink]        
@linkid int=''
AS
BEGIN

select  Id,linkname from obps_toplinks where MenuId=@linkid  
order by LinkName    

END
GO

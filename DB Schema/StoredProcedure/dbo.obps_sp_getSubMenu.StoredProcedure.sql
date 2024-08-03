USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getSubMenu]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getSubMenu]
@linkid int=''  
AS  
BEGIN

 select  id,linkname from obps_TopLinks where MenuId=@linkid  order by SortOrder    
END
GO

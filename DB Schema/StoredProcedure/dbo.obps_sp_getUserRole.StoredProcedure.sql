USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getUserRole]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getUserRole]      
AS      
BEGIN      
 select id,RoleId from obps_RoleMaster order by  roleid asc
 --select ID,clientname as name from obp_ClientMaster      
END     
GO

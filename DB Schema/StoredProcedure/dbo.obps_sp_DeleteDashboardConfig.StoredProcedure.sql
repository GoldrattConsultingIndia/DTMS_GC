USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_DeleteDashboardConfig]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_DeleteDashboardConfig]    
@id nvarchar(MAX)=''    
AS    
BEGIN    
 delete from obps_Dashboards where id=@id    
END    
GO

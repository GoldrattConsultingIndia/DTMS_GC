USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateDashboardConfig]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[obps_sp_UpdateDashboardConfig]  
@sublinkid nvarchar(MAX)='',  
@id nvarchar(MAX)=''  
AS  
BEGIN  
DECLARE @count nvarchar(MAX)  
 SET @count=(select count(*) from obps_Dashboards where id=@id)  
 IF @count>0   
 BEGIN  
  update obps_Dashboards set LinkId=@sublinkid where id=@id  
 END  
END  
GO

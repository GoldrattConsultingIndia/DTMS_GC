USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetTriggerRefresh]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_GetTriggerRefresh]   
@linkId nvarchar(2)=''    
AS    
BEGIN  

select TriggerGrid,RefreshGrid from obps_TopLinks where id=@linkId  
  
  
END  

GO

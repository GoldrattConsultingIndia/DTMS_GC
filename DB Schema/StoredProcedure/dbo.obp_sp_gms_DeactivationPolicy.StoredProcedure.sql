USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_DeactivationPolicy]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_DeactivationPolicy]    
(@var_user nvarchar(100)=''                                        
,@var_pid int=''                                        
,@var_clientid int='')      
AS    
BEGIN    
    
select id  
,EventName 'eventname__obp_gms_deactivationpolicy'  
,LocationId 'locationid__obp_gms_deactivationpolicy'  
,FromDate  'fromdate__obp_gms_deactivationpolicy'  
,ToDate 'todate__obp_gms_deactivationpolicy'  
,IsDeactivated 'isdeactivated__obp_gms_deactivationpolicy'  
,isrowedit1
from obp_gms_DeactivationPolicy  
where isdeactivated=0

END
GO

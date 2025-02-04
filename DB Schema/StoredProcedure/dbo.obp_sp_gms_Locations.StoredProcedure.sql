USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_Locations]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_Locations]    
(@var_user nvarchar(100)=''                                        
,@var_pid int=''                                        
,@var_clientid int='')      
AS    
BEGIN    
    
select id    
,LocationCode  'locationcode__obp_gms_locations'  
,LocationDescription  'locationdescription__obp_gms_locations'  
,LocationType  'locationtype__obp_gms_locations'  
,City  'city__obp_gms_locations'  
,State  'state__obp_gms_locations'  
,Region  'region__obp_gms_locations'  
,Pincode  'pincode__obp_gms_locations'  
,DefaultOrigin  'defaultorigin__obp_gms_locations'  
,LocationPriority 'locationpriority__obp_gms_locations'
,ReplWeekDays --'replweekdays__obp_gms_locations'  
,ReplPolicyName-- 'replpolicyname__obp_gms_locations'
,AutoInDays  'autoindays__obp_gms_locations'  
,IsSmartReplAcitve 'issmartreplacitve__obp_gms_locations'
from obp_gms_Locations    
    
END
GO

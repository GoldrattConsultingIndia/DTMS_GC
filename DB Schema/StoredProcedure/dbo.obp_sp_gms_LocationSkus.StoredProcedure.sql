USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_LocationSkus]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_LocationSkus]      
(@var_user nvarchar(100)=''                                          
,@var_pid int=''                                          
,@var_clientid int='')        
AS      
BEGIN      
      
select id    
,LocationId locationid__obp_gms_locationskus    
,SkuId skuid__obp_gms_locationskus    
--,SkuDescription skudescription__obp_gms_locationskus    
,BufferSize buffersize__obp_gms_locationskus    
,ReplTime repltime__obp_gms_locationskus    
,UomId uomid__obp_gms_locationskus    
,InvAtStite invatstite__obp_gms_locationskus    
,InvAtTransit invattransit__obp_gms_locationskus    
,InvAtProduction invatproduction__obp_gms_locationskus    
,DispOriginId1 disporiginid1__obp_gms_locationskus    
,DispOriginId2 disporiginid2__obp_gms_locationskus    
,DispOriginId3 disporiginid3__obp_gms_locationskus    
,MinReplenishmentQty minreplenishmentqty__obp_gms_locationskus    
,ReplenishmentMultiples replenishmentmultiples__obp_gms_locationskus    
,IsReplenish isreplenish__obp_gms_locationskus    
,CreatedDate 'UpdatedDate'    
from obp_gms_LocationSkus      
      
END
GO

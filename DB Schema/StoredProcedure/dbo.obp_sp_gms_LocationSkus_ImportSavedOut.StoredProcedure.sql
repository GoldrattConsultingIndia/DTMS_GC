USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_LocationSkus_ImportSavedOut]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[obp_sp_gms_LocationSkus_ImportSavedOut]           
@usrname NVARCHAR(MAX)= NULL          
as                              
begin                              
                          
 select id
,LocationId
,SkuId
,SkuDescription
,BufferSize
,ReplTime
,UomId
,InvAtStite
,InvAtTransit
,InvAtProduction
,DispOriginId1
,DispOriginId2
,DispOriginId3
,MinReplenishmentQty
,ReplenishmentMultiples
,IsReplenish
,CreatedDate 'UpdatedDate'  
 from obp_gms_LocationSkus_temp                              
 where IsValid=1            
 and         
 UserName=@usrname        
                              
end 
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_Location_ImportSavedOut]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[obp_sp_gms_Location_ImportSavedOut]         
@usrname NVARCHAR(MAX)= NULL        
as                            
begin                            
                        
 select id
,LocationCode
,LocationDescription
,LocationType
,City
,State
,Region
,Pincode
,DefaultOrigin
,AutoInDays
,ReplWeekDays
,LocationPriority
,ReplPolicyName
,IsSmartReplAcitve
,ReplHoldDays
,Reason
,CreatedDate 'UpdatedDate'
 from obp_gms_Locations_temp                            
 where IsValid=1           
 and       
 UserName=@usrname      
                            
end 
GO

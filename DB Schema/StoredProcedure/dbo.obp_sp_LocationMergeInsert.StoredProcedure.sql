USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_LocationMergeInsert]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_LocationMergeInsert]    
@UserName nvarchar(max)                                 
as    
begin     
    
 MERGE obp_gms_Locations AS TARGET    
 USING obp_gms_Locations_temp AS SOURCE    
 ON (TARGET.locationcode=SOURCE.locationcode and    
   TARGET.locationType=SOURCE.locationType)    
 WHEN NOT MATCHED BY TARGET    
 THEN     
  INSERT (LocationCode,LocationDescription,LocationType,City,State
,Region,Pincode,DefaultOrigin,IsActive,AutoInDays,CreatedBy
,CreatedDate,ReplWeekDays,LocationPriority
,ReplPolicyName,IsSmartReplAcitve,ReplHoldDays)      
  VALUES (SOURCE.LocationCode,SOURCE.LocationDescription,SOURCE.LocationType,SOURCE.City,SOURCE.State
,SOURCE.Region,SOURCE.Pincode,SOURCE.DefaultOrigin,1,AutoInDays,@username
,getdate(),SOURCE.ReplWeekDays,SOURCE.LocationPriority
,SOURCE.ReplPolicyName,SOURCE.IsSmartReplAcitve,SOURCE.ReplHoldDays)    
     WHEN MATCHED THEN UPDATE SET    
   TARGET.LocationDescription=SOURCE.LocationDescription ,    
  TARGET.city=SOURCE.city ,    
  TARGET.state=SOURCE.state;    
    
end    
GO

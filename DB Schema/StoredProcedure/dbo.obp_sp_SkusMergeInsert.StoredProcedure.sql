USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_SkusMergeInsert]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_SkusMergeInsert]    
@UserName nvarchar(max)                                 
as    
begin     
    
 MERGE obp_gms_skus AS TARGET    
 USING obp_gms_skus_temp AS SOURCE    
 ON (TARGET.skucode=SOURCE.skucode )    
 WHEN NOT MATCHED BY TARGET    
 THEN     
	  INSERT (Skucode,skudescription)      
	  VALUES (SOURCE.skucode,SOURCE.skudescription)    
 WHEN MATCHED THEN 
	  UPDATE SET    
	  TARGET.skudescription=SOURCE.skudescription;  
    
end    
GO

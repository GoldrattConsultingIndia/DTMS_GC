USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_Skus]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_Skus]    
(@var_user nvarchar(100)=''                                        
,@var_pid int=''                                        
,@var_clientid int='')      
AS    
BEGIN    
    
select id  
,SkuCode 'skucode__obp_gms_skus'  
,SkuDescription 'skudescription__obp_gms_skus'  
,CreatedDate 'Updateddate'  
from   [dbo].[obp_gms_Skus]  
    
END
GO

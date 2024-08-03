USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_UOM]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_UOM]    
(@var_user nvarchar(100)=''                                        
,@var_pid int=''                                        
,@var_clientid int='')      
AS    
BEGIN    
    
select id  
,UOM 'uom__obp_gms_uom'  
from   [dbo].[obp_gms_uom]  
    
END
GO

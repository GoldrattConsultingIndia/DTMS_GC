USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_DeactivationPolicyDelete]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_DeactivationPolicyDelete]  
@key nvarchar(10)='',  
@usr nvarchar(100)  
AS  
BEGIN  
  
update obp_gms_DeactivationPolicy set IsDeactivated=1 where id=@key  
  
END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_DeactivationPolicyAfterSave]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_DeactivationPolicyAfterSave]
@id nvarchar(10)=''
AS
BEGIN

update obp_gms_DeactivationPolicy set isrowedit1=0 where id=@id

END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getLinkDetailsMob]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getLinkDetailsMob]                
@Id int=''                
AS                
BEGIN                
   select Id,Type,case when IsSamePage is null then 0 else IsSamePage end     
   from obps_TopLinks where id=@Id              
END 
GO

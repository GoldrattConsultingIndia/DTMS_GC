USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getTypeId]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getTypeId]  
@Id INT  
AS  
BEGIN  
if @Id=99999
select 50
else if @Id=99998
select 50
else
select Type from Obps_TopLinks where Id=@Id  
END  
GO

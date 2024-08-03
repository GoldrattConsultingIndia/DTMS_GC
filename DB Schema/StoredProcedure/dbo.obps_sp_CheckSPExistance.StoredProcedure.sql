USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_CheckSPExistance]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_CheckSPExistance]  
@Linkd nvarchar(MAX)='',  
@Gridid nvarchar(MAX)=''  
AS  
BEGIN  
DECLARE @spquery nvarchar(Max)='',@spname nvarchar(MAX)=''  

set @spname=( select GridSp from obps_TopLinkExtended where linkid=@Linkd and GridId=@Gridid)
  
if(len(@spname)<=0)  
BEGIN  
  SELECT 0  
END  
ELSE  
BEGIN  
  SELECT 1  
END  
END  
GO

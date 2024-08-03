USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_checksubmenuDashboard]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_checksubmenuDashboard]
@linkid nvarchar(3)='',
@id nvarchar(3)=''
AS
BEGIN

 IF ((SELECT count(*) from obps_Dashboards where LinkId=@linkid and id<>@id)>0)  
 BEGIN  
  select 0--- exist in the db  
 END  
 ELSE  
 BEGIN  
  select 1--- not exist in the db  
 END  

END
GO

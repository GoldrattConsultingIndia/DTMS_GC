USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_AddDate]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_AddDate]  
@date NVARCHAR(MAX)='',
@clientid NVARCHAR(MAX)
--@lId int=''
AS  
BEGIN  
insert into obps_NonWorkingDays values( @clientid,@date)
 --select ID,clientname as name from obp_ClientMaster  
END  
  
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_RemoveDate]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_RemoveDate]  
@date NVARCHAR(MAX)='',
@clientid NVARCHAR(MAX)
--@lId int=''
AS  
BEGIN  
delete from  obps_NonWorkingDays where clientid= @clientid and nonworkingdays=@date
 --select ID,clientname as name from obp_ClientMaster  
END  
  
GO

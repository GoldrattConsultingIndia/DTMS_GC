USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetReportViewerId]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_GetReportViewerId]  
@usrname nvarchar(MAX)='',  
@linkid nvarchar(MAX)=''  
AS  
BEGIN  
  
Select top 1  id from obps_ReportLayout where LinkId=@linkid  
  
END  
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_JobHistoryData]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_JobHistoryData]          
@lId nvarchar(MAX) = '',          
@usrname NVARCHAR(MAX)= NULL         
AS          
BEGIN          
 select id,Jobname,Startdate,Enddate from obps_JobExecutionHistory         
END   
  
GO

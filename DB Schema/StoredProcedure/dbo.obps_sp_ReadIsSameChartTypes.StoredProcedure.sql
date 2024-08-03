USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadIsSameChartTypes]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_ReadIsSameChartTypes]    
@usrname nvarchar(MAX)='',    
@linkid nvarchar(MAX)=''    
AS    
BEGIN    
    
 select IsSameChartType,DepenedentChartTypeDivs from obps_charts where Linkid=@linkid    
    
END  
GO

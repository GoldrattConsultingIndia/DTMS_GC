USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadChartTypes]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[obps_sp_ReadChartTypes]  
@LinkId nvarchar(MAX)='',   
@divid nvarchar(MAX)=''  
AS  
BEGIN  
  
DECLARE @Divname nvarchar(MAX)='', @divquery nvarchar(MAX)='',@Divcharttype nvarchar(MAX)=''  
  
SET @Divname='Div'+@divid+'charttype'  
  
SET @divquery=('(SELECT @Divcharttype='+@Divname+' FROM obps_charts where linkid='''+@LinkId+''')')  
EXEC Sp_executesql  @divquery,  N'@Divcharttype NVARCHAR(MAX) output',  @Divcharttype output  
  
select ROW_NUMBER() OVER(ORDER BY charttypes ASC) AS ID,charttypes as 'NAME' FROM obps_ChartTypeMaster where Chart=(select chart from obps_ChartTypeMaster where ChartTypes=@Divcharttype)  
  
  
END  
GO

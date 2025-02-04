USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetChartProperties]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_GetChartProperties]
@LinkId nvarchar(MAX)=''  
AS  
BEGIN  
DECLARE @i int = 1,@j int = 1
DECLARE @Title nvarchar(MAX)='',@Divnametitle nvarchar(MAX)='',
@Div1Title nvarchar(MAX)='',@Div2Title nvarchar(MAX)='',@Div3Title nvarchar(MAX)='',@Div4Title nvarchar(MAX)='',
@Div5Title nvarchar(MAX)='',@Div6Title nvarchar(MAX)=''
--,@Div1Type nvarchar(MAX)='',@Div2Type nvarchar(MAX)='',
--@Div3Type nvarchar(MAX)='',@Div4Type nvarchar(MAX)='',@Div5Type nvarchar(MAX)='',@Div6Type nvarchar(MAX)=''

if @LinkId<>''  


SET @Title=(select DivTitle from obps_Charts where LinkId=@LinkId)

if len(rtrim(ltrim(@Title)))>0  
BEGIN


WHILE @i <7
BEGIN
	--set @Divnametitle='Div'+CONVERT(varchar(10),@i) +'Title'
	;WITH   cte
			  AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,* FROM STRING_SPLIT(@Title,';')
				 )
		SELECT  @Divnametitle=value
		FROM    cte
		WHERE   ROW_NUM =@i
	if @i=1
		SET @Div1Title=@Divnametitle
	else if @i=2
		SET @Div2Title=@Divnametitle
	else if @i=3
		SET @Div3Title=@Divnametitle
	else if @i=4
		SET @Div4Title=@Divnametitle
	else if @i=5
		SET @Div5Title=@Divnametitle
	else if @i=6
		SET @Div6Title=@Divnametitle

	SET @i  = @i  + 1

END  
END

 select @Div1Title,@Div2Title,@Div3Title,@Div4Title,@Div5Title,@Div6Title,
 Div1Charttype,Div2Charttype,Div3Charttype,Div4Charttype,Div5Charttype,Div6Charttype 
 from obps_charts

 END
GO

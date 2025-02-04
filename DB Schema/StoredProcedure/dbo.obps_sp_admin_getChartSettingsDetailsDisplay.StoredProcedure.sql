USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_getChartSettingsDetailsDisplay]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_admin_getChartSettingsDetailsDisplay]    
@Id nvarchar(MAX)=''    
AS    
BEGIN    
    
DECLARE @ddlsp nvarchar(MAX)='',@divsp nvarchar(MAX)='',@divtitle nvarchar(MAX)='',    
@type int=0,@divcount int=0,    
@div1type nvarchar(MAX)='',@div1spname nvarchar(MAX)='',@div2type nvarchar(MAX)='',@div2spname nvarchar(MAX)='',    
@div3type nvarchar(MAX)='',@div3spname nvarchar(MAX)='',@div4type nvarchar(MAX)='',@div4spname nvarchar(MAX)='',    
@div1title nvarchar(MAX)='',@div2title nvarchar(MAX)='',@div3title nvarchar(MAX)='',@div4title nvarchar(MAX)='',    
@div1filtertxt nvarchar(MAX)='',@div2filtertxt nvarchar(MAX)='',@div3filtertxt nvarchar(MAX)='',@div4filtertxt nvarchar(MAX)='',    
@div1filtersp nvarchar(MAX)='',@div2filtersp nvarchar(MAX)='',@div3filtersp nvarchar(MAX)='',@div4filtersp nvarchar(MAX)='',    
    
@div1filter1txt nvarchar(MAX)='',@div1filter2txt nvarchar(MAX)='',@div1filter3txt nvarchar(MAX)='',    
@div2filter1txt nvarchar(MAX)='',@div2filter2txt nvarchar(MAX)='',@div2filter3txt nvarchar(MAX)='',    
@div3filter1txt nvarchar(MAX)='',@div3filter2txt nvarchar(MAX)='',@div3filter3txt nvarchar(MAX)='',    
@div4filter1txt nvarchar(MAX)='',@div4filter2txt nvarchar(MAX)='',@div4filter3txt nvarchar(MAX)='',    
    
@div1filter1sp nvarchar(MAX)='',@div1filter2sp nvarchar(MAX)='',@div1filter3sp nvarchar(MAX)='',    
@div2filter1sp nvarchar(MAX)='',@div2filter2sp nvarchar(MAX)='',@div2filter3sp nvarchar(MAX)='',    
@div3filter1sp nvarchar(MAX)='',@div3filter2sp nvarchar(MAX)='',@div3filter3sp nvarchar(MAX)='',    
@div4filter1sp nvarchar(MAX)='',@div4filter2sp nvarchar(MAX)='',@div4filter3sp nvarchar(MAX)=''    
    
SET @type=(SELECT type from obps_TopLinks where ID=@Id)    
    
if(@type=23)    
 SET @divcount=2    
else if(@type=24)    
 SET @divcount=4    
else if(@type=21)    
 SET @divcount=1    
    
SET @divsp=(select divsp from obps_charts where linkid=@Id)    
SET @divtitle=(select DivTitle from obps_charts where linkid=@Id)    
    
SET @div1filtertxt=(select Div1FilterText from obps_charts where linkid=@Id)    
SET @div2filtertxt=(select Div2FilterText from obps_charts where linkid=@Id)    
SET @div3filtertxt=(select Div3FilterText from obps_charts where linkid=@Id)    
SET @div4filtertxt=(select Div4FilterText from obps_charts where linkid=@Id)    
    
SET @div1filtersp=(select Div1Filtersp from obps_charts where linkid=@Id)    
SET @div2filtersp=(select Div2Filtersp from obps_charts where linkid=@Id)    
SET @div3filtersp=(select Div3Filtersp from obps_charts where linkid=@Id)    
SET @div4filtersp=(select Div4Filtersp from obps_charts where linkid=@Id)    
    
if object_id('tempdb..#Chartdata','U') is not null    
 drop table #Chartdata    
CREATE TABLE #Chartdata(id int,divsp nvarchar(MAX),divtitle nvarchar(MAX)    
,divfilter1text nvarchar(MAX),divfilter2text nvarchar(MAX),divfilter3text nvarchar(MAX)    
,divfilter1sp nvarchar(MAX),divfilter2sp nvarchar(MAX),divfilter3sp nvarchar(MAX))    
        
if len(rtrim(ltrim(@divsp)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,* FROM STRING_SPLIT(@divsp,';')      
     )      
 insert into #Chartdata(id,divsp)    
 Select ROW_NUM,value from cte    
    
 end    
    
 if len(rtrim(ltrim(@divtitle)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,* FROM STRING_SPLIT(@divtitle,';')      
     )      
 update #Chartdata set divtitle=(select value from cte where  ROW_NUM= id )    
    
 end    
 ------------GETTING FILTER TEXT-----------------------------------    
if len(rtrim(ltrim(@div1filtertxt)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,1 as 'cteid',* FROM STRING_SPLIT(@div1filtertxt,';')      
     )      
 update #Chartdata set divfilter1text=(select value from cte where  ROW_NUM=1 ),    
 divfilter2text=(select value from cte where  ROW_NUM=2  ),divfilter3text=(select value from cte where  ROW_NUM=3 )where id=1        
 end    
if len(rtrim(ltrim(@div2filtertxt)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,2 as 'cteid',* FROM STRING_SPLIT(@div2filtertxt,';')      
     )      
 update #Chartdata set divfilter1text=(select value from cte where ROW_NUM=1 ),    
 divfilter2text=(select value from cte where ROW_NUM=2  ),divfilter3text=(select value from cte where  ROW_NUM=3 ) where id=2    
 end    
    
 if len(rtrim(ltrim(@div3filtertxt)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,1 as 'cteid',* FROM STRING_SPLIT(@div3filtertxt,';')      
     )      
 update #Chartdata set divfilter1text=(select value from cte where  ROW_NUM=1 ),    
 divfilter2text=(select value from cte where  ROW_NUM=2  ),divfilter3text=(select value from cte where  ROW_NUM=3 )where id=3    
    
 end    
if len(rtrim(ltrim(@div4filtertxt)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,2 as 'cteid',* FROM STRING_SPLIT(@div4filtertxt,';')      
     )      
 update #Chartdata set divfilter1text=(select value from cte where ROW_NUM=1 ),    
 divfilter2text=(select value from cte where ROW_NUM=2  ),divfilter3text=(select value from cte where  ROW_NUM=3 ) where id=4    
 end    
 ------------END GETTING FILTER TEXT-----------------------------------    
    
 ------------GETTING FILTER SP-----------------------------------    
if len(rtrim(ltrim(@div1filtersp)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,1 as 'cteid',* FROM STRING_SPLIT(@div1filtersp,';')      
     )      
 update #Chartdata set divfilter1sp=(select value from cte where  ROW_NUM=1 ),    
 divfilter2sp=(select value from cte where  ROW_NUM=2  ),divfilter3sp=(select value from cte where  ROW_NUM=3 )where id=1    
    
 end    
if len(rtrim(ltrim(@div2filtersp)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,2 as 'cteid',* FROM STRING_SPLIT(@div2filtersp,';')      
     )      
 update #Chartdata set divfilter1sp=(select value from cte where ROW_NUM=1 ),    
 divfilter2text=(select value from cte where ROW_NUM=2  ),divfilter3sp=(select value from cte where  ROW_NUM=3 ) where id=2    
 end    
    
 if len(rtrim(ltrim(@div3filtersp)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,1 as 'cteid',* FROM STRING_SPLIT(@div3filtersp,';')      
     )      
 update #Chartdata set divfilter1sp=(select value from cte where  ROW_NUM=1 ),    
 divfilter2sp=(select value from cte where  ROW_NUM=2  ),divfilter3sp=(select value from cte where  ROW_NUM=3 )where id=3    
    
 end    
if len(rtrim(ltrim(@div4filtersp)))>0        
BEGIN      
 ;WITH   cte      
     AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))AS ROW_NUM,2 as 'cteid',* FROM STRING_SPLIT(@div4filtersp,';')      
     )      
 update #Chartdata set divfilter1sp=(select value from cte where ROW_NUM=1 ),    
 divfilter2sp=(select value from cte where ROW_NUM=2  ),divfilter3sp=(select value from cte where  ROW_NUM=3 ) where id=4    
 end    
 ------------END GETTING FILTER SP-----------------------------------    
    
 if(@divcount=1 or @divcount=2 or @divcount=4)    
 BEGIN    
  SET @div1type=(SELECT SUBSTRING(divsp,0,CHARINDEX ('__', divsp)) from #Chartdata where id=1 )      
  SET @div1spname=(SELECT SUBSTRING(divsp,CHARINDEX ('__', divsp)+2,len(divsp)) from #Chartdata where id=1 )      
  SET @div1title=(SELECT divtitle from #Chartdata where id=1 )      
    
  SET @div1filter1txt=(SELECT divfilter1text from #Chartdata where id=1 )     
  SET @div1filter2txt=(SELECT divfilter2text from #Chartdata where id=1 )     
  SET @div1filter3txt=(SELECT divfilter3text from #Chartdata where id=1 )     
    
  SET @div1filter1sp=(SELECT divfilter1sp from #Chartdata where id=1 )     
  SET @div1filter2sp=(SELECT divfilter2sp from #Chartdata where id=1 )     
  SET @div1filter3sp=(SELECT divfilter3sp from #Chartdata where id=1 )     
 END    
 IF (@divcount=2 or @divcount=4)    
 BEGIN    
  SET @div2type=(SELECT SUBSTRING(divsp,0,CHARINDEX ('__', divsp)) from #Chartdata where id=2 )      
  SET @div2spname=(SELECT SUBSTRING(divsp,CHARINDEX ('__', divsp)+2,len(divsp)) from #Chartdata where id=2 )      
  SET @div2title=(SELECT divtitle from #Chartdata where id=2 )      
    
  SET @div2filter1txt=(SELECT divfilter1text from #Chartdata where id=2 )     
  SET @div2filter2txt=(SELECT divfilter2text from #Chartdata where id=2 )     
  SET @div2filter3txt=(SELECT divfilter3text from #Chartdata where id=2 )     
    
  SET @div2filter1sp=(SELECT divfilter1sp from #Chartdata where id=2 )     
  SET @div2filter2sp=(SELECT divfilter2sp from #Chartdata where id=2 )     
  SET @div2filter3sp=(SELECT divfilter3sp from #Chartdata where id=2 )     
    
 END    
 IF ( @divcount=4)    
 BEGIN    
  SET @div3type=(SELECT SUBSTRING(divsp,0,CHARINDEX ('__', divsp)) from #Chartdata where id=3 )      
  SET @div3spname=(SELECT SUBSTRING(divsp,CHARINDEX ('__', divsp)+2,len(divsp)) from #Chartdata where id=3 )     
  SET @div3title=(SELECT divtitle from #Chartdata where id=3 )      
  SET @div3filter1txt=(SELECT divfilter1text from #Chartdata where id=3 )     
  SET @div3filter2txt=(SELECT divfilter2text from #Chartdata where id=3 )     
  SET @div3filter3txt=(SELECT divfilter3text from #Chartdata where id=3 )     
  SET @div3filter1sp=(SELECT divfilter1sp from #Chartdata where id=3 )     
  SET @div3filter2sp=(SELECT divfilter2sp from #Chartdata where id=3 )     
  SET @div3filter3sp=(SELECT divfilter3sp from #Chartdata where id=3 )     
    
  SET @div4type=(SELECT SUBSTRING(divsp,0,CHARINDEX ('__', divsp)) from #Chartdata where id=4 )      
  SET @div4spname=(SELECT SUBSTRING(divsp,CHARINDEX ('__', divsp)+2,len(divsp)) from #Chartdata where id=4 )     
  SET @div4title=(SELECT divtitle from #Chartdata where id=4 )      
  SET @div4filter1txt=(SELECT divfilter1text from #Chartdata where id=4)     
  SET @div4filter2txt=(SELECT divfilter2text from #Chartdata where id=4 )     
  SET @div4filter3txt=(SELECT divfilter3text from #Chartdata where id=4 )     
  SET @div4filter1sp=(SELECT divfilter1sp from #Chartdata where id=4 )     
  SET @div4filter2sp=(SELECT divfilter2sp from #Chartdata where id=4 )     
  SET @div4filter3sp=(SELECT divfilter3sp from #Chartdata where id=4 )     
     
 END    
  select  @divcount,@div1type,@div1spname,@div2type,@div2spname,@div3type,@div3spname,@div4type,@div4spname,    
    Div1Charttype,Div2Charttype,Div3Charttype,Div4Charttype,@div1title,@div2title,@div3title,@div4title,    
   @div1filter1txt,@div1filter2txt,@div1filter3txt,@div2filter1txt,@div2filter2txt,@div2filter3txt,    
   @div3filter1txt,@div3filter2txt,@div3filter3txt,@div4filter1txt,@div4filter2txt,@div4filter3txt,    
   @div1filter1sp,@div1filter2sp,@div1filter3sp,@div2filter1sp,@div2filter2sp,@div2filter3sp,    
   @div3filter1sp,@div3filter2sp,@div3filter3sp,@div4filter1sp,@div4filter2sp,@div4filter3sp,    
   IsSameFilter,DepenedentFilterDivs,IsSameChartType,DepenedentChartTypeDivs     
   from obps_charts where LinkId=@Id    
    
END
GO

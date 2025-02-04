USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_InsertUpdateChartSettings]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     
CREATE PROCEDURE [dbo].[obps_sp_admin_InsertUpdateChartSettings]          
@id int='',    
@linkid int='',     
@savetype nvarchar(MAX)='',    
@DivSp nvarchar(MAX)='',@DivTitle nvarchar(MAX)='',@Div1Charttype nvarchar(MAX)='',    
@Div2Charttype nvarchar(MAX)='',@Div3Charttype nvarchar(MAX)='',@Div4Charttype nvarchar(MAX)='',    
@Div5Charttype nvarchar(MAX)='',@Div6Charttype nvarchar(MAX)='',@Div1FilterSp nvarchar(MAX)='',    
@Div2FilterSp nvarchar(MAX)='',@Div3FilterSp nvarchar(MAX)='',@Div4FilterSp nvarchar(MAX)='',    
@Div5FilterSp nvarchar(MAX)='',@Div6FilterSp nvarchar(MAX)='',@Div1FilterText nvarchar(MAX)='',    
@Div2FilterText nvarchar(MAX)='',@Div3FilterText nvarchar(MAX)='',@Div4FilterText nvarchar(MAX)='',    
@Div5FilterText nvarchar(MAX)='',@Div6FilterText nvarchar(MAX)='',@IsSameFilter nvarchar(MAX)='',    
@DepenedentFilterDivs nvarchar(MAX)='', @IsSameChartType nvarchar(MAX)='',@DepenedentChartTypeDivs nvarchar(MAX)=''    
AS          
BEGIN          
  
DECLARE @count int=0;   
SET @count=(select count(*) from obps_Charts where LinkId=@linkid)  
  
IF @count>0  
 SET @savetype='update'  
else  
 set @savetype='insert'  
   
if(@savetype='insert')    
BEGIN  
 insert into obps_Charts(DivSp,DivTitle,Div1Charttype,Div2Charttype,Div3Charttype,Div4Charttype,Div5Charttype,Div6Charttype,Div1FilterSp,Div2FilterSp,Div3FilterSp,    
 Div4FilterSp,Div5FilterSp,Div6FilterSp,Div1FilterText,Div2FilterText,Div3FilterText,Div4FilterText,Div5FilterText,Div6FilterText,IsSameFilter,DepenedentFilterDivs,    
 IsSameChartType,DepenedentChartTypeDivs,LinkId)    
 values(@DivSp,@DivTitle,@Div1Charttype,@Div2Charttype,@Div3Charttype,@Div4Charttype,@Div5Charttype,@Div6Charttype,@Div1FilterSp,@Div2FilterSp,@Div3FilterSp,    
 @Div4FilterSp,@Div5FilterSp,@Div6FilterSp,@Div1FilterText,@Div2FilterText,@Div3FilterText,@Div4FilterText,@Div5FilterText,@Div6FilterText,@IsSameFilter,@DepenedentFilterDivs,    
 @IsSameChartType,@DepenedentChartTypeDivs,@LinkId)    
END    
else    
BEGIN  
    update obps_charts set DivSp=@DivSp,DivTitle=@DivTitle,Div1Charttype=@Div1Charttype,Div2Charttype=@Div2Charttype,Div3Charttype=@Div3Charttype,Div4Charttype=@Div4Charttype,    
 Div5Charttype=@Div5Charttype,Div6Charttype=@Div6Charttype,Div1FilterSp=@Div1FilterSp,Div2FilterSp=@Div2FilterSp,Div3FilterSp=@Div3FilterSp,Div4FilterSp=@Div4FilterSp,    
 Div5FilterSp=@Div5FilterSp,Div6FilterSp=@Div6FilterSp,Div1FilterText=@Div1FilterText,Div2FilterText=@Div2FilterText,Div3FilterText=@Div3FilterText,Div4FilterText=@Div4FilterText,    
 Div5FilterText=@Div5FilterText,Div6FilterText=@Div6FilterText,IsSameFilter=@IsSameFilter,DepenedentFilterDivs=@DepenedentFilterDivs,IsSameChartType=@IsSameChartType,    
 DepenedentChartTypeDivs=@DepenedentChartTypeDivs where LinkId=@LinkId    
END        
Select '1'          
          
END 
GO

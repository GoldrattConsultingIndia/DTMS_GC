USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateSchedulerDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_UpdateSchedulerDetails]        
 @Gridname NVARCHAR(MAX)='',        
 @str nvarchar(MAX)='',     
 @key nvarchar(50)='',        
 @LinkId NVARCHAR(MAX)='',        
 @usr nvarchar(MAX)=''        
AS        
BEGIN        
        
  DECLARE @query NVARCHAR(MAX),        
  @query_Key NVARCHAR(MAX),        
  @tabname NVARCHAR(MAX),        
  @pkey NVARCHAR(MAX),        
  @tkey NVARCHAR(MAX),        
  @indx int,        
  @colname_new NVARCHAR(MAX),        
  @count int,        
  @datatype nvarchar(MAX),        
  @tabnamestr nvarchar(MAX),        
  @col varchar(MAX),        
  @colnew varchar(MAX)='',        
  @val nvarchar(MAX),        
  @querystr nvarchar(MAX)=''  ,      
  @aftersavesp nvarchar(MAX)='',      
  @aftersavespname nvarchar(MAX)='',      
  @aftersavespnamequery nvarchar(MAX)=''      
      
  DECLARE @gridid nvarchar(MAX),@ddlcoltosel nvarchar(MAX),@ddlcoltoinsert nvarchar(MAX),@ddltabletosel nvarchar(MAX),        
  @controltype varchar(MAX), @queryvalstr NVARCHAR(MAX),@ddlid nvarchar(MAX),@colid int,@isId int    
  DECLARE @Start nvarchar(MAX)='', @End nvarchar(MAX)='', @Text nvarchar(MAX)='', @SchedulerType nvarchar(MAX)='',@include int=0  
        
    SET NOCOUNT ON;        
        
--SET @indx=(select CHARINDEX ('__',@Field,0 ))        
--SET @colname_new=(SELECT SUBSTRING(@Field, 1, @indx-1))        
SET @tabnamestr=('select @tabname='+@Gridname+' from obps_toplinks where ID='+@LinkId)        
EXEC Sp_executesql  @tabnamestr,  N'@tabname NVARCHAR(MAX) output',  @tabname output     
   
  
  SET @Start=(select StartdateCol from obps_SchedulerDataMappingConfig where LinkId=@LinkId)    
  SET @End=(select EnddateCol from obps_SchedulerDataMappingConfig where LinkId=@LinkId)       
  SET @Text=(select TextCol from obps_SchedulerDataMappingConfig where LinkId=@LinkId)    
  SET @SchedulerType=(select SchedulerTypeCol from obps_SchedulerDataMappingConfig where LinkId=@LinkId)    
  
IF @tabname is not null        
BEGIN        
        
DECLARE CUR_TEST CURSOR FAST_FORWARD FOR        
SELECT SUBSTRING (items,0,CHARINDEX(':',items,0)) as colname,SUBSTRING (items,CHARINDEX(':',items,0)+1,len(items)) as colval        
FROM [dbo].[Split_UpdateSp] (@str, ',') ;        
         
OPEN CUR_TEST        
FETCH NEXT FROM CUR_TEST INTO @col,@val        
 WHILE @@FETCH_STATUS = 0        
 BEGIN        
 select @col,@val  
 set @include=0  
 if @col='id'or @col='allDay'   
  set @include=0  
 if(@col='Startdate')  
 begin  
  if (trim(@Start)<>'' or @Start is not null)  
  begin  
   set @include=1  
   set @col=@Start  
   set @val=dateadd(MINUTE,30,dateadd(hour,5,CONVERT(datetime,@val)))  
  end  
 end  
 if(@col='Enddate')  
 begin  
  if (trim(@End)<>'' or @End is not null)  
  begin  
  select 'inside'  
  select @End  
   set @include=1  
   set @col=@End  
   set @val=dateadd(MINUTE,30,dateadd(hour,5,CONVERT(datetime,@val)))  
  end  
 end  
 if(@col='Text')  
 begin  
  if (trim(@Text)<>'' or @Text is not null)  
  begin  
   set @include=1  
   set @col=@Text  
  end  
 end  
 if(@col='ScheduleType')  
 begin  
  if (trim(@SchedulerType)<>'' or @SchedulerType is not null)  
  begin  
   set @include=1  
   set @col=@SchedulerType  
  end  
 end  
      
    
  if @include=1  
  begin  
  
 if @querystr=''        
    begin        
  set @querystr=@querystr+@col+'='''+@val+''''        
    end        
    else        
    begin        
  set @querystr=@querystr+','+@col+'='''+@val+''''        
    end  
  
  end  
  
   FETCH NEXT FROM CUR_TEST INTO @col,@val        
 END        
CLOSE CUR_TEST        
DEALLOCATE CUR_TEST        
        
 END       
        
set @querystr='update '+@tabname+' set '+@querystr++',ModifiedDate='''+CONVERT(CHAR(10),  GETDATE(), 120)+''',ModifiedBy='''+@usr+''' where id='+@key+''       
select @querystr      
EXEC (@querystr)        
      
      
 SET @aftersavesp=(SELECT SUBSTRING(@Gridname, 1,5)+'AfterSaveSp')      
      
 SET @aftersavespnamequery=('(SELECT @aftersavespname='+@aftersavesp+' FROM Obps_TopLinks where '+@aftersavesp+'  is not null and Id='''+@LinkId+''')')        
 EXEC Sp_executesql  @aftersavespnamequery,  N'@aftersavespname NVARCHAR(MAX) output', @aftersavespname output        
        
 IF len(Ltrim(rtrim(@aftersavespname)))>1     
 BEGIN        
  select 'aftersave'      
 EXEC @aftersavespname @key      
 END        
      
END        
GO

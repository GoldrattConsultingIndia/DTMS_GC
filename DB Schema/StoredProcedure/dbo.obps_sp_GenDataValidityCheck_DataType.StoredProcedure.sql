USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GenDataValidityCheck_DataType]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[obps_sp_GenDataValidityCheck_DataType]    
(  
@linkid nvarchar(MAX)=''  
,@Username nvarchar(MAX)=''  
)  
as   
Begin  
  
declare @UserId nvarchar(MAX)='' 
set  @UserId= @Username
declare @var_id int                          
--declare @var_string nvarchar(max),@var_string_cnt int                          
--declare @var_num nvarchar(max),@var_num_cnt int                          
--declare @var_date nvarchar(max),@var_date_cnt int                          
--declare @var_col nvarchar(max)                                              
declare @var_qry varchar(8000)    
--declare @var_maxbatchid nvarchar(10)      
declare @var_TempTableName varchar(max)    
declare @var_MainTableName nvarchar(max)   
  
  
Set @var_MainTableName=(select TableName from obps_ExcelImportConfig where LinkId=@linkid)     
Set @var_TempTableName=(select TempTableName from obps_ExcelImportConfig where LinkId=@linkid)    
  
/*Code to test from test table*/  
--set @var_TempTableName='obp_VN_FabricBuffer_temp_01'  
  
DECLARE @NullFilterString varchar(max)  
DECLARE @ColNameForReason varchar(max)  
  
  
/*Create filter to check NULL value in Col*/  
SET @NullFilterString = NULL  
  
select @NullFilterString = COALESCE(@NullFilterString + ' or ','') +COLUMN_NAME+ ' is null' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName  
and column_name in  
(select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_TempTableName  and column_name not in ('id','BatchNo','IsValid','BatchId','Reason','UserId'))  
and IS_NULLABLE='NO'  


  
  
set @var_qry=''  
/*set @var_qry='Update '+@var_TempTableName+' set isvalid=0,Reason='''+'NULL Values exists in Mandatory Columns'+''+' where Id in (Select Id from '+@var_MainTableName + 'where '+')' */  
set @var_qry=';With CTE_01 as (Select Id from '+@var_TempTableName+' where UserName='''+@UserId+ ''' and IsValid=1 and ( '+@NullFilterString+')) Update TB set TB.IsValid=0 ,TB.Reason=''NULL Values exists in Mandatory Columns'' from ' +@var_TempTableName +
' TB, CTE_01 RT where TB.id=RT.id'  

print '1'
print @var_qry
exec (@var_qry);    
  
  
/*End - Create Dynamic Qry for NULL*/  
  
  
/*Create filter to check Numeric value in Col*/  
SET @NullFilterString = NULL  
SET @ColNameForReason = NULL  
  
--select @NullFilterString = COALESCE(@NullFilterString + 'isnumeric(','') +COLUMN_NAME+ ')=0 or ' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName  
select @NullFilterString = COALESCE(isnull(@NullFilterString,'isnull(') + 'isnumeric(isnull(','') +COLUMN_NAME+ ',1))=0 or ' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName  
and column_name in  
(select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_TempTableName  and column_name not in ('id','BatchNo','IsValid','BatchId','Reason','UserId'))  
and DATA_TYPE in ('float','int')  

--set @NullFilterString=substring(@NullFilterString,17,len(@NullFilterString))

  
select @ColNameForReason = COALESCE(@ColNameForReason + ',','') +COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName  
and column_name in  
(select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_TempTableName  and column_name not in ('id','BatchNo','IsValid','BatchId','Reason','UserId'))  
and DATA_TYPE in ('float','int')  
  
  
If len(@NullFilterString)>2  
Begin  
/*
set @NullFilterString=SUBSTRING(@NullFilterString,1,len(@NullFilterString)-3)  
 set @NullFilterString='isnumeric('+@NullFilterString  */
print @NullFilterString
set @NullFilterString=SUBSTRING(@NullFilterString,17,len(@NullFilterString)-6)  
set @NullFilterString=SUBSTRING(@NullFilterString,1,len(@NullFilterString)-3)  
set @NullFilterString='isnumeric'+@NullFilterString 
print '2.1'
print @NullFilterString  
End  
  
set @var_qry=''  
/*set @var_qry='Update '+@var_TempTableName+' set isvalid=0,Reason='''+'NULL Values exists in Mandatory Columns'+''+' where Id in (Select Id from '+@var_MainTableName + 'where '+')' */  
set @var_qry=';With CTE_01 as (Select Id from '+@var_TempTableName+' where UserName='''+@UserId+ ''' and IsValid=1 and ( '+@NullFilterString+')) Update TB set TB.IsValid=0 ,TB.Reason=''Invalid Numeric Value in ('+@ColNameForReason+')'' from ' +@var_TempTableName +' TB, CTE_01 RT where TB.id=RT.id'  

print '2'
print @var_qry
exec (@var_qry);   
  
--print @var_qry  
  
  
/*End - Create filter to check Numeric value in Col*/  


/*To Update Date in Date Columns. Added on 26-03-2022*/  
If OBJECT_ID('tempdb..#tb_DateCol') is not null drop table #tb_DateCol

Select ROW_NUMBER() over(order by column_name ) 'SNO',column_name 
into #tb_DateCol
from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName 
and column_name in  
(select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_TempTableName  and column_name not in ('id','BatchNo','IsValid','BatchId','Reason','UserId'))  
and 
DATA_TYPE in ('date','datetime')  

--Select * from #tb_DateCol

declare @var_RecCount int,@var_Rec int,@var_ColName nvarchar(max)

set @var_RecCount=(Select count(*) from #tb_DateCol)
set @var_Rec=1
--print @var_Rec
--print @var_RecCount
--print  '---'
while @var_Rec <= @var_RecCount
begin
set @var_ColName=(Select column_name from #tb_DateCol where sno=@var_Rec)

/*
set @var_qry=''
set @var_qry='update '  +@var_TempTableName+ ' set '+@var_ColName+ ' =SUBSTRING('+@var_ColName+',7,4)+'''+'-''+SUBSTRING('+@var_ColName+',4,2)+'''+'-''+SUBSTRING('+@var_ColName+',1,2) where isvalid=1 and len(ltrim(rtrim('+@var_ColName+'))) >=10 and Username='''+@UserId+''''
*/
set @var_qry=''
set @var_qry='update '  +@var_TempTableName+ ' set '+@var_ColName+ ' =SUBSTRING('+@var_ColName+',1,10) where isvalid=1 and len(ltrim(rtrim('+@var_ColName+'))) >=10 and Username='''+@UserId+''''


print @var_qry
exec (@var_qry);

set @var_Rec=@var_Rec+1
end

/*End - Update Date in Columns*/

  
/*Create filter to check Date value in Col*/  
SET @NullFilterString = NULL  
SET @ColNameForReason = NULL  
  
/*  
--select @NullFilterString = COALESCE(@NullFilterString + 'isnumeric(','') +COLUMN_NAME+ ')=0 or ' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName  
select @NullFilterString = COALESCE(@NullFilterString + 'isdate(','') +COLUMN_NAME+ ')=0 or ' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName  
and column_name in  
(select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_TempTableName  and column_name not in ('id','BatchNo','IsValid','BatchId','Reason','UserId'))  
and DATA_TYPE in ('date','datetime')  
*/

select @NullFilterString = COALESCE(@NullFilterString + 'ISDATE( CONVERT(CHAR(10), CONVERT(date,(isnull(','') +COLUMN_NAME+ ',''01-01-1900'+''')), 103)))=0 or ' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName  
and column_name in  
(select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_TempTableName  and column_name not in ('id','BatchNo','IsValid','BatchId','Reason','UserId'))  
and DATA_TYPE in ('date','datetime')  


print @NullFilterString

select @ColNameForReason = COALESCE(@ColNameForReason + ',','') +COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_MainTableName  
and column_name in  
--(select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_TempTableName  and column_name not in ('id','BatchNo','IsValid','BatchId','Reason','UserId'))  
(select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= @var_TempTableName  )  
and DATA_TYPE in ('date','datetime')  
  
  
  
If len(@NullFilterString)>2  
Begin  
--set @NullFilterString=SUBSTRING(@NullFilterString,1,len(@NullFilterString)-3) 
set @NullFilterString=SUBSTRING(@NullFilterString,1,len(@NullFilterString)-3) 
print @NullFilterString 
--set @NullFilterString='isdate('+@NullFilterString  
/*set @NullFilterString='ISDATE( CONVERT(CHAR(10), CONVERT(date,'+@NullFilterString  */
set @NullFilterString='ISDATE( CONVERT(CHAR(10), CONVERT(date,(isnull('+@NullFilterString  
End  

print @NullFilterString
  
set @var_qry=''  
/*set @var_qry='Update '+@var_TempTableName+' set isvalid=0,Reason='''+'NULL Values exists in Mandatory Columns'+''+' where Id in (Select Id from '+@var_MainTableName + 'where '+')' */  
set @var_qry=';With CTE_01 as (Select Id from '+@var_TempTableName+' where UserName='''+@UserId+ ''' and IsValid=1 and ( '+@NullFilterString+')) Update TB set TB.IsValid=0 ,TB.Reason=''Invalid Date in ('+@ColNameForReason+')'' from ' +@var_TempTableName +
' TB, CTE_01 RT where TB.id=RT.id'  

print '3'
print @var_qry
exec (@var_qry);   
  
  
/*End - Create filter to check Date value in Col*/  
  


  
End  
  

  
  
GO

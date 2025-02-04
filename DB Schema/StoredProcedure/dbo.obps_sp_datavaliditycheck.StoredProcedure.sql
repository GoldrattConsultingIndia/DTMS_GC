USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_datavaliditycheck]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[obps_sp_datavaliditycheck]        
as        
begin        
        
declare @var_id int        
declare @var_string nvarchar(max),@var_string_cnt int        
declare @var_num nvarchar(max),@var_num_cnt int        
declare @var_date nvarchar(max),@var_date_cnt int        
declare @var_col nvarchar(max)        
declare @var_qry nvarchar(max)      
declare @var_maxbatchid nvarchar(10)        
        
if OBJECT_ID('tempdb.dbo.#tb_coldata') is not null        
drop table tempdb.dbo.#tb_coldata        
        
if OBJECT_ID('tempdb.dbo.#tb_invrec') is not null        
drop table tempdb.dbo.#tb_invrec        
        
create table #tb_coldata        
(        
id int identity(1,1)        
,dbname nvarchar(max)        
,tablename nvarchar(max)        
,colname nvarchar(max)        
,datatype nvarchar(max)        
,ind01 int default 0        
)        
        
create table #tb_invrec        
(        
rid int        
,val int        
,colname nvarchar(max)        
)        
        
      
/*Num Col Section*/        
        
set @var_id=0        
set @var_num_cnt=0        
set @var_maxbatchid=(select convert(nvarchar(10),max(batchid)) from obp_DemandOrders_temp)        
      
set @var_num_cnt=(select count(*) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='obp_DemandOrders'        
and column_name not in ('Id','Size','Quantity','OrderId','AvgSaleMth','SkuCode','OrderModifiedDate','ModifiedBy','ModifiedQuantity','UserID','CreatedBy','CreatedDate','Modifieddate','color1','color2','color3','color4','color5','isDeleted','AccessToUser','isActive')        
and DATA_TYPE in ('int','float'))        
        
if @var_num_cnt>0        
begin        
        
truncate table #tb_coldata        
        
insert into #tb_coldata        
select TABLE_CATALOG,TABLE_NAME,COLUMN_NAME,DATA_TYPE,0 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='obp_DemandOrders'        
and column_name not in ('Id','Size','Quantity','OrderId','AvgSaleMth','SkuCode','OrderModifiedDate','ModifiedBy','ModifiedQuantity','UserID','CreatedBy','CreatedDate','Modifieddate','color1','color2','color3','color4','color5','isDeleted','AccessToUser','isActive')        
and DATA_TYPE in ('int','float')        
order by DATA_TYPE        
        
set @var_num=''        
        
while @var_num_cnt<>0        
begin        
if object_id('dbo.tb_01val') is not null        
drop table tb_01val;        
        
set @var_id=(select top 1 id from #tb_coldata where ind01=0)        
set @var_num='isnumeric('+(select top 1 colname from #tb_coldata where id=@var_id and ind01=0)+')'        
set @var_col=(select top 1 colname from #tb_coldata where id=@var_id and ind01=0)        
        
set @var_qry='Select id,'+@var_num+' as val into tb_01val from obp_DemandOrders_temp where batchid = '  +@var_maxbatchid      
        
exec (@var_qry);        
        
insert into #tb_invrec        
select id,val,@var_col from tb_01val where val=0;        
        
update obp_DemandOrders_temp set isvalid=0,reason=isnull(reason,'')+','+@var_col where id in (select rid from #tb_invrec where colname=@var_col) and BatchId=cast(@var_maxbatchid as int)        
        
set @var_num_cnt=@var_num_cnt-1        
update #tb_coldata set ind01=1 where id=@var_id        
end        
/*Num Col Done*/        
        
end        
        
/*Date Col Section*/        
       
  
set @var_id=0        
set @var_date_cnt=0        
        
set @var_date_cnt=(select count(*) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='obp_DemandOrders'        
and column_name not in ('Id','Size','Quantity','RequiredDate','OrderCreateDt','OrderId','AvgSaleMth','SkuCode','OrderModifiedDate','ModifiedBy','ModifiedQuantity','UserID','CreatedBy','CreatedDate','Modifieddate','color1','color2','color3','color4','color5','isDeleted','Ac
cessToUser','isActive')        
and DATA_TYPE in ('datetime','date'))        
        
if @var_date_cnt>0        
begin        
        
truncate table #tb_coldata        
        
insert into #tb_coldata        
select TABLE_CATALOG,TABLE_NAME,COLUMN_NAME,DATA_TYPE,0 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='obp_DemandOrders'        
and column_name not in ('Id','Size','Quantity','RequiredDate','OrderCreateDt','OrderId','AvgSaleMth','SkuCode','OrderModifiedDate','ModifiedBy','ModifiedQuantity','UserID','CreatedBy','CreatedDate','Modifieddate','color1','color2','color3','color4','color5','isDeleted','Ac
cessToUser','isActive')        
and DATA_TYPE in ('datetime','date')        
order by DATA_TYPE        
        
set @var_date=''        
        
while @var_date_cnt<>0        
begin        
if object_id('dbo.tb_01val') is not null        
drop table tb_01val;        
        
set @var_id=(select top 1 id from #tb_coldata where ind01=0)        
set @var_date='isdate('+(select top 1 colname from #tb_coldata where id=@var_id and ind01=0)+')'        
set @var_col=(select top 1 colname from #tb_coldata where id=@var_id and ind01=0)        
        
set @var_qry='Select id,'+@var_date+' as val into tb_01val from obp_DemandOrders_temp where batchid = '  +@var_maxbatchid      
        
exec (@var_qry);        
        
insert into #tb_invrec        
select id,val,@var_col from tb_01val where val=0;        
        
update obp_DemandOrders_temp set isvalid=0,reason=isnull(reason,'')+','+@var_col where id in (select rid from #tb_invrec where colname=@var_col)   and BatchId = cast(@var_maxbatchid as int)      
        
set @var_date_cnt=@var_date_cnt-1        
update #tb_coldata set ind01=1 where id=@var_id        
end        
/*Date Col Done*/        
        
end        
        
        
update obp_DemandOrders_temp set reason=substring(Reason,2,len(Reason)) where SUBSTRING(Reason,1,1)=','  and batchid=cast(@var_maxbatchid as int)      
        
end 
GO

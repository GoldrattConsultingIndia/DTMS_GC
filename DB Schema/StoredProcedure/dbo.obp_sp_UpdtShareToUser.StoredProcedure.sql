USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_UpdtShareToUser]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     proc [dbo].[obp_sp_UpdtShareToUser]          
(@var_MainTaskID int)          
as          
Begin          
        
          
if object_id('tempdb..#tb_names') is not null drop table #tb_names          
if object_id('tempdb..##tb_MTID') is not null drop table ##tb_MTID          
          
Declare @var_MTID int,@var_AllUsers nvarchar(max),@var_MTUser nvarchar(max)          
Declare @var_TikCont int          
DECLARE @Names VARCHAR(8000)          
          
Create table #tb_names          
(          
Users nvarchar(max)          
)           
        
         
select id,0 'ind01'         
into ##tb_MTID         
from obp_TaskHeader where isActive=1 and ParentId = 0 and th_TaskHeader<> 'Click + Sign to Add Records' and TaskStatus<>'CP'          
and id=@var_MainTaskID          
          
          
set @var_TikCont=(Select count(*) from ##tb_MTID)          
          
While @var_TikCont<>0          
Begin          
set @var_MTID=(Select top 1 id from ##tb_MTID where ind01=0)          
          
set @Names=''          
truncate table #tb_names          
          
insert into #tb_names          
Select distinct Createdby from obp_taskheader where id=@var_MTID          
          
insert into #tb_names          
Select distinct isnull(sharetouser,Createdby) from obp_taskheader where ParentId=@var_MTID and isnull(sharetouser,Createdby) collate database_default not in (Select a.Users from #tb_names a)          
          
SELECT @Names = COALESCE(@Names + '/ ', '') + Users           
FROM #tb_names           
          
print @var_MTID          
print @Names          
          
update obp_taskheader set sharetouser=@Names where id=@var_MTID and taskstatus<>'CP'    
    
/*Add Implementer Details*/        
Declare @var_TypeId int,@var_Implementer nvarchar(500),@var_SR_Implementer nvarchar(500)  
  
Select   
--TH.Createdby,   
@var_TypeId= U.UserTypeId, @var_Implementer=CM.Implementer  
,@var_SR_Implementer='%'+CM.Implementer+'%'  
 --,CM.ClientName  
from (Select * from obp_Taskheader ) TH    
join obps_users U on U.UserName=TH.Createdby  
join obp_ClientMaster cm on cm.id =TH.ClientID  
where Th.id = @var_MTID  
  
--Select @var_TypeId, @var_Implementer  
if @var_TypeId=2  
Begin  
 If (Select isnull(count(*),0) from  obp_Taskheader where id=@var_MTID and ShareToUser like @var_SR_Implementer)=0  
    Update obp_Taskheader set ShareToUser=ShareToUser+' / '+@var_Implementer where id=@var_MTID  
End  
  
/*End - Add Implementer Details*/        
          
update ##tb_MTID set ind01=1 where id=@var_MTID          
set @var_TikCont=@var_TikCont-1          
End          
/*End loop*/          
          
if object_id('tempdb..#tb_names') is not null drop table #tb_names          
if object_id('tempdb..##tb_MTID') is not null drop table ##tb_MTID          
          
End       
  
GO

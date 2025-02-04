USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_SP_DSH_TicketCycleTime]    Script Date: 2024-06-08 10:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER    proc [dbo].[obp_SP_DSH_TicketCycleTime]        
as        
Begin        
If object_id('tempdb..##tb_ClientTickets') is not null drop table ##tb_ClientTickets        
If object_id('tempdb..##tb_Report1') is not null drop table ##tb_Report1        
If object_id('tempdb..#tb_users') is not null drop table #tb_users        
        
Select CM.ClientName,TH.id 'TicketNo',TH.th_TaskHeader 'TaskHeader'    
--,TH.ShareToUser 'AssignToUser'    
--,TH.AssignToMain 'AssignToUser'    
,case when TH.AccessToUser is null then TH.Createdby else TH.AccessToUser end 'AssignToUser'  
,TH.TaskStatus  
,TH.CreatedDate  
,TH.EstDueDate  
,case when (TH.TaskStatus in ('CP','CL') and th.ClientClosureAcceptanceDate is not null)  then TH.ClientClosureAcceptanceDate   
      when (TH.TaskStatus in ('CP','CL') and th.ClientClosureAcceptanceDate is null)  then TH.ModifiedDate   
end 'CompletionDate'        
/*,case when TH.TaskStatus in ('CP','CL') then datediff(dd,TH.CreatedDate,TH.ModifiedDate) else datediff(dd,TH.CreatedDate,getdate())  end 'DaysUsedForTask'      */  
,0 'DaysUsedForTask'  
into ##tb_ClientTickets        
from obp_taskheader TH        
join obp_ClientMaster CM on CM.id=TH.ClientID        
where TH.TaskStatus is not null  and isnull(TH.th_TaskHeader,'Click + Sign to Add Records')<>'Click + Sign to Add Records'  
and  cast(th.CreatedDate as date) > '2023-01-31'    
order by CM.ClientName,isnull(TH.EstDueDate,getdate())        
  
update ##tb_ClientTickets set DaysUsedForTask=case when CompletionDate is null then datediff(dd,CreatedDate,cast(getdate() as date)) else datediff(dd,CreatedDate,CompletionDate)  end  
  
/*  
truncate table obp_DSH_TestData  
  
insert into obp_DSH_TestData  
Select * from ##tb_ClientTickets  
        
Select ClientName,TaskStatus,count(*) 'Nos'         
from ##tb_ClientTickets        
group by ClientName,TaskStatus        
order by ClientName        
        
Select AssignToUser,TaskStatus,count(*) 'Nos'         
from ##tb_ClientTickets        
where DaysUsedForTask between 0 and 5        
group by AssignToUser,TaskStatus        
order by AssignToUser,TaskStatus        
*/        
        
        
Select username,0 'ind01' into #tb_users from obps_users where Company in ('GC','OPS')    
        
Create table ##tb_Report1        
(        
TM nvarchar(max)        
,TaskStatus nvarchar(max)        
,[1-5Days] int        
,[1-10Days] int        
,[1-20Days] int        
,[1-30Days] int        
,[Over 30 Days] int        
)        
        
Declare @var_usrcnt int,@var_usr nvarchar(max)        
Set @var_usrcnt=(Select count(*) from #tb_users)        
        
While @var_usrcnt<>0        
Begin        
--set @var_usr='%'+(Select top 1 username from #tb_users where ind01=0)+'%'        
set @var_usr=(Select top 1 username from #tb_users where ind01=0)  
        
print @var_usr        
        
insert into ##tb_Report1        
Select   
--replace(@var_usr,'%','') 'TM'  
@var_usr 'TM'  
,TaskStatus        
,sum(case when DaysUsedForTask between 0 and 5 then  1 else 0 end) '1-5Days'        
,sum(case when DaysUsedForTask between 6 and 10 then  1 else 0  end) '1-10Days'        
,sum(case when DaysUsedForTask between 11 and 20 then  1 else 0  end) '1-20Days'        
,sum(case when DaysUsedForTask between 21 and 30 then 1 else 0  end) '1-30Days'        
,sum(case when DaysUsedForTask > 30 then  1  else 0 end) 'Over 30 Days'        
from ##tb_ClientTickets         
where AssignToUser = @var_usr        
--where AssignToUser = 'Ashish.jha'        
group by TaskStatus     
          
update #tb_users set ind01=1 where username =replace(@var_usr,'%','')        
set @var_usrcnt=@var_usrcnt-1        
End        
        
/*Select * from ##tb_Report1 order by TM,TaskStatus*/        
truncate table obp_DHS_TicketCycleTimeDateWiseRep

Insert into obp_DHS_TicketCycleTimeDateWiseRep
select * from ##tb_ClientTickets    
       
Merge obp_DHS_TicketCycleTimeRep as Target        
using ##tb_Report1 as Source        
on Source.TM collate database_default=Target.TM and Source.TaskStatus collate database_default=Target.TaskStatus        
When not matched by target then        
insert (TM,TaskStatus,[1-5Days],[1-10Days],[1-20Days],[1-30Days],[Over 30 Days])        
Values (Source.TM,Source.TaskStatus,Source.[1-5Days],Source.[1-10Days],Source.[1-20Days],Source.[1-30Days],Source.[Over 30 Days])        
When matched then        
Update Set Target.[1-5Days]=Source.[1-5Days],Target.[1-10Days]=Source.[1-10Days],Target.[1-20Days]=Source.[1-20Days],Target.[1-30Days]=Source.[1-30Days],Target.[Over 30 Days]=Source.[Over 30 Days]        
When not matched by Source then        
Delete;        
        
        
Select * from obp_DHS_TicketCycleTimeRep order by TM,TaskStatus        
End 

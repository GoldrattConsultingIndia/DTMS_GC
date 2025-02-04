USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_SP_GenerateDailyTaskSummaryToEmail]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Created on 2023-12-15; Author: Bharat; Reason: To Email Daily Task Status*/        
Create       procedure [dbo].[obp_SP_GenerateDailyTaskSummaryToEmail]        
as        
Begin        
/*  
Select * from obp_tb_DailyTaskEmails_CountToEmail  
  
Alter table obp_tb_DailyTaskEmails_CountToEmail  
Add Ttl_Red nvarchar(5),Ttl_Black nvarchar(5)  
*/        
Truncate table obp_tb_DailyTaskEmails        
Truncate table obp_tb_DailyTaskEmails_CountToEmail        
Truncate table obp_tb_DailyTaskEmails_SummaryToEmail        
--drop table obp_tb_DailyTaskEmails        
        
        
insert into obp_tb_DailyTaskEmails        
select         
th.id 'Ticket'         
,cm.ClientName        
,th.th_TaskHeader 'MainTask'        
,st.th_TaskHeader 'Activity'        
,st.TaskStatus 'Activity_TaskStatus'        
,th.TaskStatus 'Main_TaskStatus'        
,th.Sprint 'Committed'        
,th.Color3 'Color'        
,st.ShareToUser 'Owner'        
,us.EmailId 'UserEmail'        
,'bharat.sharma@goldrattgroup.com' 'ManagerEmail'        
,1 as 'SendFlg'        
,cast(getdate() as date) 'ProcessDate'        
from obp_TaskHeader th               
join obp_ClientMaster cm on th.ClientID=cm.id            
left join obp_TaskHeader st on st.ParentId=th.id         
join obps_users US on us.UserName=st.ShareToUser              
where               
th.th_taskheader<>'Click + Sign to Add Records'  and st.th_taskheader<>'Click + Sign to Add Records'        
and cm.ClientName not in ('GC_Prabhat')         
and isnull(th.TicketCatg1,'-')<>'Delete Task'                                        
and  cast(th.CreatedDate as date) > '2023-01-31'         
and th.TaskStatus in ('NS','IP') --and st.TaskStatus in ('NS','IP')         
and th.ShareToUser is not null        
and us.Company in ('GC','OPS')
Union All        
select         
th.id 'Ticket'         
,cm.ClientName        
,th.th_TaskHeader 'MainTask'        
,th.th_TaskHeader 'Activity'        
,th.TaskStatus 'Activity_TaskStatus'        
,th.TaskStatus 'Main_TaskStatus'        
,th.Sprint 'Committed'        
,th.Color3 'Color'        
,th.Createdby 'Owner'        
,us.EmailId 'UserEmail'        
,'bharat.sharma@goldrattgroup.com' 'ManagerEmail'        
,1 as 'SendFlg'        
,cast(getdate() as date) 'ProcessDate'        
from obp_TaskHeader th         
join obp_ClientMaster cm on th.ClientID=cm.id            
join obps_users US on us.UserName=th.Createdby              
where               
th.th_taskheader<>'Click + Sign to Add Records'          
and cm.ClientName not in ('GC_Prabhat')         
and isnull(th.TicketCatg1,'-')<>'Delete Task'                                        
and  cast(th.CreatedDate as date) > '2023-01-31'         
and th.TaskStatus in ('NS','IP')         
and th.ShareToUser is not null        
and us.Company in ('GC','OPS')
        
/*Delete Invalid Records*/        
Delete from obp_tb_DailyTaskEmails where Activity_TaskStatus in ('CP','CL')         
Delete from obp_tb_DailyTaskEmails where owner is null or maintask in ('No Record Exists') or useremail is null or activity='Click + Sign to Add Records'        
        
        
/*Populate Task Count Summary*/        
insert into obp_tb_DailyTaskEmails_CountToEmail        
Select         
Owner        
,case when Committed='Committed' then 'Committed' else 'Backlog' end 'TaskType'        
,count(*) 'Nos'        
,sum(case when TaskStatus='NS' then 1 else 0 end) 'NS'        
,sum(case when TaskStatus='IP' then 1 else 0 end) 'IP'        
,sum(case when isnull(Color,'')='Red' then 1 else 0 end) 'Red'        
,sum(case when isnull(Color,'')='Black' then 1 else 0 end) 'Black'        
,sum(case when isnull(Color,'') not in ('Red','Black') then 1 else 0 end) 'Non_RB'        
,0 'Status'   
,'',''       
from         
(        
Select Owner,Ticket,max(Committed) 'Committed',max(Color) 'Color',max(Main_TaskStatus) 'TaskStatus'         
from obp_tb_DailyTaskEmails group by Owner,Ticket        
--order by Owner,Committed        
) a        
group by Owner,Committed        
order by owner        
  
update obp_tb_DailyTaskEmails_CountToEmail set Ttl_Red=convert(varchar(5),Red) ,Ttl_Black=convert(varchar(5),Black)  where   TaskType='Committed'    
update obp_tb_DailyTaskEmails_CountToEmail set Ttl_Red='NA' ,Ttl_Black='NA'  where   TaskType='Backlog'    
        
/*Populate Task Summary*/        
        
insert into obp_tb_DailyTaskEmails_SummaryToEmail        
select Ticket,max(ClientName) 'Client',max(MainTask) 'TaskName',max(Main_TaskStatus) 'TaskStatus',max(Color) 'ColorPriority'      
,Owner 'Owner',max(UserEmail) 'Email',0 as 'Status'  ,case when committed='committed' then 'Committed' else 'Backlog' end 'Type'      
from obp_tb_DailyTaskEmails         
--where  committed='committed'         
group by Ticket,Owner,committed        
order by  Type desc      
      
Delete from obp_tb_DailyTaskEmails_SummaryToEmail where Len(isnull(Email,'')) < 5      
        
End    
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_Rep_AllTasks_Main]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE        proc [dbo].[obp_sp_Rep_AllTasks_Main]                 
(              
@var_user nvarchar(100)=''                 
,@var_pid int=''               
,@var_clientid int=''              
)               
as                
begin                
      
DECLARE @SearchLetter nvarchar(100)                                                              
SET @SearchLetter ='%'+ @var_user + '%'                                                              
        
select                 
th.id,                
th.color1,th.color2,th.color3        
,th.id as 'TicketNo'                
,cm.clientname as clientid__obp_taskheader                                          
,th.TicketCatg1 as ticketcatg1__obp_taskheader                                         
,th.th_taskheader as 'Task Name'                        
,FKBy as 'Full Kitted'               
,th_SeqNo as 'Rank'                          
,case when TH.AccessToUser is null then TH.Createdby else TH.AccessToUser end 'Owner'          
,round(td_SeqNo,2) as 'Touch Time (Hrs)'              
,th.TaskDuration as 'Duration (days)'         
/*                           
,th.PlannedStartDt  as 'plannedstartdt__obp_taskheader'               
,th.TaskActEstDt  as 'taskactestdt__obp_taskheader'                   
,ActFinishDate as 'actfinishdate__obp_taskheader'               
*/        
,convert(char(10),th.PlannedStartDt,126) 'Planned Start'        
,convert(char(10),th.TaskActEstDt,126) 'Planned Finish'        
,convert(char(10),th.TaskActEstDt,126) 'Customer Committed Date'        
,th.taskstatus as taskstatus__obp_taskheader                 
,th.TimeBuffer as timebuffer__obp_taskheader                 
,th.BlackExcedDays as 'Delay Days'         
/*              
,th.TaskActStartDt  as 'taskactstartdt__obp_taskheader'                 
,th.ActualFinishDate as actualfinishdate__obp_taskheader                  
,th.ModifiedDate as modifieddate__obp_taskheader                  
,th.CreatedDate as createddate__obp_taskheader            
*/        
,convert(char(10),th.TaskActStartDt,126) 'Actual Start'        
--,convert(char(10),th.ActualFinishDate,126) 'Actual Finish Date'      
--,case when th.ActualFinishDate is null then convert(char(10),th.ModifiedDate,126) else convert(char(10),th.ActualFinishDate,126) end   'Actual Finish Date'  
, case 
   when th.TaskStatus not in ('CP','CL') then  convert(char(10),th.ActualFinishDate,126)  
   When (th.TaskStatus in ('CP','CL')  and  th.ClientClosureAcceptanceDate is not null) then convert(char(10),th.ClientClosureAcceptanceDate,126)
   When (th.TaskStatus in ('CP','CL')  and  th.ClientClosureAcceptanceDate is null) then convert(char(10),th.ModifiedDate,126) 
  end 'ActualFinishDate'
,convert(char(10),th.ModifiedDate,126) 'Last Mod Date'        
,convert(char(10),th.CreatedDate,126) 'Created Date'        
        
,th.Createdby as createdby__obp_taskheader        
,case when isEdit=0 then 'Yes' when isEdit=1 then 'No'  end 'SubTaskExists'           
                  
from obp_TaskHeader th             
left join obp_ClientMaster cm on th.ClientID=cm.id          
--left join (select ticketid,min(estduedate) 'OriginalDueDt' from obp_TicketsLog where estduedate is not null and  TicketType='Header' group by ticketid ) tl on tl.TicketId=th.id           
where           
--th.isDeleted=0 and         
th.th_taskheader<>'Click + Sign to Add Records'  and isnull(th.ParentId,0)=0         
--and st.isDeleted=0 and st.th_taskheader<>'Click + Sign to Add Records'  and st.taskheaderid is not null                                                                  
and cm.ClientName not in ('GC_Prabhat')                               
and isnull(th.TicketCatg1,'-')<>'Delete Task'                                      
and  cast(th.CreatedDate as date) > '2023-01-31'                                
                                    
                                    
                                               
END                         
                        

GO

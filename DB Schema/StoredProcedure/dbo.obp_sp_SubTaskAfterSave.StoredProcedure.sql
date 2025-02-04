USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_SubTaskAfterSave]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    procedure [dbo].[obp_sp_SubTaskAfterSave]                
(@var_rid int)                
as                
Begin                
Declare @var_taskheaderid int                
                
Set @var_taskheaderid=(Select isnull(ParentId,0) from obp_TaskHeader where id=@var_rid)    
  
/*If Task Status becomes Blank*/      
update obp_TaskHeader set TaskStatus= case when isnull(TaskActStartDt,'1900-01-01') > '1900-01-01' then 'IP' else 'NS' end where id=@var_rid and isnull(TaskStatus,'')=''   
      
                
/* Exec obp_sp_SubTaskTaskStatuscal @var_rid  */        
      
/*Delete the SubTask and MainTask when TaskStatus=DEL*/        
Delete from obp_Taskheader where id=@var_RID and TaskStatus = 'DEL'      
      
If ((Select isnull(count(*),0) from obp_Taskheader where ParentId=@var_taskheaderid) = 0)      
Delete from obp_Taskheader where id=@var_taskheaderid       
      
/*To make TaskActualStart Date =today date if not provided for IP Tasks*/        
update obp_TaskHeader set TaskActStartDt=cast(getdate() as date)  where id=@var_rid and isnull(TaskActStartDt,'1900-01-01') ='1900-01-01' and TaskStatus='IP'        
          
--Select id,TaskStatus,1 'Stage'  from obp_Taskheader where id=12856          
--Select id,TaskStatus,5 'Stage'  from obp_Taskheader where id=12854          
          
Exec obp_sp_SubTaskEstDateCal @var_rid               
          
--Select id,TaskStatus,2 'Stage'  from obp_Taskheader where id=12856          
                
Exec obp_sp_MaiTaskDatesCal @var_rid                
          
--Select id,TaskStatus,3 'Stage'  from obp_Taskheader where id=12856          
          
Exec obp_sp_TimeBufferCal @var_rid                
          
--Select id,TaskStatus,4 'Stage'  from obp_Taskheader where id=12856          
      
      
          
/*Trace Record*/                
If isnull(@var_taskheaderid,0)<>0                
Begin                
                
/*SP to update Share to user in Main Task*/                            
Exec obp_sp_UpdtShareToUser  @var_taskheaderid                 
                
/*SP to update taskstatus in Main Task*/                            
Exec obp_sp_GetMainTaskStatus  @var_taskheaderid                 
          
--Select id,TaskStatus,5 'Stage'  from obp_Taskheader where id=12856          
--Select id,TaskStatus,5 'Stage'  from obp_Taskheader where id=12854          
          
Insert into obp_TaskHeader_Trace                
Select             
 id,            
ClientID,            
th_TaskHeader,            
TaskStatus,            
EstDueDate,            
th_Remarks,            
TimeBuffer,            
BlackExcedDays,            
Color1,            
Color2,            
Color3,            
isActive,            
AccessToUser,            
ShareToUser,            
ScheduleType,            
TaskDuration,            
TaskActStartDt,            
TaskActEstDt,            
PlannedStartDt,            
Reason,            
ParentId,            
ActualFinishDate,            
OnHoldReason,            
TicketCatg1,            
ActualDuration,            
CreatedDate,            
ModifiedDate,            
Createdby,            
Modifiedby,            
'S-U',            
getdate(),            
td_SeqNo,            
ActFinishDate,            
FKBy,            
th_SeqNo            
--*,'S-U',getdate()             
from obp_TaskHeader where id in (@var_rid)                
End                
Else                
Begin                
Insert into obp_TaskHeader_Trace                
Select             
 id,            
ClientID,            
th_TaskHeader,            
TaskStatus,            
EstDueDate,            
th_Remarks,            
TimeBuffer,            
BlackExcedDays,            
Color1,            
Color2,            
Color3,            
isActive,            
AccessToUser,            
ShareToUser,            
ScheduleType,            
TaskDuration,            
TaskActStartDt,            
TaskActEstDt,            
PlannedStartDt,            
Reason,            
ParentId,            
ActualFinishDate,            
OnHoldReason,            
TicketCatg1,            
ActualDuration,            
CreatedDate,            
ModifiedDate,            
Createdby,            
Modifiedby,            
'M-U',            
getdate(),            
td_SeqNo,            
ActFinishDate,            
FKBy,            
th_SeqNo            
--*,'M-U',getdate()             
from obp_TaskHeader where id in (@var_rid)                
End                
    
/*Sprint Condition*/          
Update obp_Taskheader set Sprint ='Completed' where id = @var_taskheaderid and TaskStatus = 'CP'      
    
                
End       
      
GO

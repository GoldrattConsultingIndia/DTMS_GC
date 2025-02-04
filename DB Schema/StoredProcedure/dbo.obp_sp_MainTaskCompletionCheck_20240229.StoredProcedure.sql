USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_MainTaskCompletionCheck_20240229]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    procedure [dbo].[obp_sp_MainTaskCompletionCheck_20240229]
(@var_RID int)                            
as                            
Begin                  
/*Check for Committed Column*/          
Update obp_Taskheader set Sprint= (Select sprint from obp_Taskheader where id=@var_RID)          
where ParentId=@var_RID        
      
/*Get the Committed Date*/      
Update obp_Taskheader set CommittedDate=getdate() where id=@var_RID and Sprint='Committed' and CommittedDate is null      
        
/*Additional Checks for Single MainTask*/                  
Declare @isEditFlg int = 0                  
Set @isEditFlg=(Select isnull(isEdit,0) from obp_Taskheader where id=@var_RID)                  
                  
If @isEditFlg=1                  
Begin                 
           
          
/*Delete the task if selected status is DEL*/             
Delete from obp_Taskheader where id=@var_RID and TaskStatus='DEL'          
    
/*If Task Status becomes Blank*/        
update obp_TaskHeader set TaskStatus= case when isnull(TaskActStartDt,'1900-01-01') > '1900-01-01' then 'IP' else 'NS' end where id=@var_RID and isnull(TaskStatus,'')='' and isEdit=1     
      
            
/*To make TaskActualStart Date =today date if not provided for IP Tasks*/                    
update obp_TaskHeader set TaskActStartDt=cast(getdate() as date)  where id=@var_rid and isnull(TaskActStartDt,'1900-01-01') ='1900-01-01' and TaskStatus='IP'                    
                  
Exec obp_sp_SubTaskEstDateCal @var_rid                  
                  
Exec obp_sp_TimeBufferCal_SMT @var_rid                  
                  
/*Check If CP Status is Valid*/                  
Declare @var_Cat nvarchar(100),@var_DR nvarchar(100),@var_FinishEstDt date,@var_TB nvarchar(100),@var_TS nvarchar(100)                  
Select @var_Cat=isnull(TicketCatg1,'-'),@var_DR=isnull(OnHoldReason,'-'),@var_TB=isnull(color3,'-'),@var_TS=isnull(TaskStatus,'-'),@var_FinishEstDt=isnull(TaskActEstDt,'1900-01-01')                   
from obp_Taskheader where id=@var_RID                  
                  
If (@var_TB='Black' and @var_TS='CP')                  
Begin                  
 If(@var_Cat='-' or @var_DR='-' or @var_FinishEstDt='1900-01-01')                  
 Begin                  
 update obp_Taskheader set TaskStatus='IP' where id=@var_RID                  
 End                  
End                  
                  
/*Insert Trace Record*/                  
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
/*End - Additional Checks for Single MainTask*/                  
     
                  
/*Comments to be added                      
Also indicate which block can be removed when it is handled in UI                      
*/                            
                     
Declare @var_TicketCatg nvarchar(100),@var_TicketDelayReason nvarchar(200),@var_TimeBufferColor nvarchar(10)                            
Declare @var_CnfFlg int                             
Declare @vaR_STStatus nvarchar(10),@vaR_MTStatus nvarchar(10)                            
                        
Set @var_CnfFlg=0                        
                            
Select @vaR_MTStatus=TaskStatus,@var_TicketCatg=isnull(TicketCatg1,'-'),@var_TimeBufferColor=Color3,@var_TicketDelayReason=isnull(OnHoldReason,'-') from obp_TaskHeader where id=@var_RID  and ParentId=0                           
Set @vaR_STStatus=(Select isnull(max(TaskStatus),'-') from obp_TaskHeader where parentid=@var_RID and TaskStatus<>'CP' and isActive=1)                            
          
--Select isnull(max(TaskStatus),'-') from obp_TaskHeader where parentid=11316 and TaskStatus<>'CP' and isDeleted=0                        
Select @var_TicketCatg ,@var_TicketDelayReason ,@var_TimeBufferColor                        
Select @vaR_MTStatus,@vaR_STStatus                        
                        
print @var_CnfFlg                        
                            
If (@vaR_STStatus='-' and @vaR_MTStatus='IP')                            
Begin                            
Set @var_CnfFlg = 1                            
End                            
Else                            
Begin                            
Set @var_CnfFlg = 0                            
End                        
                      
/*                      
If (@vaR_STStatus='-' and @vaR_MTStatus='IP')                            
 Set @var_CnfFlg = 1                           
Else                            
 Set @var_CnfFlg = 0                            
*/                         
                        
print @var_CnfFlg                         
                            
If (@var_TicketCatg<>'-'  and @var_CnfFlg=1)                        
Begin                            
Set @var_CnfFlg = 1                            
End                            
Else                            
Begin                            
Set @var_CnfFlg = 0                            
End                            
                        
print @var_CnfFlg                        
                            
If (@var_TimeBufferColor='Black' and @var_TicketDelayReason<>'-' and @var_CnfFlg=1)                            
Begin                            
Set @var_CnfFlg = 1                            
End                            
Else                            
Begin                            
Set @var_CnfFlg = 0                            
End                            
                        
print @var_CnfFlg                            
IF (@var_CnfFlg = 1)                            
Begin                            
Update obp_TaskHeader set taskstatus='CP' where id=@var_RID and isnull(ParentId,0)=0                            
End                            
                            
                          
                            
End                 
    
GO

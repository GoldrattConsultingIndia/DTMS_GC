USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_GetMainTaskStatus]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [dbo].[obp_sp_GetMainTaskStatus]              
(@var_MainTaskId int)              
as              
Begin              
              
Declare @var_MTStatus nvarchar(50) , @var_curTaskCatg nvarchar(100) ,@var_Check01 int            
            
set @var_Check01=0            
              
Select top 1 @var_MTStatus = STAT.TaskStatusValue              
from obp_TaskHeader ST               
join obp_TaskStatusDDLValuesST STAT on STAT.TaskStatusValue collate database_default=ST.TaskStatus              
where ST.ParentId =@var_MainTaskId and ST.th_TaskHeader <>'Click + Sign to Add Records'              
order by STAT.CatgRank              
            
Select @var_curTaskCatg=isnull(TicketCatg1,'-') from obp_TaskHeader where id=@var_MainTaskId             
            
if (Select isnull(count(*),0) from obp_TaskHeader where id=@var_MainTaskId and (TaskDuration is NULL or TaskActStartDt is NULL or TaskActEstDt is NULL or PlannedStartDt is NULL )) >=1            
Begin            
set @var_Check01=1            
End            
            
if (Select isnull(count(*),0) from obp_TaskHeader where id=@var_MainTaskId and ((len(trim(isnull(TicketCatg1,'-'))) < 3))) >=1            
Begin            
set @var_Check01=1            
End            
            
if (Select isnull(count(*),0) from obp_TaskHeader where id=@var_MainTaskId and TimeBuffer='Black' and len(trim(isnull(OnHoldReason,'-'))) < 3 ) >=1            
Begin            
set @var_Check01=1            
End            
print   @var_Check01          
          
--if @var_curTaskCatg='Delete Task'            
--Begin            
--set @var_Check01=0            
--End            
        
if (@var_MTStatus<>'CP' )        
Begin        
update obp_TaskHeader set TaskStatus=@var_MTStatus,ActualDuration=null,ActualFinishDate=null where id=@var_MainTaskId         
End        
        
if (isnull(@var_curTaskCatg,'-')='Delete Task')        
Begin        
set @var_MTStatus='CP'        
update obp_TaskHeader set TaskStatus=@var_MTStatus,ActualFinishDate=cast(getdate() as date),ActualDuration=(datediff(dd,TaskActStartDt,getdate())+1) where id=@var_MainTaskId         
      
End        
        
          
/*Check TicketType Blank before moving to Completed Status*/            
--If(@var_MTStatus='CP' and isnull(@var_curTaskCatg,'-')<>'Delete Task' and @var_Check01=0)            
if (@var_MTStatus='CP' and isnull(@var_curTaskCatg,'-')<>'Delete Task' and @var_Check01=0)        
Begin        
update obp_TaskHeader set TaskStatus=@var_MTStatus,ActualFinishDate=cast(getdate() as date),ActualDuration=(datediff(dd,TaskActStartDt,getdate())+1) where id=@var_MainTaskId              
End          

Declare @var_CreatedUserType int    

Select @var_CreatedUserType=UserTypeId from obps_users where username= (Select top 1 Createdby from obp_Taskheader where id= @var_MainTaskId )    

/*Auto Close Non-Client tasks */
If @var_CreatedUserType <> 2
Begin
 
If (Select isnull(TaskStatus,'') from obp_Taskheader where id=@var_MainTaskId )='CP'            
 Update obp_Taskheader set TaskStatus='CL',ClientClosureAcceptanceDate=cast(getdate() as date),ClientClosureAcceptance='True' 
 where id = @var_MainTaskId and TaskStatus='CP' and isnull(ClientClosureAcceptanceDate,'1900-01-01') = '1900-01-01' 
End

          
print @var_MTStatus              
--select * from obp_TaskStatusDDLValuesST              
              
              
End 
GO

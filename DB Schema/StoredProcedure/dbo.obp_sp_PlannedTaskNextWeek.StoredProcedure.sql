USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_PlannedTaskNextWeek]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
/*Planned Open Tasks for Next Week*/                        
/*Date: 2023-09-29; Author: Bharat; Reason: To get the list of Planned Tasks Next week for Status Report */                        
                        
CREATE       procedure [dbo].[obp_sp_PlannedTaskNextWeek]                        
as                        
Begin          
        
 Declare @var_DateFrom date,@var_DateTo date,@var_DayofWeek int ,@var_todaydate date                
 Set @var_todaydate=Cast((getdate()-0) as date)          
 Set @var_DayofWeek=(Select datepart(weekday,@var_todaydate))          
         
 Set @var_DateTo= Dateadd(dd,(7-@var_DayofWeek),@var_todaydate)        
 Set @var_DateFrom = Dateadd(dd,-6,@var_DateTo)        
        
 set @var_DateTo=dateadd(dd,7,@var_DateTo)        
 set @var_DateFrom=dateadd(dd,7,@var_DateFrom)        
 /*        
 Select @var_DayofWeek          
 Select @var_todaydate 'TodayDate'  ,@var_DateFrom 'Week From' ,@var_DateTo 'Weekend'         
*/                        
                        
Select              
 replace(TH.Sprint,'Completed','Committed') 'Committed'                         
 ,CM.ClientName,TH.th_TaskHeader 'Task Name',TH.TaskStatus              
 /*              
 ,cast(TH.PlannedStartDt as date) 'Planned Start Date'                        
 ,cast(TH.TaskActEstDt as date) 'Planned Finish Date'              
 */              
 ,convert(char(10),TH.PlannedStartDt,126) 'Planned Start Date'              
 ,convert(char(10),TH.TaskActEstDt,126) 'Planned Finish Date'              
 ,TH.BlackExcedDays 'Delay Days'                        
 ,TH.OnHoldReason 'Delay Reason'  
 ,case when TH.AccessToUser is null then TH.Createdby else TH.AccessToUser end 'Owner'  
 /* ,replace(TH.ShareToUser,'/','') 'Task Assign To' */
 ,case when replace(TH.ShareToUser,'/','') like '%'+isnull(Th.AssignToMain,'')+'%' then  replace(TH.ShareToUser,'/','') else (replace(TH.ShareToUser,'/','')+' ' +isnull(Th.AssignToMain,'')) end 
  'Task Assign To'  
 ,TH.TimeBuffer                      
 ,TH.th_Remarks 'Remarks'                  
 ,TH.FkBy 'Full Kitted'                        
from obp_TaskHeader TH                        
join obp_ClientMaster CM on CM.id=isnull(TH.ClientID,1)          
join obps_users US on US.UserName= TH.Createdby                        
where                         
 cast(TH.CreatedDate as date) > '2023-03-01' and                        
 isnull(ClientID,1)>1 and                         
 ParentId=0 and                        
 th_TaskHeader is not null and                        
 /*          
 DATEPART(WEEK,TH.PlannedStartDt) <=  (DATEPART(WEEK,GETDATE()+7)) and                      
 DATEPART(WEEK,TH.TaskActEstDt) >=  (DATEPART(WEEK,GETDATE()+7)) and                      
          
 isnull(TH.PlannedStartDt,'1900-01-01') <= '2024-01-06' and          
 isnull(TH.TaskActEstDt,'1900-01-01') >= '2023-12-31' and            
 */        
  isnull(TH.PlannedStartDt,'1900-01-01') <= @var_DateTo and          
 isnull(TH.TaskActEstDt,'1900-01-01') >= @var_DateFrom and                     
 TH.TaskStatus in ('IP','NS')  and          
 TH.Sprint in ('Completed','Committed')         
 /* and (case when TH.AccessToUser is null then TH.Createdby else TH.AccessToUser end)    ='Anita' */        
order by CM.ClientName,TH.TaskActEstDt                        
                        
End       
GO

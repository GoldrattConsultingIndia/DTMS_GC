USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_TimeBuffer]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   proc [dbo].[obp_sp_TimeBuffer]            
as            
Begin         
If OBJECT_ID('tempdb..##tb_Main') is not null drop table ##tb_Main        
      
select id,0 'ind01'             
into ##tb_Main            
from obp_TaskHeader where isActive=1 and isnull(parentid,0)=0 and th_TaskHeader<> 'Click + Sign to Add Records' and TaskStatus not in ('CP','CL')       
and ClientID>1        
    
       
/*     
 Select * from ##tb_Main        
delete from ##tb_Main where id <> 5519        
*/
            
Declare @var_MTID_cnt int,@var_headerticketid int,@var_id int            
Declare @var_color nvarchar(10)        
            
Set @var_MTID_cnt=(Select count(*) from ##tb_Main where ind01=0)            
            
While @var_MTID_cnt<>0            
Begin            
        
      
        
Set @var_headerticketid=(Select top 1 id from ##tb_Main where ind01=0)            
      
         
/*TimeBuffer*/                
update obp_TaskHeader set TimeBuffer=case                 
when datediff(dd, PlannedStartDt,getdate())  < 0  then 'Cyan'                
when datediff(dd, PlannedStartDt,getdate())  between 0 and (datediff(dd, PlannedStartDt,TaskActEstDt)/3) then 'Green'                              
when datediff(dd, PlannedStartDt,getdate())  between ((datediff(dd, PlannedStartDt,TaskActEstDt)/3)+1) and ((datediff(dd, PlannedStartDt,TaskActEstDt)*2)/3) then 'Yellow'                             
when datediff(dd, PlannedStartDt,getdate())  between (((datediff(dd, PlannedStartDt,TaskActEstDt)*2)/3)+1) and datediff(dd, PlannedStartDt,TaskActEstDt) then 'Red'                             
when datediff(dd, PlannedStartDt,getdate()) > datediff(dd, PlannedStartDt,TaskActEstDt) then 'Black' end                            
where                               
(id=@var_headerticketid or parentid=@var_headerticketid  ) and                               
TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'           
                      
                          
                          
update obp_TaskHeader set TimeBuffer='Black' where (id=@var_headerticketid or parentid=@var_headerticketid )         
/*--and  CONVERT(int,datediff(dd,PlannedStartDt,TaskActEstDt))<=0   */
and  CONVERT(int,datediff(dd,PlannedStartDt,TaskActEstDt))<0         
and TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'                                  
                                  
update obp_TaskHeader set color3=TimeBuffer where (id=@var_headerticketid or parentid=@var_headerticketid ) and                                     
TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'                                  
                                  
update obp_TaskHeader set BlackExcedDays=case when datediff(dd,TaskActEstDt,getdate()) > 0 then datediff(dd,TaskActEstDt,getdate()) else 0 end                                  
where (id=@var_headerticketid or parentid=@var_headerticketid ) and TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'                                   
/*and timebuffer ='Black'*/
        
        
/*Making all cyan where planned date > today*/        
update  obp_TaskHeader set color3='Cyan',TimeBuffer='Cyan' where         
(id=@var_headerticketid or parentid=@var_headerticketid ) and         
isnull(BlackExcedDays,0)<1 and  cast(PlannedStartDt as date) > cast(getdate()  as date)        
        
        
/*Color to be Red for tasks with same day*/        
update  obp_TaskHeader set color3='Red',TimeBuffer='Red' where         
(id=@var_headerticketid or parentid=@var_headerticketid ) and         
TaskDuration<=1 and isnull(BlackExcedDays,0)<1 and  cast(TaskActEstDt as date)=cast(getdate()  as date)        
        
        
        
/*Color to be Green and Red for tasks with 2 days*/         
update  obp_TaskHeader set color3='Green',TimeBuffer='Green' where (id=@var_headerticketid or parentid=@var_headerticketid ) and         
TaskDuration=2 and isnull(BlackExcedDays,0)<1 and  cast(PlannedStartDt as date)=cast(getdate()  as date)        
/*and  cast((DATEADD(dd,1,PlannedStartDt)) as date) =cast(getdate()  as date)        */
update  obp_TaskHeader set color3='Red',TimeBuffer='Red' where (id=@var_headerticketid or parentid=@var_headerticketid ) and          
TaskDuration=2 and isnull(BlackExcedDays,0)<1 and  cast(PlannedStartDt as date) < cast(getdate()  as date)         
/*End - TimeBuffer*/             
            
update ##tb_Main set ind01=1 where id=@var_headerticketid            
Set @var_MTID_cnt=@var_MTID_cnt-1            
      
End            
            
End 
GO

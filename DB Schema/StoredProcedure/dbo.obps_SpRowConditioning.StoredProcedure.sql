USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_SpRowConditioning]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[obps_SpRowConditioning]                
(@var_tableid int,@var_id int)                
as                
begin                
if @var_tableid=301                
begin                
update obp_TaskHeader set Color1=case when priority='H' then 'Red' when priority='M' then 'Yellow' else 'White' end where id=@var_id                
update obp_TaskHeader set Color2=case when TaskStatus='IP' then 'LightGreen' when TaskStatus='CP' then 'DarkOrange'  when TaskStatus='NS' then 'SkyBlue'  else 'White' end                 
where                 
id=@var_id and th_TaskHeader<>'Click + Sign to Add Records'                
/*              
update obp_TaskHeader set TimeBuffer=case when datediff(dd, CreatedDate,getdate()-1)  between 0 and (datediff(dd, CreatedDate,EstDueDate)/3) then 'Green'                
when datediff(dd, CreatedDate,getdate()-1)  between ((datediff(dd, CreatedDate,EstDueDate)/3)+1) and ((datediff(dd, CreatedDate,EstDueDate)*2)/3) then 'Yellow'               
when datediff(dd, CreatedDate,getdate()-1)  between (((datediff(dd, CreatedDate,EstDueDate)*2)/3)+1) and datediff(dd, CreatedDate,EstDueDate) then 'Red'               
when datediff(dd, CreatedDate,getdate()-1) > datediff(dd, CreatedDate,EstDueDate) then 'Black' end              
where                 
id=@var_id and                 
TaskStatus in ('IP','NS') and EstDueDate is not null and th_TaskHeader <> 'Click + Sign to Add Records'              
*/            
update obp_TaskHeader set TimeBuffer=case   
when datediff(dd, PlannedStartDt,getdate())  < 0  then 'Cyan'  
when datediff(dd, PlannedStartDt,getdate())  between 0 and (datediff(dd, PlannedStartDt,TaskActEstDt)/3) then 'Green'                
when datediff(dd, PlannedStartDt,getdate())  between ((datediff(dd, PlannedStartDt,TaskActEstDt)/3)+1) and ((datediff(dd, PlannedStartDt,TaskActEstDt)*2)/3) then 'Yellow'               
when datediff(dd, PlannedStartDt,getdate())  between (((datediff(dd, PlannedStartDt,TaskActEstDt)*2)/3)+1) and datediff(dd, PlannedStartDt,TaskActEstDt) then 'Red'               
when datediff(dd, PlannedStartDt,getdate()) > datediff(dd, PlannedStartDt,TaskActEstDt) then 'Black' end              
where                 
id=@var_id and                 
TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'              
            
            
update obp_TaskHeader set TimeBuffer='Black' where id=@var_id and  CONVERT(int,datediff(dd,PlannedStartDt,TaskActEstDt))<=0            
and TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'              
              
update obp_TaskHeader set color3=TimeBuffer where id=@var_id and                 
TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'              
              
update obp_TaskHeader set BlackExcedDays=case when datediff(dd,TaskActEstDt,getdate()) > 0 then datediff(dd,TaskActEstDt,getdate()) else 0 end              
where id=@var_id and TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'               
--and timebuffer ='Black'          
      
update  obp_TaskHeader set color3='Red',TimeBuffer='Red' where TaskDuration<=2 and isnull(BlackExcedDays,0)<1      
              
end                
                
if @var_tableid=302                
begin    
    
/*Updating TaskDuration, TaskEstDueDt,PlannedStartDt at Header Level*/                
Declare @var_headerticketid int,@var_PlannedStartDt datetime,@var_TaskActEstDt datetime,@var_TaskDuration int,@var_TaskActStartDt datetime    
    
Set @var_headerticketid =(Select top 1 TaskHeaderID from obp_TaskHeader where id=@var_id)    
Set @var_PlannedStartDt =(Select min(isnull(PlannedStartDt,'1900-01-01')) from obp_TaskHeader where TaskHeaderID=@var_headerticketid  and th_TaskHeader<>'Click + Sign to Add Records')    
Set @var_TaskActEstDt =(Select max(isnull(TaskActEstDt,'1900-01-01')) from obp_TaskHeader where TaskHeaderID=@var_headerticketid and th_TaskHeader<>'Click + Sign to Add Records')    
Set @var_TaskActStartDt =(Select max(isnull(TaskActStartDt,'1900-01-01')) from obp_TaskHeader where TaskHeaderID=@var_headerticketid and th_TaskHeader<>'Click + Sign to Add Records')    
    
Select @var_headerticketid ,@var_PlannedStartDt ,@var_TaskActEstDt ,@var_TaskDuration,@var_TaskActStartDt    
    
if @var_PlannedStartDt<>'1900-01-01'    
Begin    
Update obp_TaskHeader set PlannedStartDt=@var_PlannedStartDt where id=@var_headerticketid    
End    
Else    
Begin    
Update obp_TaskHeader set PlannedStartDt=null where id=@var_headerticketid    
End    
    
if @var_TaskActEstDt<>'1900-01-01'    
Begin    
Update obp_TaskHeader set TaskActEstDt=@var_TaskActEstDt where id=@var_headerticketid    
End    
Else    
Begin    
Update obp_TaskHeader set TaskActEstDt=null where id=@var_headerticketid    
End    
    
if @var_TaskActStartDt<>'1900-01-01'    
Begin    
Update obp_TaskHeader set TaskActStartDt=@var_TaskActStartDt where id=@var_headerticketid    
End    
Else    
Begin    
Update obp_TaskHeader set TaskActStartDt=null where id=@var_headerticketid    
End    
    
update obp_TaskHeader set TaskDuration= case when (isnull(@var_PlannedStartDt,'1900-01-01')<>'1900-01-01' and isnull(@var_TaskActEstDt,'1900-01-01')<>'1900-01-01') then     
datediff(dd,@var_PlannedStartDt,@var_TaskActEstDt) else null end     
where id=@var_headerticketid    
  
/*TimeBuffer*/  
update obp_TaskHeader set TimeBuffer=case   
when datediff(dd, PlannedStartDt,getdate())  < 0  then 'Cyan'  
when datediff(dd, PlannedStartDt,getdate())  between 0 and (datediff(dd, PlannedStartDt,TaskActEstDt)/3) then 'Green'                
when datediff(dd, PlannedStartDt,getdate())  between ((datediff(dd, PlannedStartDt,TaskActEstDt)/3)+1) and ((datediff(dd, PlannedStartDt,TaskActEstDt)*2)/3) then 'Yellow'               
when datediff(dd, PlannedStartDt,getdate())  between (((datediff(dd, PlannedStartDt,TaskActEstDt)*2)/3)+1) and datediff(dd, PlannedStartDt,TaskActEstDt) then 'Red'               
when datediff(dd, PlannedStartDt,getdate()) > datediff(dd, PlannedStartDt,TaskActEstDt) then 'Black' end              
where                 
(id=@var_id or id=@var_headerticketid  ) and                 
TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'              
            
            
update obp_TaskHeader set TimeBuffer='Black' where (id=@var_id or id=@var_headerticketid ) and  CONVERT(int,datediff(dd,PlannedStartDt,TaskActEstDt))<=0            
and TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'              
              
update obp_TaskHeader set color3=TimeBuffer where (id=@var_id or id=@var_headerticketid) and                 
TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'              
              
update obp_TaskHeader set BlackExcedDays=case when datediff(dd,TaskActEstDt,getdate()) > 0 then datediff(dd,TaskActEstDt,getdate()) else 0 end              
where (id=@var_id or id=@var_headerticketid) and TaskStatus in ('IP','NS') and TaskActEstDt is not null and th_TaskHeader <> 'Click + Sign to Add Records'               
--and timebuffer ='Black'          
      
update  obp_TaskHeader set color3='Red',TimeBuffer='Red' where TaskDuration<=2 and isnull(BlackExcedDays,0)<1  
/*End - TimeBuffer*/  
    
--update obp_TaskHeader set PlannedStartDt= TaskHeaderID    
/*End - Updating TaskDuration, TaskEstDueDt,PlannedStartDt at Header Level*/                
--update obp_TaskDetails set Color1=case when TaskStatus='IP' then 'LightGreen' when TaskStatus='NS' then 'Red' else 'White' end where id=@var_id                
update obp_TaskHeader set Color2=case when TaskStatus='IP' then 'LightGreen' when TaskStatus='CP' then 'DarkOrange'  when TaskStatus='NS' then 'SkyBlue'  else 'White' end                 
where                 
id=@var_id         
/*         
and                 
TaskDetail<>'Click + Sign to Add Records'                
*/        
end                
                
end       
GO

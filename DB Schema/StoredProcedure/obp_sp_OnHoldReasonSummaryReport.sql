/*For Dashboard - Poogi Reason */
/*Author: Bharat*/
/*Date: 2024-06-29 */

CREATE or Alter     Proc [dbo].[obp_sp_OnHoldReasonSummaryReport]                                
(@var_user nvarchar(100)=''                                                                                                         
,@var_pid int=''                                                                                                         
,@var_clientid int=''                                                                                                          
,@var_par1 nvarchar(max)='',@var_par2 nvarchar(max)='',@var_par3 nvarchar(max)='',@var_par4 nvarchar(max)='',@var_par5 nvarchar(max)=''                              
)                                                                                                                      
as                                                                                                                      
begin   

truncate table obp_gms_OnHoldReasonSummaryReport

;With Cte_01 as
(
Select OnHoldReason,TicketCatg1,Createdby
,cast(CreatedDate as date) 'CreatedDate'
,sum(BlackExcedDays) 'TtlBlackExcedDays'
,COUNT(*) 'TaskCount'
from obp_Taskheader 
where cast(CreatedDate as date)>='2024-01-01'
and ParentId=0 
and len(isnull(th_TaskHeader,''))>2
and isnull(OnHoldReason,'') not in ('')
and BlackExcedDays>0
group by OnHoldReason,TicketCatg1,Createdby
,cast(CreatedDate as date)
having sum(BlackExcedDays)>0
)
insert into obp_gms_OnHoldReasonSummaryReport
Select ROW_NUMBER() over(order by OnHoldReason,Createdby,CreatedDate) 'id'
,TicketCatg1,OnHoldReason,Createdby,CreatedDate,sum(TaskCount) 'TaskCount'
,sum(TtlBlackExcedDays) TtlBlackExcedDays
,cast(getdate() as date) 'ReportedDate'
from Cte_01 group by TicketCatg1,OnHoldReason,Createdby,CreatedDate

Select 
id
,TicketCatg1 'Ticket Category'
,OnHoldReason
,Createdby
,convert(nvarchar(10),cast(CreatedDate as date)) as CreatedDate                            
,TaskCount 'Total Ticket Count'
,TtlBlackExcedDays 'Total Delay Days'
,convert(nvarchar(10),cast(ReportedDate as date)) as ReportedDate  
from obp_gms_OnHoldReasonSummaryReport

End




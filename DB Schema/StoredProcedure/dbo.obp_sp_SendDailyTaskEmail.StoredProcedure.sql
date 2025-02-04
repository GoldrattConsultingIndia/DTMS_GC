USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_SendDailyTaskEmail]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create      proc [dbo].[obp_sp_SendDailyTaskEmail]      
as      
Begin      
/*ReCalculate Colors*/      
Exec obp_sp_TimeBuffer    
    
/*ReCalculate Tickets For Emails*/      
Exec obp_SP_GenerateDailyTaskSummaryToEmail    
  
/*Colors are not applicable for Backlog Tickets */  
update obp_tb_DailyTaskEmails_SummaryToEmail set ColorPriority='NA'  where Type='Backlog'   
      
Declare @var_username nvarchar(100),@var_email nvarchar(200),@var_count int      
    
      
set @var_count=(Select count(distinct Owner) from obp_tb_DailyTaskEmails_CountToEmail where status=0)      
      
/*Email to Members*/      
While @var_count<>0      
Begin      
 Set @var_username=(Select top 1 owner from obp_tb_DailyTaskEmails_CountToEmail where Status=0)      
 Set @var_email=(Select top 1 email from obp_tb_DailyTaskEmails_SummaryToEmail where Owner=@var_username)      
      
 Exec obp_DailyTasksEmail @var_email, @var_username      
      
 update obp_tb_DailyTaskEmails_CountToEmail set status=1 where owner=@var_username      
 Set @var_count=@var_count-1      
End      
    
      
/*Email to manager*/      
/*Exec obp_sp_SendDailyTaskEmail_Manager    */

if OBJECT_ID('tempdb..#tb_mgr') is not null drop table #tb_mgr
select distinct userid,0 'ind01' into #tb_mgr from obp_UsersExtended where type='Manager'


Declare @var_Mcount int, @var_MgrId int
set @var_Mcount =(Select count(*) from #tb_mgr where ind01=0)

while @var_Mcount<>0
Begin
set @var_MgrId=(Select top 1 userid from #tb_mgr where ind01=0)

/*print @var_MgrId*/

Exec obp_sp_SendDailyTaskEmail_Manager_v2 @var_MgrId

update #tb_mgr set ind01=1 where userid=@var_MgrId
set @var_Mcount=@var_Mcount-1
End

    
End    
GO

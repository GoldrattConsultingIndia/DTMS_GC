USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_eod]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     proc [dbo].[obp_sp_eod]          
(@var_user nvarchar(100)=''                                                       
,@var_pid int=''                                                       
,@var_clientid int=''                                                        
,@var_par1 nvarchar(max)='',@var_par2 nvarchar(max)='',@var_par3 nvarchar(max)='',@var_par4 nvarchar(max)='',@var_par5 nvarchar(max)=''                                                           
)                                                                    
as                                                                    
begin                                                                    
                                                                    
DECLARE @SearchLetter nvarchar(100)                                                                    
SET @SearchLetter ='%'+ @var_user + '%'                                           
                                          
Declare @var_usertype int                                          
Set @var_usertype=(Select UserTypeId from obps_Users where UserName=@var_user)                                                                   
          
Declare @var_reccount int          
Set @var_reccount=0          
Set @var_reccount=(Select count(*) from obp_eod where cast(EOD_Date as date)=cast(getdate() as date) and Createdby=@var_user and id<>100)          
--Set @var_reccount=1          
                                                             
If isnull(@var_reccount,0)=0          
Begin          
 Select           
 1 as id          
 --,Name as 'name__obp_eod'          
 ,Project as 'project__obp_eod'          
 ,TaskCategory as 'taskcategory__obp_eod'          
 ,TaskType as 'tasktype__obp_eod'          
 --,TimeSpent as 'timespent__obp_eod'          
 ,Hours as 'hours__obp_eod'          
 ,Minutes as 'minutes__obp_eod'          
 ,Comments as 'comments__obp_eod'          
 ,EOD_Date as 'eod_date__obp_eod'          
 from obp_eod where id =100          
          
End          
Else          
Begin          
 Select           
 id          
 --,Name as 'name__obp_eod'          
 ,Project as 'project__obp_eod'          
 ,TaskCategory as 'taskcategory__obp_eod'          
 ,TaskType as 'tasktype__obp_eod'          
 --,TimeSpent as 'timespent__obp_eod'          
 ,Hours as 'hours__obp_eod'          
 ,Minutes as 'minutes__obp_eod'          
 ,Comments as 'comments__obp_eod'          
 ,EOD_Date as 'eod_date__obp_eod'          
 from obp_eod where cast(EOD_Date as date)=cast(getdate() as date) and Createdby=@var_user          
End          
End   


GO

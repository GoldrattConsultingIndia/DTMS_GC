USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_getClient_EOD]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROCEDURE [dbo].[obp_sp_getClient_EOD]                        
@usrnme nvarchar(MAX)='',              
@linkid int='' ,                      
@gridid nvarchar(MAX)=''          
,@id nvarchar(10)=''                       
AS                        
BEGIN           
/*Reason : This will show the same clients as shown in MyTask against each user*/          
 --Set @linkid=1          
 DECLARE @SearchLetter int  ,@var_clientid nvarchar(max),@var_SearchUser nvarchar(max)                     
 SET @SearchLetter =(Select id from obps_users where UserName=@usrnme)                
 Set @var_clientid=(Select par1 from obps_SpPermissions where Linkid=@linkid and userid =  @SearchLetter)             
 set @var_SearchUser='%'+@usrnme+'%'               
                
 select id,clientname as name from obp_ClientMaster where id in             
 --(Select value from string_split(@var_clientid,','))                         
 (            
 select distinct ClientID from obp_TaskHeader where isDeleted=0 and ClientID>1 and th_TaskHeader<> 'Click + Sign to Add Records' and TaskStatus<>'CP'            
 and ShareToUser like @var_SearchUser            
 union all            
 Select value from string_split(@var_clientid,',')        
 --union all        
 --Select 'Others'            
 )         
 union all        
 Select 1 'id','Others'    as 'name'        
 order by clientname asc                        
 --select ID,clientname as name from obp_ClientMaster                        
END   
GO

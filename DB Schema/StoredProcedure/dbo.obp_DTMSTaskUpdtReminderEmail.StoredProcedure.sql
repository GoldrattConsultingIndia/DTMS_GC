USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_DTMSTaskUpdtReminderEmail]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
CREATE PROCEDURE [dbo].[obp_DTMSTaskUpdtReminderEmail]                                                
AS                                
begin            
Declare @var_emailto nvarchar(max)                            
DECLARE @xml NVARCHAR(MAX)                              
DECLARE @body NVARCHAR(MAX)                              
        
        
Set  @var_emailto=( Select STRING_AGG(subdept,';') from obps_users where Department='InfoTech' )        
        
/*Comment the below line for live run*/        
 --Set  @var_emailto='bharat.sharma@goldrattgroup.com;ravindra.udagatti@goldrattgroup.com;srinivasan.v@goldrattgroup.com'      
--Set  @var_emailto='bharat.sharma@goldrattgroup.com'  
  
SET @body ='<html><body>Dear Team'+'<P>This is a gentle reminder to update the DTMS tasks for effective reporting and discussion.<P><U><B>Please ensure :</B></U> <BR>- Tasks for current week have been updated for progress.</BR></n>- Tasks for next week ha
ve been planned in DTMS.<P>Please ignore the email if already done.<P>'        
        
SET @body = @body  +'<BR>Thanks</BR><BR>OneBeat Team</BR><BR>-----This is an auto generated email. Please Do not Reply-----</BR></body></html>'                              
EXEC msdb.dbo.sp_send_dbmail                              
@profile_name = 'Autoemails',                              
@body = @body,                              
@body_format ='HTML',                              
@recipients = @var_emailto,                              
@subject = 'Goldratt : Reminder to update DTMS Tasks' ;          
                  
                                
end           
GO

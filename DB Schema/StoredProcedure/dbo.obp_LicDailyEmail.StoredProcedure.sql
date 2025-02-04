USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_LicDailyEmail]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[obp_LicDailyEmail]                        
(@var_emailto nvarchar(100),@var_uname nvarchar(100))                        
AS                          
begin                          
DECLARE @xml NVARCHAR(MAX)                        
DECLARE @body NVARCHAR(MAX)                        
        
SET @xml = CAST(( SELECT [ClientName] AS 'td','',[LicenseValidityDate] AS 'td','', [DaysLeft] AS 'td'            
FROM obp_UserLicMapping where username= @var_uname                        
ORDER BY ClientName                        
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))                        
/*                        
SET @xml = CAST(( SELECT [ClientName] AS 'td','',[LicenseDate] AS 'td','', [DaysLeft] AS 'td','' ,[FeesPendingAmount] as 'td','', [ExpensePendingAmount] as 'td'                        
FROM obp_EmailList where username= @var_uname                        
ORDER BY ClientName                        
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))                        
*/                        
                        
SET @body ='<html><body>Dear '+@var_uname+'<BR>Onebeat License for below mentioned list of Client will be expiring soon.</BR><P>                        
<table border = 1>                         
<tr bgcolor=Orange>                        
<th> ClientName </th> <th> ValidityDate </th> <th> DaysLeft </th></tr>'        
/*<th> ClientName </th> <th> LicenseValidityDate </th> <th> DaysLeft </th><th> FeesPendingAmount </th><th> ExpensePendingAmount </th>*/                            
/*                         
SET @body = @body + @xml +'</table><BR>Thanks</BR><BR>OneBeat Team</BR><BR>Goldratt Group</BR><BR>-----This is an auto generated email from http://164.52.203.134/ . Please Do not Reply-----</BR></body></html>'                        
*/                        
SET @body = @body + @xml +'</table><BR>Thanks</BR><BR>OneBeat Team</BR><BR>-----This is an auto generated email. Please Do not Reply-----</BR></body></html>'                        
EXEC msdb.dbo.sp_send_dbmail                        
@profile_name = 'Autoemails',                        
@body = @body,                        
@body_format ='HTML',                        
@recipients = @var_emailto,                        
@subject = 'Goldratt : Client OneBeat License/ Contract' ;                        
            
                          
end     
GO

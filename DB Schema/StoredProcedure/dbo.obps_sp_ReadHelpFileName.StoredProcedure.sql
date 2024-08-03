USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadHelpFileName]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_ReadHelpFileName]        
@UserName nvarchar(MAX)='',    
@id nvarchar(10)=''    
AS        
BEGIN       
 DECLARE @path nvarchar(MAX)=''  
 SET @path=(select value from obps_GlobalConfig where Variables='helpfilepath')  
select Filename,@path from obps_helpdoc where id=@id and isactive=1    
    
END 
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getGridDDLValues]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getGridDDLValues]  
@usrname NVARCHAR(MAX)='',        
@linkid int=''        
AS        
BEGIN        
         
 DECLARE @sp nvarchar(MAX)=''  
        
 SET @sp=(SELECT DdlSp from obps_toplinks where id=@linkid)          
 if len(rtrim(ltrim(@sp)))>0    
 exec @sp @usrname,@linkid  
END 
GO

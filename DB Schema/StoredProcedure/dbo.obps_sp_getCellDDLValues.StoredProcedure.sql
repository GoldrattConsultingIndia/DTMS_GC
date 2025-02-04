USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getCellDDLValues]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getCellDDLValues]          
@colname nvarchar(MAX)='',          
@gridid nvarchar(MAX)='', 
@id nvarchar(MAX)='',
@mappedspcol nvarchar(MAX)='',
@usrname NVARCHAR(MAX)='',          
@linkid NVARCHAR(MAX)=''          
AS          
BEGIN          
           
 DECLARE @sp nvarchar(MAX)='',          
 @colnew nvarchar(MAX)='',          
 @tabname nvarchar(MAX)='',          
 @indx int,          
 @Gridtabname NVARCHAR(MAX)='',@tabquery nvarchar(MAX)='',
 @spquery nvarchar(MAX)=''
 
   
   
 SET @Gridtabname='Grid'+@gridid+'table'
 SET @tabquery=('(SELECT @tabname='+@Gridtabname+' FROM Obps_TopLinks where '+@Gridtabname+'  is not null and id='''+@LinkId+''')')  
 EXEC Sp_executesql  @tabquery,  N'@tabname NVARCHAR(MAX) output',  @tabname output  
 
 SET @spquery=('(SELECT @sp='+@mappedspcol+' FROM '+@tabname+' where id='''+@id+''')')  
 EXEC Sp_executesql  @spquery,  N'@sp NVARCHAR(MAX) output',  @sp output  		 

if len(rtrim(ltrim(@sp)))>0      
exec @sp @usrname,@linkid,@gridid  

END 
GO

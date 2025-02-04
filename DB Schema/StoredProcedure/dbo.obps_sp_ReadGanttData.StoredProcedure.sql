USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadGanttData]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_ReadGanttData]        
@lnkId nvarchar(MAX)='', 
@gridname nvarchar(MAX)='',
@usrname nvarchar(MAX)=''
AS        
BEGIN        
    
DECLARE @spquery nvarchar(MAX)='',@ganttsp nvarchar(MAX)='',@ganttsp1  nvarchar(MAX)=''

SET @spquery=('(SELECT @ganttsp1='+@Gridname+' FROM obps_TopLinks where '+@Gridname+'  is not null and Id='''+@lnkId+''')')          
EXEC Sp_executesql  @spquery,  N'@ganttsp1 NVARCHAR(MAX) output',  @ganttsp output 
   
if(LEN(@ganttsp)>0)
BEGIN      
 EXEC @ganttsp @usrname        
END

END
GO

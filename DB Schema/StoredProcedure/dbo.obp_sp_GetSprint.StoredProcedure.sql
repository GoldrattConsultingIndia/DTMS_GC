USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_GetSprint]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[obp_sp_GetSprint]         
@usrnme nvarchar(MAX)='' ,        
@linkid int='' ,                
@gridid nvarchar(MAX)='' ,    
@id nvarchar(10)=''         
AS       
BEGIN       
  
Declare @var_TaskStatus nvarchar(50)  
Set @var_TaskStatus=(Select TaskStatus from obp_Taskheader where id=@id)  
  
If @var_TaskStatus='CP'  
Begin  
Select 1 'id', 'Completed' as 'name'   
End  
Else  
Begin  
Select 2 'id', 'Backlog' as 'name'   
Union All  
Select 3 'id', 'Committed' as 'name'   
End  
    
END   
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_GetClientTicketActionOptions]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[obp_sp_GetClientTicketActionOptions]         
@usrnme nvarchar(MAX)='' ,        
@linkid int='' ,                
@gridid nvarchar(MAX)='' ,    
@id nvarchar(10)=''         
AS       
BEGIN     
   
 Select id,TaskStatusValue 'name' from obp_ClientTicketActionDDLValues where id<>1 order by TaskStatusValue  
   
End
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_GetUserName_OPS]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[obp_sp_GetUserName_OPS]             
@usrnme nvarchar(MAX)='' ,            
@linkid int='' ,                    
@gridid nvarchar(MAX)=''  
,@id nvarchar(10)=''         
AS             
BEGIN     

  
select id,UserName 'name' from obps_Users where Company in ('GC','OPS') order by UserName      
          
END 
GO

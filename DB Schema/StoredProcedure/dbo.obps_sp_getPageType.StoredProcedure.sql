USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getPageType]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getPageType]    
@Id int=''   
AS    
BEGIN    
 if @id=''  
 begin  
  select PageTypeId,PageType from obps_PageType order by PageType asc 
 end  
 else  
 begin  
  select id,PageType from obps_PageType where id=@Id  
 end  
END   
    
  
  
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_GetTaskStatus_v1]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_GetTaskStatus_v1]     
@usrnme nvarchar(MAX)='' ,    
@linkid int='' ,            
@gridid nvarchar(MAX)=''     
AS   
BEGIN   
select id as ID,TaskStatusValue as name from [dbo].[obp_TaskStatusDDLValues]   
END   
GO

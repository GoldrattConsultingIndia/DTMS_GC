USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_GetFKType]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_GetFKType]       
@usrnme nvarchar(MAX)='' ,      
@linkid int='' ,              
@gridid nvarchar(MAX)=''
,@id nvarchar(10)=''       
AS       
BEGIN select id as ID,TickTypeValue as name from [dbo].[obp_FKTypeDDLValues] where TickTypeValue in ('Y','N') END   
  
GO

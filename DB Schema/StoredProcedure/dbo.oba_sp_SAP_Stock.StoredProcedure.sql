USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[oba_sp_SAP_Stock]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[oba_sp_SAP_Stock]
(
@var_user nvarchar(100)=''                                   
,@var_pid int=''                                   
,@var_clientid int=''
)
as

 select  ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as id,* 
 from [Onebeat_Finolex].dbo.SAP_Stock_Temp


	 
GO

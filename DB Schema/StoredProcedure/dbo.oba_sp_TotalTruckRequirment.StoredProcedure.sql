USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[oba_sp_TotalTruckRequirment]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[oba_sp_TotalTruckRequirment]
(
@var_user nvarchar(100)=''                                             
,@var_pid int=''                                             
,@var_clientid int=''    
,@par1 nvarchar(MAX)='' 
)
as
select id, SentFrom 'Plant',ToLocation 'Branch',WtInTon 'Weight(Ton)'from obp_TotalLoad
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getToolbarDDLValues]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getToolbarDDLValues] 
@usrname nvarchar(MAX)='',          
@linkid int='' ,
@gridid int='',
@spname nvarchar(MAX)=''
AS
BEGIN

if len(rtrim(ltrim(@spname)))>0      
 exec @spname @usrname,@linkid,@gridid

END
GO

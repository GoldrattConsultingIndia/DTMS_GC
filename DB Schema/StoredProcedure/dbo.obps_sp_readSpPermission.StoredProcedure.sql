USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_readSpPermission]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_readSpPermission]
@userid int=''
AS
BEGIN
if @userid=''
	select P.id 'id',P.UserId,U.UserName 'username',
	displayname,Linkid,LinkName,Gridid,Par1,Par2
	,Par3,Par4,Par5 
	from obps_SpPermissions P
	inner join obps_Users U on U.id=P.UserId
	inner join obps_TopLinks T on T.id=P.Linkid
	inner join obps_MenuName M on M.id=T.MenuId
else
	select P.id 'id',P.UserId,U.UserName 'username',
	displayname,Linkid,LinkName,Gridid,Par1,Par2
	,Par3,Par4,Par5 
	from obps_SpPermissions P
	inner join obps_Users U on U.id=P.UserId
	inner join obps_TopLinks T on T.id=P.Linkid
	inner join obps_MenuName M on M.id=T.MenuId
	
	where U.UserId=@userid

END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getDefaultLink]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getDefaultLink]
@Username  NVARCHAR(MAX)=NULL
AS
BEGIN
DECLARE @default_Linkid int=NULL;

SET @default_Linkid=(select defaultlinkid from obps_users where UserName=@Username)

IF @default_Linkid is NULL
BEGIN
select top 1 Id from Obps_topLinks where IsAfterLogin=1
END
ELSE
BEGIN
select @default_Linkid
END
END
GO

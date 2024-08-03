USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_CheckImportExist]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_admin_CheckImportExist]
@LinkId nvarchar(MAX)=''
AS
BEGIN
	DECLARE @count int=0
	SET @count=(select count(*) from obps_ExcelImportConfig where LinkId=@LinkId)
	IF @count>0
		select '1'
END
GO

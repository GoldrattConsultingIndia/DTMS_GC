USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_deleteMenuName]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_deleteMenuName]
@id nvarchar(MAX)
AS
BEGIN
	declare @count int=0;
	set @count=(select count(*) from obps_MenuName where id=@id and @id in(select MenuId from obps_TopLinks))
	if(@count=0)
	BEGIN
		delete from obps_MenuName where id=@id
		select '1'
	END
	ELSE
	BEGIN
		select '0'
	END
END
GO

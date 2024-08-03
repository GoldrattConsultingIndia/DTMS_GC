USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_EditMainMenu]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_EditMainMenu]
@id nvarchar(MAX)='',
@dispName nvarchar(MAX)='',
@visible nvarchar(MAX)=''
AS
BEGIN
	update obps_MenuName set DisplayName=@dispName,IsVisible=@visible where id=@id
END
GO

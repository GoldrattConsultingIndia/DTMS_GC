USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertMainMenu]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_InsertMainMenu]
@MenuId NVARCHAR(MAX)='',
@MenuName NVARCHAR(MAX)='',
@IsVisible NVARCHAR(MAX)=''
AS
BEGIN
	INSERT INTO obps_MenuName(DisplayName,IsVisible)
	values
	(@MenuName,@IsVisible)
END
GO

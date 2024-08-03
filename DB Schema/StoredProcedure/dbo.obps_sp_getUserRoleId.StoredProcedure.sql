USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getUserRoleId]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getUserRoleId]
@User_Name nvarchar(MAX)
AS
BEGIN
SELECT 'Role'+RoleId FROM Obps_Users WHERE UserName=@User_Name
END
GO

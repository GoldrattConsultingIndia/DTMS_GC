USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_CreateTableTemp]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_CreateTableTemp]
@ColumnName nvarchar(MAX),
@DataType nvarchar(MAX),
@AllowNulls nvarchar(MAX),
@Defaults nvarchar(MAX),
@UserCol nvarchar(MAX)
AS
BEGIN
	INSERT INTO obps_CreateTableTemp values(@ColumnName,@DataType,@AllowNulls,@Defaults,@UserCol)
END
GO

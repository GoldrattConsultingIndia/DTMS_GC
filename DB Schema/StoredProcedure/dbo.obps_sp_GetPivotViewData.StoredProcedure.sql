USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetPivotViewData]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_GetPivotViewData]
@Gridname NVARCHAR(MAX)=NULL,
@lId nvarchar(MAX) = ''
AS
BEGIN

	DECLARE @spname NVARCHAR(MAX),
	@spquery nvarchar(MAX)

	SET @spquery=('(SELECT @spname='+@Gridname+' FROM obps_TopLinks where '+@Gridname+'  is not null and Id='''+@lId+''')')
	EXEC Sp_executesql  @spquery,  N'@spname NVARCHAR(MAX) output',  @spname output
	if(len(ltrim(rtrim(@spname)))>1)
	Exec @spname
END
GO

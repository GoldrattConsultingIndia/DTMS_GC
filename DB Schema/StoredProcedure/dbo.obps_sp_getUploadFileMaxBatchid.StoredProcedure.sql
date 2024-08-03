USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getUploadFileMaxBatchid]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getUploadFileMaxBatchid]
AS
BEGIN

	DECLARE @batchid nvarchar(MAX)=''

	SET @batchid=(select max(batchid) from obps_FileUploadedHistory)

	if @batchid is null
		select 0
	else
		select @batchid

END
GO

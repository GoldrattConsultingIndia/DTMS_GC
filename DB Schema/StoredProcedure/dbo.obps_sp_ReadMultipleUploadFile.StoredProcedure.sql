USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadMultipleUploadFile]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_ReadMultipleUploadFile]
@LinkId nvarchar(MAX)=''
AS
BEGIN

	DECLARE @batchid nvarchar(MAX)=''

	SET @batchid=(select max(batchid) from obps_FileUploadedHistory)

	select UserName,FileName,Size+'KB',CreatedDate,Type,FilePath from  obps_FileUploadedHistory 
	where linkid=@LinkId and uploadedDate=CONVERT(VARCHAR(10), getdate(), 111) and batchid=@batchid


END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadFilePath]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_ReadFilePath]
@id nvarchar(MAX)=''
AS
BEGIN
select FileNameDesc,FilePath from obps_FileUpload where id=@id
 --select FilePath from obps_FileUpload where id=@id  
END
GO

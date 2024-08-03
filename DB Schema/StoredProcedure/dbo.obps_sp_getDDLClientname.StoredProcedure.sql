USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getDDLClientname]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getDDLClientname]
@usrname NVARCHAR(MAX)=''
AS
BEGIN
	DECLARE @SearchLetter nvarchar(100)
	SET @SearchLetter ='%'+ @usrname + '%'
	select distinct ClientName,Id from obp_ClientMaster where AccessToUser like  @SearchLetter
	order by ClientName

END
GO

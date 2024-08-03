USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getLinkName]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getLinkName]    
@id nvarchar(MAX)=''
AS    
BEGIN    
	IF @id=''
		select Id,LinkName from obps_TopLinks
	ELSE
		select Id,LinkName from obps_TopLinks where MenuId=@id
END   
GO

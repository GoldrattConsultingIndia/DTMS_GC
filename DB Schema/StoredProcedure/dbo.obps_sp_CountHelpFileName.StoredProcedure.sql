USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_CountHelpFileName]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[obps_sp_CountHelpFileName]    
@UserName nvarchar(MAX)=''
AS    
BEGIN   

select count(Filename) from obps_helpdoc where  isactive=1

END
GO

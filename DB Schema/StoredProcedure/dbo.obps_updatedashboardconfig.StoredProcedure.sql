USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_updatedashboardconfig]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_updatedashboardconfig]
@id int='',
@caption nvarchar(MAX)='',
@linkid nvarchar(5)=''
AS
BEGIN

update obps_Dashboards set Caption=@caption,LinkId=@linkid where id=@id

END
GO

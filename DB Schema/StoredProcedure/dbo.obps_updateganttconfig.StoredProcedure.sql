USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_updateganttconfig]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_updateganttconfig]
@id int='',
@linkid nvarchar(10)='',
@tablename nvarchar(MAX)='',
@subject nvarchar(MAX)='',
@start nvarchar(MAX)='',
@end nvarchar(MAX)='',
@pred nvarchar(MAX)='',
@succ nvarchar(MAX)=''
AS
BEGIN

select '1'

END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_DeleteGanttDependency]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_DeleteGanttDependency]
@LinkId int,
@usr nvarchar(MAX)='',
@key  nvarchar(10)=''
AS
BEGIN

DECLARE @succid nvarchar(MAX)='',@predeid nvarchar(MAX)=''
,@tabname nvarchar(MAX)='',@string1 nvarchar(MAX)=''
,@string2 nvarchar(MAX)=''

SET @succid=(SELECT successoridColName from obps_GanttConfig where linkid=@LinkId)
SET @predeid=(SELECT PredecessorIdColName from obps_GanttConfig where linkid=@LinkId)
SET @tabname=(SELECT Tablename from obps_GanttConfig where linkid=@LinkId)

SET @string1='update '+@tabname+' set '+@predeid+'=NULL where '+@predeid+'='+@key
SET @string2='update '+@tabname+' set '+@succid+'=NULL where '+@succid+'='+@key
exec (@string1)
exec (@string2)

END
GO

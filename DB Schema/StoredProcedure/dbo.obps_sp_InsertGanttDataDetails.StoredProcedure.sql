USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertGanttDataDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_InsertGanttDataDetails]
@LinkId int,
@usr nvarchar(MAX)='',
@predecessorid  nvarchar(10)='',
@successorid nvarchar(10)=''
AS
BEGIN

DECLARE @succid nvarchar(MAX)='',@predeid nvarchar(MAX)=''
,@tabname nvarchar(MAX)='',@string1 nvarchar(MAX)=''
,@string2 nvarchar(MAX)=''

SET @succid=(SELECT successoridColName from obps_GanttConfig where linkid=@LinkId)
SET @predeid=(SELECT PredecessorIdColName from obps_GanttConfig where linkid=@LinkId)
SET @tabname=(SELECT Tablename from obps_GanttConfig where linkid=@LinkId)

SET @string1='update '+@tabname+' set '+@succid+'='+@successorid+' where id='+@predecessorid
SET @string2='update '+@tabname+' set '+@predeid+'='+@predecessorid+' where id='+@successorid 
--update obp_taskheader set SuccessorId=@successorid where id=@predecessorid
--update obp_taskheader set PredecessorId=@predecessorid where id=@successorid
exec (@string1)
exec (@string2)

END
GO

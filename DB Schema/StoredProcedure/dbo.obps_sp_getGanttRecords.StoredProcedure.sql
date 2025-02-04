USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getGanttRecords]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getGanttRecords]
AS
BEGIN


select G.id 'id',displayname,linkname,T.linkid 'sublinkid'
,tablename,SubjectColName,  
StartColName,EndColName,PredecessorIdColName,SuccessorIdColName   
from obps_ganttconfig G   
right join obps_TopLinkExtended T on G.Linkid=T.Linkid  
right join obps_toplinks TS on T.linkid=TS.id  
right join obps_MenuName M on M.MenuId=TS.MenuId  
where TS.Type in(3,4) and T.GridId=1

END
GO

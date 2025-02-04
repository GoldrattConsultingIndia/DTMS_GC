USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getGridViewRowBtn]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getGridViewRowBtn]          
@LinkId nvarchar(MAX)='' ,  
@GridId nvarchar(MAX)='' ,  
@username nvarchar(MAX)=''  
AS          
BEGIN       
	declare @count int=0
	set @count=(select len(ltrim(rtrim(GridRowButtonText))) from obps_TopLinkExtended where Linkid=@LinkId  and GridId=@GridId )
	if(@count>0)
		select GridRowButtonText,GridRowButtonColWidth from obps_TopLinkExtended where Linkid=@LinkId  and GridId=@GridId       
END
GO

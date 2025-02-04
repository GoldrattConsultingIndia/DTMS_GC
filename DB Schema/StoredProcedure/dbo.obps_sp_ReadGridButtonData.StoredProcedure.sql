USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadGridButtonData]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[obps_sp_ReadGridButtonData]        
@Gridid NVARCHAR(MAX)='',        
@LinkId nvarchar(MAX) = '',        
@UserName NVARCHAR(MAX)= '',
@selectedid nvarchar(MAX)=''
AS        
BEGIN        
 DECLARE @usrname_col NVARCHAR(MAX),        
    @query NVARCHAR(MAX),        
    @query_Key NVARCHAR(MAX),        
    @pkey NVARCHAR(MAX),        
    @tabname NVARCHAR(MAX),        
    @spquery NVARCHAR(MAX) ,        
    @count int        
 DECLARE @spname NVARCHAR(MAX)        
        
SET @spname=(SELECT GridRowButtonSp FROM obps_toplinkextended where linkid=@LinkId and GridId=@Gridid)        
        
     
IF (len(ltrim(rtrim(@spname)))>0)        
BEGIN        
 EXEC @spname @UserName,@selectedid         
END        
END
GO

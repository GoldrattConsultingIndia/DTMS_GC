USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_CheckIsIdForDDL]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_CheckIsIdForDDL]
@linkid nvarchar(5)='',
@gid nvarchar(2)='',
@colname nvarchar(MAX)=''
AS
BEGIN

DECLARE @isid nvarchar(2)='',@colid nvarchar(max)

SET @colid=(select id from obps_ColAttrib where LinkId=@linkid and ColName=
			substring(@colname,0,CHARINDEX('_',@colname,0)) and ColControlType='dropdownlist')

SET @isid=(select isid from obps_DropDownTable where ColumnId=@colid)

select @isid

END
GO

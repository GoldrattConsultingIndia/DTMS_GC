USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertUpdatetable]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[obps_sp_InsertUpdatetable]
@tabname nvarchar(MAX)='',
@ColName nvarchar(MAX),
@datatype nvarchar(MAX),
@default nvarchar(MAX),
@allownull nvarchar(MAX)
AS
BEGIN

DECLARE @count nvarchar(MAX)

DECLARE @colstr nvarchar(MAX)=''
set @colstr='ALTER TABLE '+@tabname+' CHANGE '+@ColName+'  '+@ColName+'  '+ @datatype;
END
GO

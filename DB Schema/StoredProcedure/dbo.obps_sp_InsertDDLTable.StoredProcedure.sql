USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertDDLTable]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_InsertDDLTable]
@colid nvarchar(MAX)='',
@coltoins nvarchar(MAX)='',
@coltosel nvarchar(MAX)='',
@tabtosel nvarchar(MAX)='',
@isid nvarchar(MAX)=''
AS
BEGIN

	insert into obps_DropDownTable values(@colid,@coltoins,@coltosel,@tabtosel,@isid)
END
GO

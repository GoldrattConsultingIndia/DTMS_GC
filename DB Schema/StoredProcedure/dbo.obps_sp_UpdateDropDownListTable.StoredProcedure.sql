USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateDropDownListTable]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[obps_sp_UpdateDropDownListTable]
@colid nvarchar(MAX)='',
@coltoins nvarchar(MAX)='',
@coltosel nvarchar(MAX)='',
@tabtosel nvarchar(MAX)='',
@isid nvarchar(MAX)='',
@id int
AS
BEGIN
select @isid
		update obps_DropDownTable set ColumnId=@colid,ColumnToInsert=@coltoins,ColumnToSelect=@coltosel,TableToSelect=@tabtosel,isId=@isid where id=@id
END
GO

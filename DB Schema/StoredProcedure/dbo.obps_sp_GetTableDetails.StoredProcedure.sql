USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetTableDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_GetTableDetails]
@tabname nvarchar(MAX)=''
AS
BEGIN
if @tabname<>''
	SELECT COLUMN_NAME,data_type,COLUMN_DEFAULT,case when IS_NULLABLE='YES' then 1 else 0 end as'IS_NULLABLE',case when TableUserCol is null then 0 else 1 end 'isusercol'
	FROM INFORMATION_SCHEMA.COLUMNS Left join obps_TableId on TABLE_NAME=TableName 
	and COLUMN_NAME=TableUserCol
	WHERE TABLE_NAME = @tabname and 
	COLUMN_NAME not in('id','id1','Color1','Color2','Color3','Color4','Color5','SeqNo','CreatedDate','ModifiedDate','Createdby','Modifiedby','isActive','isDeleted','AccessToUser','ShareToUser')
	ORDER BY ORDINAL_POSITION
END
GO

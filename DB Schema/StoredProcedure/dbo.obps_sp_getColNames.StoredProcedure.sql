USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getColNames]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getColNames]    
@tablename nvarchar(MAX)=''    
AS    
BEGIN    
	SELECT COLUMN_NAME as 'colname'
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @tablename
	AND COLUMN_NAME not in('id','id1','Color1','Color2','Color3','Color4',
						'Color5','SeqNo','CreatedDate','ModifiedDate',
						'Createdby','Modifiedby','isActive','isDeleted',
						'AccessToUser','ShareToUser')
	ORDER BY ORDINAL_POSITION
END
GO

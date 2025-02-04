USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_CreatePageLayout1GridClass]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_CreatePageLayout1GridClass]
@LayoutId INT=1
AS
BEGIN
		DECLARE @GridSp NVARCHAR(MAX)
		DECLARE @Data_Type nvarchar(150),
				@Column_Name nvarchar(150)

		select @GridSp=spName from obps_PageLayout where Id=@LayoutId

		print 
	   'using System;
		using System.Collections.Generic;
		using System.Linq;
		using System.Web;

		namespace Onebeat_PL.Models
		{
			public class Layout1GridDetailsClass
			{'
		DECLARE cur CURSOR FOR
		select 

		case 
			when Data_Type like 'nvarchar%' then
			'string'
			when Data_Type like '%datetime%' or  Data_Type like '%date%' then
			'DateTime'
			when Data_Type like 'bit%' then
			'int'
			else
			Data_Type
			end ,Column_Name
		--into #inpclass
		FROM INFORMATION_SCHEMA.COLUMNS
		inner join Obps_LayoutPageTabAttr PA on Column_Name=PA.ColumnName
		and Table_Name=PA.TableName
		WHERE  PA.IsVisible=1 and PA.TableName in 
		(SELECT DISTINCT t.name 
		FROM sys.sql_dependencies d 
		INNER JOIN sys.procedures p ON p.object_id = d.object_id
		INNER JOIN sys.tables     t ON t.object_id = d.referenced_major_id
		where p.name=@GridSp) 
		--order by ColName
		OPEN cur

		FETCH NEXT FROM cur INTO @Data_Type,@Column_Name;
		WHILE @@FETCH_STATUS = 0
		BEGIN   

		PRINT 'public '+@Data_Type+ ' '+@Column_Name+' { get; set;}'
		FETCH NEXT FROM cur INTO @Data_Type,@Column_Name;
		END

		CLOSE cur;
		DEALLOCATE cur;
		print 
		'}
		 }'
END
GO

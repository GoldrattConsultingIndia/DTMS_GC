USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_CreateClass]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_CreateClass]
@LinkId VARCHAR(MAX)=1,
@Gridid NVARCHAR(MAX)=1
AS
BEGIN
		DECLARE @GridClassnameColumn NVARCHAR(MAX),
				@Query1 NVARCHAR(MAX),
				@Classname NVARCHAR(MAX),
				@RoleId int,
				@GridSpName NVARCHAR(MAX),
				@GridSpNameQuery NVARCHAR(MAX),
				@GridSp NVARCHAR(MAX),
				@tableid NVARCHAR(MAX)

		
		SET @RoleId= (select DISTINCT RoleId from Obp_UserLinks where LinkId=@LinkId)

		--getting the sp for data to be displayed in datagrid
		SET @GridSpName='Grid'+@Gridid+'Sp'
		SET @GridSpNameQuery='select DISTINCT @GridSp='+@GridSpName+' from Obp_LFLinks where LinkId='+@LinkId
		EXEC Sp_executesql  @GridSpNameQuery,  N'@GridSp NVARCHAR(MAX) output',  @GridSp output 

		--get the class name
		SET @GridClassnameColumn='Grid'+@Gridid+'ClassName' --get the coloumn name for the table Obp_LinkClassName as : Grid1ClassName
		SET @Query1='SELECT @Classname='+@GridClassnameColumn+' FROM Obp_LinkClassName where LinkId='+@LinkId 
		EXEC Sp_executesql  @Query1,  N'@Classname NVARCHAR(MAX) output',  @Classname output --get the classname as class1

		DECLARE @Data_Type nvarchar(150),
				@Column_Name nvarchar(150)

		print 
	   'using System;
		using System.Collections.Generic;
		using System.Linq;
		using System.Web;

		namespace Onebeat_PL.Models
		{
			public class '+@Classname+'
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
		inner join Obp_RoleMap RM on Column_Name=RM.ColName
		 and table_name=RM.TableName
		WHERE  RM.IsVisible=1 and TableId in 
		(SELECT TableId FROM Obp_TableId where TABLENAME in 
		(SELECT DISTINCT t.name 
		FROM sys.sql_dependencies d 
		INNER JOIN sys.procedures p ON p.object_id = d.object_id
		INNER JOIN sys.tables     t ON t.object_id = d.referenced_major_id
		where p.name=@GridSp)) and RoleId=@RoleId
		order by ColName
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

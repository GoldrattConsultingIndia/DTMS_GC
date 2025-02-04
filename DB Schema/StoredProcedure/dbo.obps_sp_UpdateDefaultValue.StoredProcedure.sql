USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateDefaultValue]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[obps_sp_UpdateDefaultValue]
@TableName	  nvarchar(MAX)='',
@ColumnName		  nvarchar(MAX)='',
@default nvarchar(MAX)=''
AS
BEGIN

DECLARE @var_datatype int
DECLARE @Command nvarchar(max), @ConstraintName nvarchar(max)
set @var_datatype=(SELECT case when (DATA_TYPE='int' or DATA_TYPE='float' or DATA_TYPE='decimal') then 1 when  (DATA_TYPE='nvarchar' or DATA_TYPE='varchar') then 1 when DATA_TYPE='datetime' then 2 end 'Val'  FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME=@TableName and COLUMN_NAME=@ColumnName
)

SELECT @ConstraintName = name
    FROM sys.default_constraints
    WHERE parent_object_id = object_id(@TableName)
        AND parent_column_id = columnproperty(object_id(@TableName), @ColumnName, 'ColumnId')

SELECT @Command = 'ALTER TABLE ' + @TableName + ' DROP CONSTRAINT ' + @ConstraintName  
EXECUTE sp_executeSQL @Command

SELECT @Command = 'ALTER TABLE ' + @TableName + ' ADD CONSTRAINT ' + @ConstraintName + ' DEFAULT '+@default+' FOR ' + @ColumnName 
select @Command,@TableName,@ConstraintName,@default,@ColumnName
EXECUTE sp_executeSQL @Command

END
GO

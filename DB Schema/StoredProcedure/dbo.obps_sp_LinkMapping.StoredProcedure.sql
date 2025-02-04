USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_LinkMapping]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_LinkMapping]                  
@tabname nvarchar(MAX)='',                  
@linkid nvarchar(MAX)=''                  
AS                  
BEGIN                  
                  
DECLARE @count nvarchar(MAX)                  
DECLARE @col nvarchar(MAX)                  
                  
DECLARE @tabid int                  
set @tabid=(select isnull(tableid,0) from obps_TableId where tablename=@tabname)                                 
if  @tabid<>0                
begin                
                
	 DECLARE CUR_TESTCol CURSOR FAST_FORWARD FOR                  
	 SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @tabname ORDER BY ORDINAL_POSITION                  
	 OPEN CUR_TESTCol                  
	 FETCH NEXT FROM CUR_TESTCol INTO @col                  
	 WHILE @@FETCH_STATUS = 0                  
	 BEGIN                  
                  
	 SET @count=(select count(*) from obps_ColAttrib where tablename=@tabname and LinkId=@linkid and ColName=@col)                  
	 IF @count<=0                  
	 BEGIN                  
		 insert into obps_ColAttrib (TableID,TableName,ColName,DisplayName,ColControlType,IsEditable,ColColor,
		 FontColor,FontAttrib,CreatedDate,CreatedBY,ModifiedBy,IsActive,IsDeleted,DropDownLink,GridId,ColumnWidth,LinkId)                  
		 SELECT @tabid,@tabname,@col,@col,'textbox',1,NULL,NULL,NULL,getdate(),'','',1,0,NULL,NULL,NULL,@linkid           
	 END                  
	 FETCH NEXT FROM CUR_TESTCol INTO @col                  
	 END                  
                  
	 CLOSE CUR_TESTCol                  
	 DEALLOCATE CUR_TESTCol                  
	 exec obps_sp_InsertRoleMapping @linkid                
                    
	 select TableName,ColName,data_type as 'datatype',DisplayName,ColControlType,IsEditable,DropDownLink,
	 ColColor,IsActive,GridId as 'GridId',ColumnWidth,SortIndex,SortOrder,ToolTip,SummaryType,
	 case when IsMobile=1 then 'True' else'False' end IsMobile,
	 case when IsRequired=1 then 'True' else'False' end IsRequired, 
	 F.Icon,MinVal,MaxVal from obps_ColAttrib C          
	 left join obps_FormatCondIcon F on F.id=C.FormatCondIconId
	 inner join INFORMATION_SCHEMA.COLUMNS  i      
	 on TableName=i.TABLE_NAME and ColName=COLUMN_NAME                  
	 where LinkId=@linkid and TableName=@tabname                 
 end           
              
END 
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_insert_record]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_insert_record]                  
@str VARCHAR(MAX)='',                  
@Gridid NVARCHAR(MAX)='',                  
@LinkId NVARCHAR(MAX)='',                   
@forgkey nvarchar(MAX)='',                  
@usr nvarchar(MAX)='',                  
@loc nvarchar(MAX)=''                  
AS                  
BEGIN                  
DECLARE  @Rule_ID int,                  
  @ListType_ID int,                  
  @Values VARCHAR(MAX)=NULL,                  
  @col_name_strings varchar(MAX)='',                  
  @col_val_strings varchar(MAX)='',                  
  @insert_strings nvarchar(MAX)='',                  
  @tabname nvarchar(500)='',                  
  @tabnamequery nvarchar(MAX),                  
  @tab_name nvarchar(500),                  
  @query_Key nvarchar(MAX),                  
  @pkey NVARCHAR(MAX),                  
  @sout NVARCHAR(MAX),                  
  @forkey nvarchar(MAX),                  
  @aftersavespname nvarchar(MAX)='',                  
  @isLocation nvarchar(2)='',                  
  @locationColName nvarchar(max)=''                  
                    
                  
DECLARE @col varchar(MAX)                  
DECLARE @colnew varchar(MAX)=''                  
DECLARE @val varchar(MAX),                  
@indx int,@ddlcoltosel nvarchar(MAX),@ddlcoltoinsert nvarchar(MAX),@ddltabletosel nvarchar(MAX),                  
@controltype varchar(MAX), @queryvalstr NVARCHAR(MAX),@ddlid nvarchar(MAX),@colid int,@isId int                
        
SET @tab_name=(SELECT gridtable FROM Obps_topLinkExtended where Gridid=@Gridid and linkid=@LinkId)                  
                  
--SET @forkeystr=('(select @forkey=ForeignKey from obps_TableId where ForeignKey is not null and tablename='''+@tab_name+''' and Gridid='''+@gridid+'''and linkid='''+@LinkId+''')')                 
--EXEC Sp_executesql  @forkeystr,  N'@forkey NVARCHAR(MAX) output',  @forkey output                  
        
SET @forkey=(select ForeignKey from obps_TableId where ForeignKey is not null and tablename=@tab_name and Gridid=@gridid and linkid=@LinkId)                 
        
IF EXISTS(                  
SELECT TOP 1 * FROM INFORMATION_SCHEMA.COLUMNS                  
WHERE [TABLE_NAME] = @tab_name AND [COLUMN_NAME] = @forkey)                  
BEGIN                 
 IF @forkey<>''                  
 BEGIN                  
  if @col_name_strings<>''                   
  begin                  
    set @col_name_strings=@col_name_strings+ ','                  
    SET @col_name_strings=@col_name_strings+''+@forkey                  
    SET @col_val_strings=@col_val_strings+''','''+@forgkey                  
  END                  
  else                  
  begin                  
    SET @col_name_strings=@col_name_strings+''+@forkey                  
    SET @col_val_strings=''''+@forgkey                  
  END                  
 END                  
END                  
                  
                  
DECLARE CUR_TEST CURSOR FAST_FORWARD FOR                  
SELECT SUBSTRING (items,0,CHARINDEX(':',items,0)) as colname,SUBSTRING (items,CHARINDEX(':',items,0)+1,len(items)) as colval                  
FROM [dbo].[Split] (@str, '^') ;                  
                   
OPEN CUR_TEST                  
FETCH NEXT FROM CUR_TEST INTO @col,@val                  
 --if @val<> 'null'            
 --begin            
            
  WHILE @@FETCH_STATUS = 0                  
  BEGIN                 
  if @val<> 'null'            
  begin            
   if @col <> 'Id' and @col <> 'id1' and @col <> 'CreatedDate'                  
   begin                  
    SET @indx=(select CHARINDEX ('__',@col,0 ))                  
    SET @colnew=(SELECT SUBSTRING(@col, 1,@indx-1))                  
    SET @tabname=(SELECT SUBSTRING(@col, @indx+2, LEN(@col)))                  
   end                  
   if @col <> 'Id' and @col <> 'id1' and @col <> 'CreatedDate'                  
   begin                  
   select '1.0'              
   set @controltype=(select ColControlType from obps_ColAttrib                   
   where ColName=@colnew and TABLENAME = @tabname and linkid=@LinkId)                
   select @controltype 'controltype',@colnew 'colname'              
   if LOWER(@controltype)='dropdownlist'                  
   begin
     print 'Test 1'                  
	 print @colnew
	 print @tabname
	 print @linkid

     SET @colid=(SELECT id from obps_ColAttrib where colname=@colnew AND TABLENAME = @tabname AND linkid=@linkid)                  
     SET @ddlcoltosel=(SELECT columntoselect from obps_dropdowntable where columnid=@colid)                   
     SET @ddlcoltoinsert=(SELECT columntoinsert from obps_dropdowntable where columnid=@colid)                  
     SET @ddltabletosel=(SELECT tabletoselect from obps_dropdowntable where columnid=@colid)                  
     SET @IsId=(SELECT IsId from obps_dropdowntable where columnid=@colid)                  
     select 'Dropdown',@colid,@ddlcoltosel,@ddlcoltoinsert,@ddltabletosel,@IsId                  
     IF @IsId=1                  
     BEGIN                  
   set @queryvalstr='select @ddlid=id from '+@ddltabletosel+' where '+@ddlcoltosel+'='''+@val+''''                  
   select @queryvalstr                  
   EXEC Sp_executesql  @queryvalstr,  N'@ddlid NVARCHAR(MAX) output',  @ddlid output                  
   --select @ddlid                  
   SET @val=@ddlid                  
   --set @colnew='Clientid'                    
     END                  
                  
     if @col_name_strings=''                   
     begin                  
                         
   set @col_name_strings=  RTRIM(LTRIM(@ddlcoltoinsert))                   
   set @col_val_strings= ''''+@val                  
     end                  
     else                   
     begin                  
   set @col_name_strings=@col_name_strings+ ','+  RTRIM(LTRIM(@ddlcoltoinsert))                  
   set @col_val_strings=@col_val_strings+''','''+ @val                  
    end                  
    end                  
   else if @tab_name=@tabname                  
   begin                  
     IF EXISTS(                  
     SELECT TOP 1 *                  
     FROM INFORMATION_SCHEMA.COLUMNS                  
     WHERE [TABLE_NAME] = @tab_name                  
     AND [COLUMN_NAME] = @colnew)                  
     BEGIN                  
                  
   if @col_name_strings=''                   
   begin                  
    select @col_name_strings                  
    set @col_name_strings=  RTRIM(LTRIM(@colnew))                   
    set @col_val_strings= ''''+@val                  
   end                  
   else                   
   begin                  
    set @col_name_strings=@col_name_strings+ ','+  RTRIM(LTRIM(@colnew))                  
    set @col_val_strings=@col_val_strings+''','''+ @val                  
   end                  
     END                  
    end                  
   END                  
                  
    IF @col = 'id1'                  
    BEGIN                  
  IF EXISTS(SELECT TOP 1 * FROM INFORMATION_SCHEMA.COLUMNS                  
  WHERE [TABLE_NAME] = @tab_name AND [COLUMN_NAME] = 'id1')                  
  BEGIN                  
                  
    if @col_name_strings=''                   
    begin                  
     select @col_name_strings                  
     set @col_name_strings=  RTRIM(LTRIM(@col))                   
     set @col_val_strings= ''''+@val                  
    end                  
    else                   
    begin                  
     set @col_name_strings=@col_name_strings+ ','+  RTRIM(LTRIM(@col))                  
     set @col_val_strings=@col_val_strings+''','''+ @val                  
    end                  
  END                  
    END                  
    IF @col = 'CreatedDate'                  
    BEGIN                  
  IF EXISTS(SELECT TOP 1 * FROM INFORMATION_SCHEMA.COLUMNS                  
  WHERE [TABLE_NAME] = @tab_name AND [COLUMN_NAME] = 'CreatedDate')                  
  BEGIN                  
                  
    if @col_name_strings=''                 
    begin                  
     select @col_name_strings                  
     set @col_name_strings=  RTRIM(LTRIM(@col))                   
     set @col_val_strings= ''''+@val                  
    end                  
    else                   
    begin                  
     set @col_name_strings=@col_name_strings+ ','+  RTRIM(LTRIM(@col))                  
     set @col_val_strings=@col_val_strings+''','''+ @val                  
    end                  
  END                  
    END              
    END            
        FETCH NEXT FROM CUR_TEST INTO @col,@val                  
  END                  
  -- END               
  set @col_val_strings=@col_val_strings+''''                
CLOSE CUR_TEST           
DEALLOCATE CUR_TEST                  
if @col_name_strings<>''                   
begin                  
set @col_name_strings=@col_name_strings+ ','                  
--SET @col_name_strings=@col_name_strings+'IsDeleted,IsActive,CreatedDate,Createdby'                  
--SET @col_val_strings=@col_val_strings+',0,1,'''+CONVERT(CHAR(24),  GETDATE(), 121)+''','''+@usr+''''                  
SET @col_name_strings=@col_name_strings+'Createdby'                  
SET @col_val_strings=@col_val_strings+','''+@usr+''''                  
select @col_name_strings as 'colstr',@col_val_strings as 'val'              
END                  
                   
SET @pkey=(SELECT TableKey FROM Obps_TableId WHERE TableName=@tabname)                  
                  
SET @isLocation=(select IsLocation from obps_TopLinks where id=@LinkId)                  
if(@isLocation='1')                  
BEGIN                  
                   
 SET @locationColName=(select locationcolname from obps_locationconfig where linkid=@LinkId)                  
 SET @col_name_strings=@col_name_strings+','+@locationColName                  
 SET @col_val_strings=@col_val_strings+','''+@loc+''''                  
                  
END                  
                  
set @insert_strings='insert into '+@tab_name+'('+@col_name_strings+')values('+@col_val_strings+')'                  
select @tab_name,@insert_strings,@col_name_strings,@col_val_strings                  
EXEC Sp_executesql  @insert_strings--,N'@sout NVARCHAR(MAX) output',  @sout output                  
   declare @lastid int='';                
   SET @lastid=@@IDENTITY                
                
      select * from obps_TopLinkExtended        
        
SET @aftersavespname=(SELECT AfterSaveSp  from obps_TopLinkExtended where GridId=@Gridid and Linkid=@LinkId)                  
                  
 IF len(@aftersavespname)>0                   
 BEGIN                    
 select @aftersavespname,@lastid                
 EXEC @aftersavespname @lastid                   
 END                   
                  
END     
GO

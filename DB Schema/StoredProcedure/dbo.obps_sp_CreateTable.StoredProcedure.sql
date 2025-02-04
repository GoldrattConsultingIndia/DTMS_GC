USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_CreateTable]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_CreateTable]  
@tabname nvarchar(MAX)=''  
AS  
BEGIN  
 DECLARE @id int='',@UserCol int  
 DECLARE @str nvarchar(MAX)='',@createStr nvarchar(MAX)  
 DECLARE @TableIdStr nvarchar(MAX)  
 DECLARE @TabId nvarchar(MAX)  
 DECLARE  @col nvarchar(MAX),@dat nvarchar(MAX),@allownull nvarchar(MAX),@default nvarchar(MAX)  
 DECLARE @i int=2;  
 DECLARE @count int=0;  
  
 ---------------------------------------insert to tableid table-------------------------------------  
 SET @TabId=(select max(tableid) from  obps_TableId)  
 SET @TabId= case when @TabId IS NULL then 300 else @TabId+1 end  
 select @TabId  
 set @count=(SELECT count(*) from obps_TableId where TableName=@tabname)  
 if @count=0  
 begin  
 SET @TableIdStr='insert into obps_TableId(TableName,TableId,TableKey) values('''+@tabname+''','+@TabId+',''id'')'  
 exec (@TableIdStr)  
 select @TableIdStr    
 end  
  
 DECLARE CUR_TEST CURSOR FAST_FORWARD FOR  
 select ColumnName,DataType,AllowNulls,DefaultValue,UserColumn from [dbo].[obps_CreateTableTemp] ;  
 OPEN CUR_TEST  
 FETCH NEXT FROM CUR_TEST INTO @col,@dat,@allownull,@default,@UserCol  
   WHILE @@FETCH_STATUS = 0  
   BEGIN  
    if @UserCol=1  
    begin  
     select 'inside'  
     update obps_TableId set TableUserCol=@col where TableName=@tabname  
    end  
  
    IF Lower(@dat)='nvarchar'  
    BEGIN  
     set @dat='nvarchar(MAX)'  
     if @default<>''  
     BEGIN  
      set @default=''''+@default+''''  
     END  
    END  
    select @default  
    IF Lower(@dat)='datetime' and @default<>''  
    BEGIN  
     set @default=''''+@default+''''  
    END  
      
    if @default=''  
    BEGIN  
     SET @default=''  
    END  
    ELSE  
    BEGIN  
     SET @default=' DEFAULT '+@default  
    END  
    IF @str=''  
    BEGIN  
     SET @str='['+@col+'] '+@dat+' '+@allownull +@default  
    END  
    ELSE  
    BEGIN  
     SET @str= @str+',['+@col+'] '+@dat+' '+@allownull +@default  
    END  
    
  
    SET @i=@i+1  
    --select  @col,@dat,@allownull,@default   
    FETCH NEXT FROM CUR_TEST INTO @col,@dat,@allownull,@default,@UserCol  
   END  
     
 --END  
 set @str=@str+','  
 CLOSE CUR_TEST  
 DEALLOCATE CUR_TEST  
  
 ---select @str  
  
  
 IF @str<>''  
 BEGIN  
  SET @createStr='CREATE TABLE [dbo].['+@tabname+  
      ']([id] [int] IDENTITY(100,1) NOT NULL,'+  
      @str+  
      '[CreatedDate] [datetime] NULL DEFAULT (getdate()),  
      [ModifiedDate] [datetime] NULL,  
      [Createdby] [nvarchar](100) NULL,  
      [Modifiedby] [nvarchar](100) NULL)'  
      --ALTER TABLE [dbo].['+@tabname+'] ADD  DEFAULT (getdate()) FOR [CreatedDate]  
      --ALTER TABLE [dbo].['+@tabname+'] ADD  DEFAULT ((1)) FOR [isActive]  
      --ALTER TABLE [dbo].['+@tabname+'] ADD  DEFAULT ((0)) FOR [isDeleted]  
  delete from obps_CreateTableTemp  
  select @createStr  
  exec (@createStr)  
    
    
 END  
END  
GO

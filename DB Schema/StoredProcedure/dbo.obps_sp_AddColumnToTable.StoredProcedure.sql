USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_AddColumnToTable]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_AddColumnToTable]    
@tabname nvarchar(MAX)='',    
@ColName nvarchar(MAX)='',    
@Datatype nvarchar(MAX)='',    
@Default nvarchar(MAX)='',    
@AllowNull nvarchar(MAX)='',    
@UserCol nvarchar(MAX)=''    
AS    
BEGIN    
DECLARE @str nvarchar(MAX),@allownullstr nvarchar(MAX),@def nvarchar(MAX)    
DECLARE @id nvarchar(MAX),@sp nvarchar(MAX),@spname nvarchar(MAX),@count int=0    
 if @AllowNull='true'    
 BEGIN    
  SET @allownullstr='  NULL;'    
 END    
 else    
  SET @allownullstr='  NOT NULL;'    
 IF Lower(@Datatype)='nvarchar'    
 BEGIN    
  set @Datatype='nvarchar(MAX)'    
  if @default<>''    
  BEGIN    
   set @default=''''+@default+''''    
  END    
 END    
 select @default    
 IF Lower(@Datatype)='datetime' and @default<>''    
 BEGIN    
  set @default=''''+@default+''''    
 END    
        
    
    
	 if @Default=''    
	 BEGIN  
	  SET @def=''    
	  if @allownullstr='  NOT NULL;'  
	 SET @allownullstr='  NULL;'  
	 end  
	 else    
	  SET @def='DEFAULT '+@default    

	 SET @str='ALTER TABLE '+@tabname+' ADD '+@ColName+' '+ @Datatype+' '+@def+' '+@allownullstr    
	 select @str     
	 exec (@str)    

	DECLARE CUR_tabCol CURSOR FAST_FORWARD FOR    
	SELECT Linkid,gridsp from obps_TopLinkextended      
	OPEN CUR_tabCol    
	FETCH NEXT FROM CUR_tabCol INTO @id,@sp    
	WHILE @@FETCH_STATUS = 0    
	BEGIN    

		set @count=(SELECT count(SPECIFIC_NAME) FROM information_schema.routines ISR WHERE CHARINDEX(@tabname, ISR.ROUTINE_DEFINITION) > 0   
		and ROUTINE_NAME=@sp and ROUTINE_TYPE='PROCEDURE')
		  IF @count>0  
		   exec obps_sp_ColAttribMapping @id     
    
	FETCH NEXT FROM CUR_tabCol INTO @id,@sp    
	END    
    
	CLOSE CUR_tabCol    
	DEALLOCATE CUR_tabCol      
END    
GO

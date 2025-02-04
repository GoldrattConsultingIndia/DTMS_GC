USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertRoleMapping]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[obps_sp_InsertRoleMapping]                  
@id int=0   
AS                  
BEGIN                   
DECLARE @tab nvarchar(MAX)='', @spname nvarchar(MAX)=''                  
DECLARE @col nvarchar(MAX)=''                  
DECLARE @tabid nvarchar(MAX)=''                
DECLARE @roleid nvarchar(MAX)='' ,@sublinkid nvarchar(MAX)=''                 
DECLARE @count int=0,@gcount int =0 ,@i int=1             
              
SET @roleid=(select roleid from obps_userlinks where id=@id)             
SET @sublinkid=(select sublinkid from obps_userlinks where id=@id)   
 
SET @gcount=(select count(*) from obps_TopLinkExtended where Linkid=@sublinkid and GridId is not null and gridid<>'')  

while @i<=@gcount  
BEGIN  
  SET @spname= (select gridsp from obps_TopLinkExtended where Linkid=@sublinkid and GridId=@i) 
  
  DECLARE CUR_TEST CURSOR FAST_FORWARD FOR                  
  SELECT   NAME as tabname FROM SYSOBJECTS WHERE ID IN (SELECT SD.DEPID  FROM SYSOBJECTS SO,                     
      SYSDEPENDS SD   WHERE SO.NAME in( @spname)AND SD.ID = SO.ID)                   
  OPEN CUR_TEST                  
  FETCH NEXT FROM CUR_TEST INTO @tab                  
    WHILE @@FETCH_STATUS = 0                  
    BEGIN                 
      set @tabid=(select isnull(TableId,0) from obps_TableId where tablename=@tab)      
      if  @tabid<>0                  
      begin             
        DECLARE CUR_TEST1 CURSOR FAST_FORWARD FOR                  
        SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @tab ORDER BY ORDINAL_POSITION                  
        OPEN CUR_TEST1                  
        FETCH NEXT FROM CUR_TEST1 INTO @col                  
         WHILE @@FETCH_STATUS = 0                  
         BEGIN                  
          SET @count=(select count(*) from obps_rolemap where tablename=@tab and RoleId=@roleid and ColName=@col and gridid=@i)              
          if(@count=0)     
           exec obps_sp_InsertRoleMap @tab,@tabid,@col,'',@roleid,@i,@sublinkid    
    
         FETCH NEXT FROM CUR_TEST1 INTO @col                  
         END                  
                  
        CLOSE CUR_TEST1                  
        DEALLOCATE CUR_TEST1                  
      END          
      FETCH NEXT FROM CUR_TEST INTO @tab                  
    END                  
                  
  CLOSE CUR_TEST                  
  DEALLOCATE CUR_TEST    
 SET @i=@i+1  
END                  
END 
GO

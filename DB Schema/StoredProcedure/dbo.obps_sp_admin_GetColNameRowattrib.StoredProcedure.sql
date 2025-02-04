USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_admin_GetColNameRowattrib]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_admin_GetColNameRowattrib]            
@tabname nvarchar(MAX)=''  ,          
@condition nvarchar(MAX)=''        
AS            
BEGIN            
 IF @condition='color'          
 BEGIN     
	  select 1 'id','color1' 'ColName' 
	  union
	  select 2 'id','color2' 'ColName'
	  union
	  select 3 'id','color3' 'ColName'
	  union
	  select 4 'id','color4' 'ColName' 
	  union
	  select 5 'id','color5' 'ColName'
	  union
	  select 6 'id','color6' 'ColName'
	  union
	  select 7 'id','color7' 'ColName'
  --SELECT ORDINAL_POSITION 'id',lower(COLUMN_NAME) 'ColName'          
  --FROM INFORMATION_SCHEMA.COLUMNS          
  --WHERE TABLE_NAME = @tabname          
  --and COLUMN_NAME not in ('id','id1','SeqNo','CreatedDate','ModifiedDate','Createdby','Modifiedby','isActive','isDeleted','AccessToUser',        
  --'ShareToUser','iscelledit1','iscelledit2','iscelledit3','iscelledit4','iscelledit5','iscelledit6','iscelledit7')          
  --and COLUMN_NAME in('Color1','Color2','Color3','Color4','Color5','Color6','Color7')        
  --ORDER BY ORDINAL_POSITION        
 END        
 ELSE IF @condition='edit'        
 BEGIN      
	  select 1 'id','iscelledit1' 'ColName' 
	  union
	  select 2 'id','iscelledit2' 'ColName'
	  union
	  select 3 'id','iscelledit3' 'ColName'
	  union
	  select 4 'id','iscelledit4' 'ColName' 
	  union
	  select 5 'id','iscelledit5' 'ColName'
	  union
	  select 6 'id','iscelledit6' 'ColName'
	  union
	  select 7 'id','iscelledit7' 'ColName'
  --select  ORDINAL_POSITION 'id',lower(COLUMN_NAME) 'ColName'               
  --FROM INFORMATION_SCHEMA.COLUMNS          
  --WHERE TABLE_NAME = @tabname         
  --and COLUMN_NAME not in ('id','id1','Color1','Color2','Color3','Color4','Color5','SeqNo','CreatedDate','ModifiedDate',        
  --'Createdby','Modifiedby','isActive','isDeleted','AccessToUser','ShareToUser')            
  --and COLUMN_NAME in('iscelledit1','iscelledit2','iscelledit3','iscelledit4','iscelledit5','iscelledit6','iscelledit7')         
 END    
  ELSE IF @condition='mctrl'        
 BEGIN        
  select  ORDINAL_POSITION 'id',lower(COLUMN_NAME) 'ColName'               
  FROM INFORMATION_SCHEMA.COLUMNS          
  WHERE TABLE_NAME = @tabname         
  and COLUMN_NAME not in ('id','id1','Color1','Color2','Color3','Color4','Color5','SeqNo','CreatedDate','ModifiedDate',        
  'Createdby','Modifiedby','isActive','isDeleted','AccessToUser','ShareToUser')            
  and COLUMN_NAME in('ctrltype1','ctrltype2','ctrltype3','ctrltype4','ctrltype5','ctrltype6','ctrltype7')         
 END   
 ElSE      
 BEGIN      
  select  ORDINAL_POSITION 'id',lower(COLUMN_NAME) 'ColName'               
  FROM INFORMATION_SCHEMA.COLUMNS          
  WHERE TABLE_NAME = @tabname         
  and COLUMN_NAME not in ('id','id1','SeqNo','CreatedDate','ModifiedDate',        
  'Createdby','Modifiedby','isActive','isDeleted','AccessToUser','ShareToUser')            
  and COLUMN_NAME in('Color1','Color2','Color3','Color4','Color5','iscelledit1','iscelledit2','iscelledit3','iscelledit4','iscelledit5','iscelledit6','iscelledit7')         
 END      
END     
    
GO

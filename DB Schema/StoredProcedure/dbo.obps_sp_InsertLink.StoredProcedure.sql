USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertLink]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_InsertLink]              
@operation nvarchar(MAX)='',    
@mainmenu int='',    
@linkid nvarchar(MAX)='',              
@LinkName nvarchar(MAX)='',    
@Type nvarchar(MAX)='',     
@SortOrder int='',    
@UniversalSearch int='',     
@IsLocation int='',    
@IsAfterLogin int='',              
@IsImportEnabled int='',    
@IsMobile int='',    
@IsSamePage int='',    
@CsvSeperator nvarchar(MAX)='' ,    
@ContBtnEnable int='',    
@AddBtnSp nvarchar(MAX)='' ,    
@EditBtnSp nvarchar(MAX)='' ,    
@DeleteBtnSp nvarchar(MAX)=''     
AS              
BEGIN              
 DECLARE @ins_id int=0  
 BEGIN TRY
	 IF @operation = 'add'              
	 BEGIN            
		INSERT INTO obps_TopLinks              
		 (LinkName,Type,MenuId,SortOrder,IsAfterLogin,IsImportEnabled,IsMobile    
		 ,EnableUniversalSearch,IsLocation,IsSamePage,ConditionalCRUDBtn,CondCRUDBtnAddSp,    
		 CondCRUDBtnEditSp ,CondCRUDBtnDeleteSp,CSVSeperator)    
		values              
		 (@LinkName,@Type,@mainmenu,@SortOrder,@IsAfterLogin,@IsImportEnabled,@IsMobile,    
		 @UniversalSearch,@IsLocation,@IsSamePage,@ContBtnEnable,@AddBtnSp,    
		 @EditBtnSp,@DeleteBtnSp,@CsvSeperator)    
		select 'Link Added'              
		--SET @ins_id=(SELECT SCOPE_IDENTITY())              
		--exec obps_sp_ColAttribMapping @ins_id       
		--exec obps_sp_InsertRoleMapping @ins_id      
	 END         
	 ELSE              
	 BEGIN              
	  update obps_TopLinks set LinkName=@LinkName,Type=@Type,MenuId=@mainmenu,  
	   SortOrder=@SortOrder,IsAfterLogin=@IsAfterLogin,IsImportEnabled=@IsImportEnabled,IsMobile=@IsMobile,    
	   EnableUniversalSearch=@UniversalSearch,IsLocation=@IsLocation,IsSamePage=@IsSamePage,  
	   ConditionalCRUDBtn=@ContBtnEnable,CondCRUDBtnAddSp=@AddBtnSp,CondCRUDBtnEditSp=@EditBtnSp ,  
	   CondCRUDBtnDeleteSp=@DeleteBtnSp,CSVSeperator=@CsvSeperator where id=@linkid  
	   select 'Data Updated'  
	 END
END TRY  
BEGIN CATCH  
    SELECT  ERROR_NUMBER()  +'  :  '+ERROR_MESSAGE()   
END CATCH 
END 

GO

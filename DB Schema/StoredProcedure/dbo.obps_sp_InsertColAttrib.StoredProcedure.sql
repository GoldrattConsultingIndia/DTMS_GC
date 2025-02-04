USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_InsertColAttrib]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_InsertColAttrib]  
@tabname nvarchar(MAX)='',  
@tabid nvarchar(MAX)='',  
@colname nvarchar(MAX)='',  
@usrname nvarchar(MAX)=''  
AS  
BEGIN  
 INSERT INTO [dbo].[obps_ColAttrib]  
      ([TableID],[TableName],[ColName],[DisplayName],[ColControlType]
      ,[IsEditable],[ColColor],[FontColor],[FontAttrib],[CreatedDate],[CreatedBY]  
      ,[ModifiedBy],[IsActive],[IsDeleted],[DropDownLink],[GridId],[ColumnWidth],[LinkId])  
   VALUES  
      (@tabid,@tabname,@colname,@colname,'textbox',1,  
      NULL,NULL,NULL,getdate(),@usrname,  
      '',1,0,NULL,NULL,NULL,NULL)  
END  
GO

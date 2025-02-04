USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getColDetails]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[obps_sp_getColDetails]                                                  
@username NVARCHAR(MAX)='',                                
@RoleId NVARCHAR(MAX)='',                                                  
@LinkId NVARCHAR(MAX)='',                                                  
@GridId int=''                                                  
AS                                                  
BEGIN                                                  
DECLARE @query NVARCHAR(MAX),                                                  
    @query_colorid NVARCHAR(MAX),                                                  
    @tabname NVARCHAR(MAX),                                                  
    @cid NVARCHAR(MAX),                                                  
    @spquery NVARCHAR(MAX) ,                                                  
    @spname NVARCHAR(MAX),                                                  
    @query_color NVARCHAR(MAX),                                                  
    @colorname NVARCHAR(MAX),                                                  
    @iRoleId int      ,                                
    @IsRoleAttached int                                
                                                  
    SET NOCOUNT ON;                                   
               
  SET  @spname=(SELECT gridsp FROM obps_TopLinkExtended where gridid=@GridId and Linkid=@LinkId)            
                               print 0  
  SET @IsRoleAttached=COALESCE((SELECT top 1 case when IsRoleAttached=''  then 0 else IsRoleAttached end from obps_UserLinks                                 
   where UserId=(select top 1 id from obps_Users where UserName=@username) and subLinkId=@LinkId and isdeleted=0),0)     
     print 012  
  SET @iRoleId=(SELECT SUBSTRING(@RoleId, 5, 1))                                      
                               
   if(@IsRoleAttached=1)                          
   BEGIN                          
   print 1  
     select lower(COL.ColName) +'__'+LOWER(Col.TableName) as ColumnName,data_type,COL.DisplayName,COL.ColControlType,                                                   
     COL.ColColor,COALESCE(RM.IsEditable,1),col.ColumnWidth,col.SortIndex ,col.SortOrder,col.IsMobile,col.tooltip,              
     col.SummaryType,COALESCE(RM.IsVisible,1) 'isvisible',COALESCE(RM.VisibilityIndex,-1)'VisibilityIndex',              
     @IsRoleAttached 'IsRoleAttached',IsRequired,F.Icon,MinVal,MaxVal,IsValidation,IsRefreshDDL                                       
     --into #inpclass                                                  
     FROM INFORMATION_SCHEMA.COLUMNS                                                  
     inner join Obps_RoleMap RM on Column_Name=RM.ColName                                                  
     and table_name=RM.TableName                                                  
     inner join Obps_ColAttrib COL on RM.TableName=Col.TableName                 
     --and RM.GridId=Col.GridId                                                  
     and RM.ColName=COL.ColName                      
     left join obps_FormatCondIcon F on Col.FormatCondIconId=F.id              
     -- left join Obps_ColorPicker colr on COL.ColColor=colr.ID                                                  
     WHERE  --RM.IsVisible=1 and                                               
     RM.TableID in                                                  
     (SELECT TableId FROM Obps_TableId where TABLENAME in                                                   
     (SELECT DISTINCT t.name                                                   
     FROM sys.sql_dependencies d                                                   
     INNER JOIN sys.procedures p ON p.object_id = d.object_id                                                  
     INNER JOIN sys.tables     t ON t.object_id = d.referenced_major_id                                                  
     where p.name=@spname)) and RoleId=@iRoleId and RM.GridId=@GridId and Col.LinkId=@LinkId                   
                
     UNION              
              
     select lower(ColName) as ColumnName,'nvarchar(MAX)',DisplayName,'textbox',                                                   
     ColColor,0,ColumnWidth,SortIndex ,SortOrder,IsMobile ,tooltip ,SummaryType,1,'-1',              
     @IsRoleAttached,0,F.Icon,MinVal,MaxVal,0,IsRefreshDDL                   
     FROM obps_CalculatedColAttrib               
     left join obps_FormatCondIcon F on FormatCondIconId=F.id            
     where LinkId=@LinkId    and   GridId=@GridId                
                
   END                          
   ELSE                          
   BEGIN           
   print 2  
     select lower(COL.ColName) +'__'+LOWER(Col.TableName) as ColumnName,data_type,COL.DisplayName,COL.ColControlType,              
     COL.ColColor,col.IsEditable,col.ColumnWidth,col.SortIndex ,col.SortOrder,col.IsMobile,col.tooltip,                  
     col.SummaryType,COALESCE(IsActive,1) 'isvisible',                                
     -1 'VisibilityIndex',0 'IsRoleAttached',IsRequired,F.Icon,MinVal,MaxVal,IsValidation,IsRefreshDDL                                       
     --into #inpclass                                                 
     FROM INFORMATION_SCHEMA.COLUMNS                          
     inner join Obps_ColAttrib COL on                           
     table_name=TableName and Column_Name=ColName                     
     left join obps_FormatCondIcon F on FormatCondIconId=F.id              
     where  TableID in                                                  
     (SELECT TableId FROM Obps_TableId where TABLENAME in                                                   
     (SELECT DISTINCT t.name                                                   
     FROM sys.sql_dependencies d                                                   
     INNER JOIN sys.procedures p ON p.object_id = d.object_id                                                  
     INNER JOIN sys.tables     t ON t.object_id = d.referenced_major_id              
     where p.name=@spname))  --and GridId=@GridId                           
     and LinkId=@LinkId                        
                
     UNION                                              
                
     select lower(ColName) as ColumnName,'nvarchar(MAX)',DisplayName,'textbox',                                                   
     ColColor,0,ColumnWidth,SortIndex ,SortOrder,IsMobile ,tooltip ,SummaryType,1,'-1',              
     @IsRoleAttached,0,F.Icon,MinVal,MaxVal,0,IsRefreshDDL                                          
     FROM obps_CalculatedColAttrib                
     left join obps_FormatCondIcon F on FormatCondIconId=F.id              
     where LinkId=@LinkId and GridId=@GridId                                  
   END                          
END 
GO

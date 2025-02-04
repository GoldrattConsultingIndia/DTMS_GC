USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_GetUserLinkDataGrid]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_GetUserLinkDataGrid]          
@usrname nvarchar(MAX)='',      
@mainmenu nvarchar(MAX)='',      
@submenu nvarchar(MAX)=''      
AS          
BEGIN         
if(@usrname<>'')
	select L.id,userid,username,linkid,L.linkname as 'mainmenu',createddate,        
 createdby,modifiedby,isactive,isdeleted,roleid,T.LinkName as 'sublink',L.IsRoleAttached 'isrole'        
 from obps_UserLinks L inner join obps_TopLinks T          
 on L.LinkId=T.MenuId and T.ID=L.sublinkid        
 where LOWER(UserName)<>'admin'  and IsDeleted=0 
 and username=@usrname order by L.LinkName 
ELSE
select L.id,userid,username,linkid,L.linkname as 'mainmenu',createddate,        
 createdby,modifiedby,isactive,isdeleted,roleid,T.LinkName as 'sublink',L.IsRoleAttached 'isrole'        
 from obps_UserLinks L inner join obps_TopLinks T          
 on L.LinkId=T.MenuId and T.ID=L.sublinkid        
 where LOWER(UserName)<>'admin'  and IsDeleted=0 order by username       
 --and LOWER(UserName)=@usrname and L.LinkId=@mainmenu      
 --and T.ID=@submenu      
 --select L.id,userid,username,linkid,L.linkname as 'mainmenu',createddate,        
 --createdby,modifiedby,isactive,isdeleted,roleid,T.LinkName as 'sublink'        
 --from obps_UserLinks L inner join obps_TopLinks T          
 --on L.LinkId=T.MenuId and T.ID=L.sublinkid        
 --where LOWER(UserName)<>'admin'  and IsDeleted=0        
 --and LOWER(UserName)=@usrname and L.LinkId=@mainmenu      
 --and T.ID=@submenu      
END        
  
GO

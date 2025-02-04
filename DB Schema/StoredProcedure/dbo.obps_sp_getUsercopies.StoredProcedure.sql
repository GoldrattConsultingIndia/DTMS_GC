USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getUsercopies]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[obps_sp_getUsercopies]      
AS      
BEGIN      
      
select T.ID      
,UserName      
,RoleId      
,Company      
,Division      
,Department      
,SubDept      
,T.UserTypeId
,UserType 'usertype' 
,M.DisplayName    
,L.LinkName  'submenu'    
,PrefLang      
,AfterLoginSP      
,Permission      
,ReportingManager      
,EmailId     
from obps_Users_temp  T    
left join obps_TopLinks L on T.DefaultLinkId=L.ID     
left join obps_MenuName M on M.MenuId=L.MenuId  
left join obps_usertype U on U.usertypeid=T.UserTypeId
      
END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getMenuName]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_getMenuName]     
@id nvarchar(MAX)=''  ,
@populateddl nvarchar(MAX)=''
AS      
BEGIN  
if @populateddl=''
BEGIN
	 if @id=''  
	 BEGIN  
		select Id,DisplayName from obps_MenuName where IsVisible=1  
	 END  
	 ELSE  
	 BEGIN  
		select Id,DisplayName,IsVisible from obps_MenuName where id=@id  
	 END  
END
ELSE
BEGIN
	if @populateddl='yes'
		select Id,DisplayName from obps_MenuName
	ELSE
		select Id,DisplayName from obps_MenuName where IsVisible=1 
END
END
GO

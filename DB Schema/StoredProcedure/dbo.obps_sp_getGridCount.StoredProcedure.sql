USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getGridCount]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getGridCount]  
@TypeId INT  
AS  
BEGIN  
select Gridcount from obps_PageType where PageTypeId=@TypeId
END  
GO

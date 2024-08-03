USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadDDLCount]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_ReadDDLCount]            
@username nvarchar(MAX)='' ,          
@linkid nvarchar(3)=''       
AS            
BEGIN  
DECLARE @count int=0;
SET @count=(select count(*) from obps_mobileConfig where linkid=@linkid)
select @count
          
END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_SetGlobalValues]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[obps_sp_SetGlobalValues]        
@usrname nvarchar(MAX)=''        
AS        
BEGIN        
  
select value from obps_GlobalConfig where variables='LogoRequired'
        
END 
GO

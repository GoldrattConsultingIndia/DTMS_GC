USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_DDLLocationType]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_DDLLocationType]   
(@usrnme NVARCHAR(MAX)='',             
@linkid int='' ,       
@gridid nvarchar(MAX)=''   
)   
AS        
BEGIN        
SELECT 1 'id','SP' 'name'  
UNION 
SELECT 1 'id','PL' 'name'  
UNION 
SELECT 1 'id','WH' 'name'  
 order by id       
 END
GO

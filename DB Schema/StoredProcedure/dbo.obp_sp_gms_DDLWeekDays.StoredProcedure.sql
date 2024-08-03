USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obp_sp_gms_DDLWeekDays]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obp_sp_gms_DDLWeekDays]    
(    
@usrnme NVARCHAR(MAX)='',              
@linkid int='' ,        
@gridid nvarchar(MAX)=''    
)    
AS         
BEGIN         
SELECT 1 id,'Mon' name 
UNION
SELECT 2 id,'Tue' name 
UNION
SELECT 3 id,'Wed' name 
UNION
SELECT 4 id,'Thur' name 
UNION
SELECT 5 id,'Fri' name 
UNION
SELECT 6 id,'Sat' name 
UNION
SELECT 7 id,'Sun' name 
order by id        
END
GO

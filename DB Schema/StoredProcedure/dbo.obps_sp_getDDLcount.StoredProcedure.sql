USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getDDLcount]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[obps_sp_getDDLcount]      
@username nvarchar(MAX)='',      
@linkid nvarchar(MAX)=''      
AS      
BEGIN      
DECLARE @ddl1sp nvarchar(MAX)=''      
DECLARE @ddl2sp nvarchar(MAX)=''      
DECLARE @ddl3sp nvarchar(MAX)=''      
      
select Ddl1Sp,Ddl2Sp,ddl3sp,ddl1text,ddl2text,ddl3text from obps_MobileConfig where Linkid=@linkid      
      
END 
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ReadRecalculateSp]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_ReadRecalculateSp]      
@usrname nvarchar(MAX)=''      
AS      
BEGIN      
DECLARE @spname nvarchar(MAX)=''      
      
set @spname=(select value from obps_globalconfig where variables='RecalculateSp')      
      
if(len(@spname)>0)      
 exec @spname @usrname      
      
END 
GO

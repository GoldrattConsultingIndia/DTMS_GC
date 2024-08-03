USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_Sp_ReadSchedulerData]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[obps_Sp_ReadSchedulerData]      
@linkid nvarchar(3)='',      
@username nvarchar(MAX)=''      
AS      
BEGIN      
      
DECLARE @spname nvarchar(MAX)=''      
      
set @spname=(select gridsp from obps_TopLinkExtended where id=@linkid)       
      
if len(@spname)>0      
begin      
--select @spname,@username         
exec @spname @username      
      
end      
      
      
END
GO

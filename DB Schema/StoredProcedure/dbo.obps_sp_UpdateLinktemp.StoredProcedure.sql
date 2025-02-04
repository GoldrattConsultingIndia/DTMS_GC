USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_UpdateLinktemp]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[obps_sp_UpdateLinktemp]  
@menuid int='',  
@linkname nvarchar(MAX)='',  
@gid int='',  
@gridsp nvarchar(MAX)='',  
@gridtable nvarchar(MAX)='',  
@topid int='',  
@topExtndid int=''  
AS  
BEGIN  
  
update obps_TopLinks_temp set MenuId=@menuid,LinkName=@linkname where id=@topid  
  
update obps_TopLinkExtended_temp set GridId=@gid,GridSp=@gridsp,GridTable=@gridtable  
where id=@topExtndid  
  
END
GO

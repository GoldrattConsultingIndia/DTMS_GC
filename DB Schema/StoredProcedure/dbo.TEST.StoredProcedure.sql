USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[TEST]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TEST] @Gridname1 NVARCHAR(MAX)=NULL, @str1 nvarchar(MAX)=NULL, @key1 nvarchar(50)=NULL, @LinkId1 NVARCHAR(MAX)=NULL, @usr1 nvarchar(MAX)='' AS BEGIN exec obps_sp_UpdateGridDataDetails @Gridname=@Gridname1,@str=@str1,@key=@key1,@LinkId=@LinkId1,@usr=@usr1 END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_ResetPassword]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[obps_sp_ResetPassword]
@userid int=''
,@password nvarchar(MAX)=''
AS
BEGIN

update obps_Users set IsResetPassword=1,Password=@password where id=@userid
select 'Data Updated'


END
GO

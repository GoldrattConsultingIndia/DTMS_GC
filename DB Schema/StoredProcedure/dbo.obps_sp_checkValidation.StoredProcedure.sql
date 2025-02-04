USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_checkValidation]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[obps_sp_checkValidation]
@gid nvarchar(5)=''
,@linkid nvarchar(5)=''
,@usrname nvarchar(200)=''
,@colname nvarchar(200)=''
,@colvalue nvarchar(200)=''
AS
BEGIN
DECLARE @validationsp nvarchar(50)
if(@linkid=201 and @gid=2)
BEGIN
	if(LOWER(@colname)='fromdate__obp_gms_deactivationpolicy' )
	begin
		if(CONVERT(DATETIME, SUBSTRING(@colvalue, 5, 20), 9)<GETDATE())
			select '0','From date should be greater than today'
	end	
	else if(LOWER(@colname)='todate__obp_gms_deactivationpolicy' )
	begin
		if(CONVERT(DATETIME, SUBSTRING(@colvalue, 5, 20), 9)<GETDATE())
			select '0','To date should be greater than today'
	end	
	else
		select '1'
		
END
else
begin

 set @validationsp=(select ValidationSp from obps_TopLinkExtended where Linkid=@linkid)
 if(len(@validationsp)>0)
	exec @validationsp @gid,@colname,@colvalue,@usrname
end
END

GO

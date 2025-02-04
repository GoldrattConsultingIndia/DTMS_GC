USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_gms_UpdateCalendarDates]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_gms_UpdateCalendarDates]
@linkid nvarchar(MAX)='',
@username nvarchar(MAX)='',
@dateval nvarchar(MAX)='',
@loc nvarchar(25)=''
AS
BEGIN

DECLARE @tablename nvarchar(MAX),@count int=0,
@month nvarchar(20)='',@newday nvarchar(20)=''
set @tablename=(select top 1 gridtable from obps_TopLinkExtended where Linkid=@linkid)
	WHILE LEN(@dateval) > 0
	BEGIN
		DECLARE @TDay VARCHAR(100)
		IF CHARINDEX(',',@dateval) > 0
		--BEGIN
			SET  @TDay = SUBSTRING(@dateval,0,CHARINDEX(',',@dateval))
			--delete from obp_gms_HolidayList
		--END
		ELSE
		BEGIN
			SET  @TDay = @dateval
			SET @dateval = ''
		 END
		 SET @month=(select SUBSTRING(@TDay, CHARINDEX('/', @TDay)+1, LEN(@TDay) -CHARINDEX('/', @TDay)-5))

		if(@month=0)
		BEGIN
			SET @newday=(select SUBSTRING(@TDay, 0,CHARINDEX('/', @TDay))+'/12/'+
						(select SUBSTRING(@TDay, CHARINDEX('/', @TDay)+3, LEN(@TDay) -CHARINDEX('/', @TDay))))
			SET @TDay=@newday
		END

		 set @count =(select count(*) from obp_gms_HolidayList where date=CONVERT(NVARCHAR(255),CONVERT(date, @TDay,105)))
		 if(@count<=0)
		 BEGIN
			
			INSERT INTO obp_gms_HolidayList
			(date) values(CONVERT(NVARCHAR(255),CONVERT(date, @TDay,105)))
		 end
			SET @dateval = REPLACE(@dateval,@TDay + ',' , '')
	END
END
GO

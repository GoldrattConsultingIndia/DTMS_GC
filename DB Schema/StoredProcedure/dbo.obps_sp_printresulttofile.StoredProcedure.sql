USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_printresulttofile]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obps_sp_printresulttofile]
AS
BEGIN
    DECLARE @var NVARCHAR(MAX) = ''
    SET @var = 'print this data in txt file'
    PRINT 'Data is : ' + @var   

    declare @fn varchar(200) = 'c:\out.txt';

    declare @cmd varchar(8000) = concat('echo ', @var, ' > "', @fn, '"');

    print @cmd 
    exec xp_cmdshell @cmd,  no_output

    set @cmd  = concat('type "', @fn, '"');

    print @cmd 
    exec xp_cmdshell @cmd;


END
GO

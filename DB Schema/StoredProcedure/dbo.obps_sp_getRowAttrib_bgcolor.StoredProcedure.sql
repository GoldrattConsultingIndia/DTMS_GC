USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getRowAttrib_bgcolor]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getRowAttrib_bgcolor]
--declare
@Gridname NVARCHAR(MAX)=NULL,
@colname NVARCHAR(MAX)=NULL,
@LinkId NVARCHAR(MAX)=NULL,
@Id NVARCHAR(MAX) =NULL
AS
BEGIN
	   DECLARE @query NVARCHAR(MAX),
	   @query_colorid NVARCHAR(MAX),
	   @tabname NVARCHAR(MAX),
	   @cid NVARCHAR(MAX),
	   @spquery NVARCHAR(MAX) ,
	   @spname NVARCHAR(MAX),
	   @query_color NVARCHAR(MAX),
	   @colorname NVARCHAR(MAX),
	   @MappedColmn nvarchar(MAX),
	   @colname_new nvarchar(MAX),
	   @indx int

    SET NOCOUNT ON;
 
	SET @indx=(select CHARINDEX ('__',@colname,0 ))
	SET @colname_new=(SELECT SUBSTRING(@colname, 1, @indx-1))
	set @tabname=(SELECT SUBSTRING(@colname, @indx+2,LEN(@colname)))

	set @MappedColmn=(select MappedCol from obps_RowAttrib where TableName=@tabname and colname=@colname_new and MappedCol like '%_color')

	--SET @query_colorid=('select id,'+@MappedColmn+' from '+@tabname+' where '+@MappedColmn+' is not null and '+@MappedColmn+'!='' ''')
	--EXEC Sp_executesql @query_colorid

	set  @query_colorid=('select th.id,Hexcode from '+@tabname+' th inner join obps_colorpicker clr on '+@MappedColmn+'=clr.ColorID  where th.id='+@Id+' and '+@MappedColmn+' is not null and ColorID is not null and '+@MappedColmn+'!='' ''')
	EXEC Sp_executesql @query_colorid

END
GO

USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[ReadRemarks]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ReadRemarks]     
@UserName NVARCHAR(MAX)= '',      
@selectedid nvarchar(MAX)=''     
AS     
BEGIN     
Declare @var_MID nvarchar(max)     
declare @rem nvarchar(max)=''
    
Set @var_MID=@selectedid       
    
set @rem='Select CONVERT(Char(16), min(RecordDate) ,20) ''Update Date'',isnull(th_Remarks,'''') ''RemarksHistory for #'+@var_MID+''' from obp_TaskHeader_Trace where th_Remarks is not null  and id='+@var_MID+'   
group by th_Remarks  order by  [Update Date] desc '
exec (@rem)
    
--Select Concat('[',CONVERT(VARCHAR, min(RecordDate), 120),'] - ',isnull(th_Remarks,'')) 'RemarksHistory' from obp_TaskHeader_Trace where th_Remarks is not null  and id=@var_MID    
--group by th_Remarks  order by RemarksHistory desc     
END
GO

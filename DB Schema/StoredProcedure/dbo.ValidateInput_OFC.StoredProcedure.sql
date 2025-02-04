USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[ValidateInput_OFC]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ValidateInput_OFC] 
AS
BEGIN
   declare  @Year INT,
    @Month INT,
    @Day INT,
    @SKU VARCHAR(50),
    @Plant VARCHAR(10),
	@count int,
	@i int=0,
	@rn int,
	@d int 
	,@l int=0

	while(@count>=@i)
	begin
	    declare @remark nvarchar(max)='Please Correct ',@k int =0
		if(@l=0)
		begin
		    set @d=100
			set @l=@l+2
        end
		select @Year=Due_YYYY,@Month=Due_MM,@Day=Due_DD,@Plant=Plant,@SKU=SKUCode,@rn=ID from [dbo].[obp_OFC_Demand_temp]
		where ID=@d+@i

			IF LEN(@Year) <> 4 
			BEGIN
               
			   set @remark=@remark+' Year,'	
			   set @k=1;
			END
    
			-- Check Month
			IF @Month < 1 OR @Month > 12
			BEGIN
				 set @remark=@remark+' Month,'	
				 set @k=1;
			END
    
			-- Check Day
			IF @Day < 1 OR @Day > 31
			BEGIN
				 set @remark=@remark+' Day should be between 1 and 31,'
				set @k=1;
			END
    
			
			IF NOT EXISTS (SELECT 1 from  Onebeat_Finolex.dbo.Symphony_StockLocations  sl                     
							left join Onebeat_Finolex.dbo.Symphony_StockLocationSkus as sls on sls.stockLocationID=sl.stockLocationID 
							WHERE sls.locationSkuName   = @SKU and sl.stockLocationName=@Plant)
			BEGIN
				set @remark=@remark+' SKU is not registered in MTS SKUs,'
				set @k=1;
			END
    
			-- Check Plant
			IF @Plant <> 'GOFC' 
			BEGIN
				set @remark=@remark+' Plant should be GOFC.'
				set @k=1;
			END
         
		 if(@k=1)
		 begin
		     update obp_OFC_Demand_temp set IsValid=0,remark=@remark where ID=@rn
			 set @k=0
		 end
			
			set @i=@i+1
		  end  
END
GO

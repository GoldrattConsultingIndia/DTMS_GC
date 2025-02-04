USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_largeorder]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[obps_largeorder]
(
@var_user nvarchar(100)=''                                   
,@var_pid int=''                                   
,@var_clientid int=''   
)
as
BEGIN
    -- Update/insert data in obp_largeOrders based on the inserted data in obp_largeOrders_temp

   MERGE INTO obp_largeOrders AS target
USING obp_largeOrders_temp AS source
ON target.Sono = source.Sono AND target.Sku = source.Sku
WHEN MATCHED THEN
    UPDATE SET
        target.SalesOffice = source.SalesOffice,
        target.CrtDt = source.CrtDt,
        target.SkuDesc = source.SkuDesc,
        target.CustomerCode = source.CustomerCode,
        target.CustomerName = source.CustomerName,
        target.SOqty = source.SOqty,
        target.SoUoM = source.SoUoM,
        target.OpenQty = source.OpenQty,
        target.CableType = source.CableType,
        target.IsValid = source.IsValid,
        target.UpdateDate = source.UpdateDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        SalesOffice, SoNo, CrtDt, Sku, SkuDesc,
        CustomerCode, CustomerName, SOqty, SoUoM,
        OpenQty, CableType, IsValid, UpdateDate
    )
    VALUES (
        source.SalesOffice, source.SoNo, source.CrtDt, source.Sku, source.SkuDesc,
        source.CustomerCode, source.CustomerName, source.SOqty, source.SoUoM,
        source.OpenQty, source.CableType,'1', source.UpdateDate
    );

END;
GO

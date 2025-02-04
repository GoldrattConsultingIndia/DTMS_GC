USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[sp_postLNR]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_postLNR]
as
insert into Onebeat_Finolex.[dbo].[oba_error_log] values('Post LNR ',getdate(),'Post LNR')
  drop table if exists #prodhistroyNew                
 select  h.Plant,Sku,SkuDesc ,[Black(Kms)],[Red(Kms)] ,updatedate                
  as updatedate,CableType ,QtyKms as [Actual Production]               
   into #prodhistroyNew                
  from obp_ProdReplHistory as h 
  left join 
  (Select sl.stockLocationName Plant,s.locationskuname Sku        
  ,convert(float,sum(t.quantity)) QtyKms        
  ,sum(case when s.Custom_num1>0 then t.quantity*1000/(convert(float,s.custom_num1)) end) Qtycoils        
  ,convert(date,getdate()-1) ReportedDate  
  from [Onebeat_Finolex].dbo.Symphony_transactions t        
  join [Onebeat_Finolex].dbo.Symphony_StockLocations sl on sl.stocklocationid=t.receiver        
  join [Onebeat_Finolex].dbo.Symphony_stocklocationskus s on s.stockLocationID=t.receiver and t.skuid=s.skuid        
  where reportedDate = convert(date,getdate()-1) and transactionType=1 and receiver in (22,26,30,31)        
  group by sl.stockLocationName,s.locationSkuName        
  )        
  as t on t.Sku=h.Material and t.Plant=h.Plant        
   where  convert(date,h.Updatedate)=convert(date,getdate()-1)
 
    
  drop table if exists #prodhistroy                
  select  m.Plant, sum([Black(Kms)] ) as Black,sum([Red(Kms)]) as Red ,m.updatedate                
  as updatedate,m.CableType ,sum([Actual Production])  as [Actual Production]  
  ,l.BlackCount,R.RedCount  
  into #prodhistroy              
  from #prodhistroyNew as m  
  left  join   
  (select Plant,CableType,Updatedate,count([Black(Kms)]) as BlackCount
  from  #prodhistroyNew   where  [Black(Kms)]!=0  and  
  convert(nvarchar(10),updatedate,103)=convert(nvarchar(10),(GETDATE()-1),103)                
  group by plant,CableType,Updatedate)
  as l  
  on m.Plant=l.Plant and m.CableType=l.CableType and m.updatedate=l.updatedate  
  left join   
  (select Plant,CableType,Updatedate ,Count([Red(Kms)]) as RedCount from  #prodhistroyNew   where     
  [Red(Kms)]!=0    and   
  convert(nvarchar(10),updatedate,103)=convert(nvarchar(10),(GETDATE()-1),103)                
  group by plant,CableType,Updatedate) 
  as R  
  on R.Plant=m.Plant and r.CableType=m.CableType and r.updatedate=m.updatedate  
  where convert(nvarchar(10),m.updatedate,103)=convert(nvarchar(10),(GETDATE()-1),103)                
  group by m.plant,m.CableType,m.Updatedate,BlackCount,RedCount                   
  order by CableType  
     
 --select plant,Cabletype,Black,Red,UpdateDate,cast([Actual Production] as float),BlackCount,RedCount   from #prodhistroy   
 INSERT into obp_ProdReplPlantwiseHistory(plant,Cabletype,Black,Red,UpdateDate,[ActualProduction] ,[Sku's Black Count] ,[Sku's Count])               
 select  plant,Cabletype,Black,Red,UpdateDate,cast([Actual Production] as float),BlackCount,RedCount    from #prodhistroy   
   
              
   insert into obp_productionreplpoogihistory(Cabletype,Plant,Sku,updateddate,isActive,color,SkuDescription,ActualProduction,skurepl)     
  select CableType,Plant,Sku,updatedate,1,'Black',SkuDesc,[Actual Production],[Black(Kms)] from #prodhistroyNew where    [Black(Kms)]!=0  and  
  convert(nvarchar(10),updatedate,103)=convert(nvarchar(10),(GETDATE()-1),103)  
    insert into obp_productionreplpoogihistory(Cabletype,Plant,Sku,updateddate,isActive,color,SkuDescription,ActualProduction,skurepl)     
  select CableType,Plant,Sku,updatedate,1,'Red',SkuDesc,[Actual Production],[Red(Kms)] from #prodhistroyNew where    [Red(Kms)]!=0  and  
  convert(nvarchar(10),updatedate,103)=convert(nvarchar(10),(GETDATE()-1),103)                
 insert into obp_productionreplpoogihistory(Cabletype,Plant,Sku,updateddate,isActive,color,SkuDescription,ActualProduction,skurepl) 
 select CableType,Plant,Sku,(GETDATE()-1),1,'Cyan',skudesc,QtyKms,0 from [obp_Finolex].[dbo].[obp_PrdnReplCyan]  



 
GO

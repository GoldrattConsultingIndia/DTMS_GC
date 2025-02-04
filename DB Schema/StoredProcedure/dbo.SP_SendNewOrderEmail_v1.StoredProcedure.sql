USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[SP_SendNewOrderEmail_v1]    Script Date: 2024-04-27 8:03:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_SendNewOrderEmail_v1]  
as  
Begin  
--truncate table tb_NewOrdersEmail  
  
--/*Populate the tb_NewOrdersEmail with valid records*/  
--insert into tb_NewOrdersEmail   
--Select Distributor,DealerName,DemandNo,MaterialDescription,Quantity  
--,case when ModifiedDate is null then cast(createddate as date) else cast(ModifiedDate as date) end  
--,'bharat.sharma@goldrattgroup.com',0  
--from obp_DemandEntry where DemandNo in ('10012','D-502446-3')  
  
/*Count No of Distributors*/  
Declare @var_cntdist int,@var_dist nvarchar(200),@var_email nvarchar(200)  
  
set @var_cntdist=(select count(distinct DealerName) from tb_NewOrdersEmail)  
  
While @var_cntdist<>0  
 Begin  
 set @var_dist=(select top 1 Distributor from tb_NewOrdersEmail where ind01=0)  
 set @var_email=(select top 1 Email from tb_NewOrdersEmail where Distributor=@var_dist and ind01=0)  
  
 exec obp_NewOrdersEmail @var_email,@var_dist  
  
 update tb_NewOrdersEmail set ind01=1 where Distributor=@var_dist  
 set @var_cntdist=@var_cntdist-1  
 End  
  
End  
GO

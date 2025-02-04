USE [obp_dtms]
GO
/****** Object:  StoredProcedure [dbo].[obps_sp_getgridProperties]    Script Date: 2024-04-27 8:03:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obps_sp_getgridProperties]  
@linkid int='',
@gid int=''
AS  
BEGIN  
 if(@linkid<>'' and @gid<>'')  
 BEGIN  
   select TE.ID,M.DisplayName,T.linkname,TabId,TabText,TabType,GridId,GridSp,GridTable,AllowAdd,AllowEdit,AllowDelete,DeleteSp  
  ,AfterSaveSp,IsExport,AllowFilterRow,AllowheaderFilter,AllowColumnChooser,AllowGroupPanel,RefreshEnabled  
  ,RefreshSp,IsYellowBtn,YellowBtnSp,IsGreenBtn,GreenBtnSp,IsRedBtn,RedBtnSp,AllowPaging,IsFormEdit  
  ,DependentGrid,AllowHScrollBar,CustomContextMenuLinkId1,t1.LinkName 'm1linkname',m1.DisplayName 'm1menuname', CustomContextMenuLinkId2,  
  t2.LinkName 'm2linkname',m2.DisplayName 'm2menuname',CustomContextMenuLinkId3,t3.LinkName 'm3linkname',  
  m3.DisplayName 'm3menuname',CustomContextMenuTxt1 'm1txt',CustomContextMenuTxt2 'm2txt',CustomContextMenuTxt3 'm3txt'  
  from obps_TopLinkExtended TE   
   inner join obps_TopLinks T on T.id=TE.Linkid  
   inner join obps_MenuName M on M.MenuId=T.MenuId  
   left join  obps_TopLinks T1 on T1.id=TE.CustomContextMenuLinkId1  
   left join obps_MenuName M1 on M1.MenuId=T1.MenuId  
   left join  obps_TopLinks T2 on T2.id=TE.CustomContextMenuLinkId2  
   left join obps_MenuName M2 on M2.MenuId=T1.MenuId  
   left join  obps_TopLinks T3 on T3.id=TE.CustomContextMenuLinkId3  
   left join obps_MenuName M3 on M3.MenuId=T3.MenuId   
   where linkid=@linkid  and GridId=@gid
  
 END  
 ELSE if(@linkid<>'')  
 BEGIN  
   select TE.ID,M.DisplayName,T.linkname,TabId,TabText,TabType,GridId,GridSp,GridTable,AllowAdd,AllowEdit,AllowDelete,DeleteSp  
  ,AfterSaveSp,IsExport,AllowFilterRow,AllowheaderFilter,AllowColumnChooser,AllowGroupPanel,RefreshEnabled  
  ,RefreshSp,IsYellowBtn,YellowBtnSp,IsGreenBtn,GreenBtnSp,IsRedBtn,RedBtnSp,AllowPaging,IsFormEdit  
  ,DependentGrid,AllowHScrollBar,CustomContextMenuLinkId1,t1.LinkName 'm1linkname',m1.DisplayName 'm1menuname', CustomContextMenuLinkId2,  
  t2.LinkName 'm2linkname',m2.DisplayName 'm2menuname',CustomContextMenuLinkId3,t3.LinkName 'm3linkname',  
  m3.DisplayName 'm3menuname',CustomContextMenuTxt1 'm1txt',CustomContextMenuTxt2 'm2txt',CustomContextMenuTxt3 'm3txt'  
  from obps_TopLinkExtended TE   
   inner join obps_TopLinks T on T.id=TE.Linkid  
   inner join obps_MenuName M on M.MenuId=T.MenuId  
   left join  obps_TopLinks T1 on T1.id=TE.CustomContextMenuLinkId1  
   left join obps_MenuName M1 on M1.MenuId=T1.MenuId  
   left join  obps_TopLinks T2 on T2.id=TE.CustomContextMenuLinkId2  
   left join obps_MenuName M2 on M2.MenuId=T1.MenuId  
   left join  obps_TopLinks T3 on T3.id=TE.CustomContextMenuLinkId3  
   left join obps_MenuName M3 on M3.MenuId=T3.MenuId   
   where linkid=@linkid  
  
 END  
 ELSE  
 BEGIN  
   select TE.ID,M.DisplayName,T.linkname,TabId,TabText,TabType,GridId,GridSp,GridTable,AllowAdd,AllowEdit,AllowDelete,DeleteSp  
  ,AfterSaveSp,IsExport,AllowFilterRow,AllowheaderFilter,AllowColumnChooser,AllowGroupPanel,RefreshEnabled  
  ,RefreshSp,IsYellowBtn,YellowBtnSp,IsGreenBtn,GreenBtnSp,IsRedBtn,RedBtnSp,AllowPaging,IsFormEdit  
  ,DependentGrid,AllowHScrollBar,CustomContextMenuLinkId1,t1.LinkName 'm1linkname',m1.DisplayName 'm1menuname', CustomContextMenuLinkId2,  
  t2.LinkName 'm2linkname',m2.DisplayName 'm2menuname',CustomContextMenuLinkId3,t3.LinkName 'm3linkname',  
  m3.DisplayName 'm3menuname',CustomContextMenuTxt1 'm1txt',CustomContextMenuTxt2 'm2txt',CustomContextMenuTxt3 'm3txt'  
  from obps_TopLinkExtended TE   
   inner join obps_TopLinks T on T.id=TE.Linkid  
   inner join obps_MenuName M on M.MenuId=T.MenuId  
   left join  obps_TopLinks T1 on T1.id=TE.CustomContextMenuLinkId1  
   left join obps_MenuName M1 on M1.MenuId=T1.MenuId  
   left join  obps_TopLinks T2 on T2.id=TE.CustomContextMenuLinkId2  
   left join obps_MenuName M2 on M2.MenuId=T1.MenuId  
   left join  obps_TopLinks T3 on T3.id=TE.CustomContextMenuLinkId3  
   left join obps_MenuName M3 on M3.MenuId=T3.MenuId  
 END  
END
GO

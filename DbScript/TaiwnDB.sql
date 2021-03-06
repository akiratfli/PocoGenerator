USE [TaiwanDB]
GO
/****** Object:  Schema [comm]    Script Date: 2019/2/26 15:00:10 ******/
CREATE SCHEMA [comm]
GO
/****** Object:  Table [comm].[Ref_AddressCounty]    Script Date: 2019/2/26 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [comm].[Ref_AddressCounty](
	[ID] [varchar](20) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[Name2] [nvarchar](100) NULL,
	[EYID] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Ref_AddressCounty] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [comm].[Ref_AddressTown]    Script Date: 2019/2/26 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [comm].[Ref_AddressTown](
	[ID] [varchar](20) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[NameEng] [nvarchar](150) NULL,
	[AddressCountyID] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Ref_AddressTown] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [comm].[Ref_AddressVillage]    Script Date: 2019/2/26 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [comm].[Ref_AddressVillage](
	[ID] [varchar](20) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[AddressTownID] [varchar](20) NOT NULL,
	[AddressCountyID] [varchar](20) NOT NULL,
	[EYVillageCode] [varchar](15) NULL,
	[EYVillageSerialNum] [char](3) NULL,
	[TMIVillageCode] [varchar](15) NULL,
	[MOHWName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Ref_AddressVillage] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [comm].[S1#del]    Script Date: 2019/2/26 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [comm].[S1#del](
	[ID] [varchar](20) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[NameEng] [nvarchar](150) NULL,
	[AddressCountyID] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_AddressCity]    Script Date: 2019/2/26 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_AddressCity](
	[AddressCityID] [smallint] NOT NULL,
	[AddressCityName] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_Ref_AddressCity] PRIMARY KEY CLUSTERED 
(
	[AddressCityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Ref_AddressTaiwan]    Script Date: 2019/2/26 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Ref_AddressTaiwan]
AS
SELECT          c.ID AS CountyID, c.Name AS CountyName,c.Name2 AS CountyName2, b.ID AS TownID, b.Name AS TownName, a.ID AS VillageID, 
                            a.Name AS VillageName,a.MOHWName AS VillageName2
FROM              comm.Ref_AddressVillage AS a INNER JOIN
                            comm.Ref_AddressTown AS b ON b.ID = a.AddressTownID INNER JOIN
                            comm.Ref_AddressCounty AS c ON c.ID = a.AddressCountyID
GO
ALTER TABLE [comm].[Ref_AddressTown]  WITH CHECK ADD  CONSTRAINT [FK_Ref_AddressTown_Ref_AddressCounty] FOREIGN KEY([AddressCountyID])
REFERENCES [comm].[Ref_AddressCounty] ([ID])
GO
ALTER TABLE [comm].[Ref_AddressTown] CHECK CONSTRAINT [FK_Ref_AddressTown_Ref_AddressCounty]
GO
ALTER TABLE [comm].[Ref_AddressVillage]  WITH CHECK ADD  CONSTRAINT [FK_Ref_AddressVillage_Ref_AddressCounty] FOREIGN KEY([AddressCountyID])
REFERENCES [comm].[Ref_AddressCounty] ([ID])
GO
ALTER TABLE [comm].[Ref_AddressVillage] CHECK CONSTRAINT [FK_Ref_AddressVillage_Ref_AddressCounty]
GO
ALTER TABLE [comm].[Ref_AddressVillage]  WITH CHECK ADD  CONSTRAINT [FK_Ref_AddressVillage_Ref_AddressTown] FOREIGN KEY([AddressTownID])
REFERENCES [comm].[Ref_AddressTown] ([ID])
GO
ALTER TABLE [comm].[Ref_AddressVillage] CHECK CONSTRAINT [FK_Ref_AddressVillage_Ref_AddressTown]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行政院_地址縣市名稱' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressCounty', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'候選_地址縣市名稱' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressCounty', @level2type=N'COLUMN',@level2name=N'Name2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行政院_地址縣市代碼' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressCounty', @level2type=N'COLUMN',@level2name=N'EYID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址縣市' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressCounty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TOWNCODE' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressTown', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'鄉鎮市區' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressTown'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'村里編碼(依行政院村里編號去除減號)' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressVillage', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行政院_村里名稱' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressVillage', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行政院_村里代碼' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressVillage', @level2type=N'COLUMN',@level2name=N'EYVillageCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行政院_村里序列號' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressVillage', @level2type=N'COLUMN',@level2name=N'EYVillageSerialNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'內政部_村里代碼' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressVillage', @level2type=N'COLUMN',@level2name=N'TMIVillageCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'衛福部_村里名稱' , @level0type=N'SCHEMA',@level0name=N'comm', @level1type=N'TABLE',@level1name=N'Ref_AddressVillage', @level2type=N'COLUMN',@level2name=N'MOHWName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址縣市代碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ref_AddressCity', @level2type=N'COLUMN',@level2name=N'AddressCityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址縣市名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ref_AddressCity', @level2type=N'COLUMN',@level2name=N'AddressCityName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址縣市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ref_AddressCity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 33
               Left = 72
               Bottom = 163
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 13
               Left = 415
               Bottom = 143
               Right = 601
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 158
               Left = 422
               Bottom = 271
               Right = 587
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Ref_AddressTaiwan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Ref_AddressTaiwan'
GO

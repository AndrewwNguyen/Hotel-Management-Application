USE [master]
GO
/****** Object:  Database [KS7]    Script Date: 5/24/2022 4:17:02 PM ******/
CREATE DATABASE [KS7]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KS7', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\KS7.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KS7_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\KS7_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [KS7] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KS7].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KS7] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KS7] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KS7] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KS7] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KS7] SET ARITHABORT OFF 
GO
ALTER DATABASE [KS7] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KS7] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KS7] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KS7] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KS7] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KS7] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KS7] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KS7] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KS7] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KS7] SET  ENABLE_BROKER 
GO
ALTER DATABASE [KS7] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KS7] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KS7] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KS7] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KS7] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KS7] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KS7] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KS7] SET RECOVERY FULL 
GO
ALTER DATABASE [KS7] SET  MULTI_USER 
GO
ALTER DATABASE [KS7] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KS7] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KS7] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KS7] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KS7] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [KS7] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'KS7', N'ON'
GO
ALTER DATABASE [KS7] SET QUERY_STORE = OFF
GO
USE [KS7]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[ID] [int] NOT NULL,
	[IDCard] [nvarchar](100) NOT NULL,
	[IDCustomerType] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[PhoneNumber] [int] NOT NULL,
	[Sex] [nvarchar](100) NOT NULL,
	[Nationality] [nvarchar](100) NOT NULL,
	[Host] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[F_KH]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[F_KH](@gt nvarchar(60))
returns table
as return
select COUNT(id) as N'so NV' from Customer where Sex = (case when @gt = N'Nam' then 1 else 0 end)

GO
/****** Object:  UserDefinedFunction [dbo].[F_KH1]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[F_KH1](@gt nvarchar(60))
returns table
as return
select COUNT(ID) as N'so NV' from Customer where Sex = @gt
GO
/****** Object:  Table [dbo].[Room]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IDRoomType] [int] NOT NULL,
	[IDStatusRoom] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomType](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Price] [int] NOT NULL,
	[LimitPerson] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ht]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ht](@idroomtype nvarchar(60))
returns table
as return
select Room.Name from Room join RoomType on Room.IDRoomType = RoomType.id where RoomType.id = @idroomtype
GO
/****** Object:  Table [dbo].[ACCESS]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCESS](
	[IDStaffType] [int] NOT NULL,
	[IDJob] [int] NOT NULL,
 CONSTRAINT [PK_Access] PRIMARY KEY CLUSTERED 
(
	[IDStaffType] ASC,
	[IDJob] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[ID] [int] NOT NULL,
	[IDReceiveRoom] [int] NOT NULL,
	[StaffSetUp] [nvarchar](100) NOT NULL,
	[DateOfCreate] [smalldatetime] NULL,
	[RoomPrice] [int] NOT NULL,
	[ServicePrice] [int] NOT NULL,
	[TotalPrice] [int] NOT NULL,
	[Discount] [int] NOT NULL,
	[IDStatusBill] [int] NOT NULL,
	[Surcharge] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillDetails]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillDetails](
	[IDBill] [int] NOT NULL,
	[IDService] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[TotalPrice] [int] NOT NULL,
 CONSTRAINT [PK_BillInfo] PRIMARY KEY CLUSTERED 
(
	[IDService] ASC,
	[IDBill] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookRoom]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookRoom](
	[ID] [int] NOT NULL,
	[IDCustomer] [int] NOT NULL,
	[IDRoomType] [int] NOT NULL,
	[DateBookRoom] [smalldatetime] NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NOT NULL,
	[Days] [int] NOT NULL,
	[Checked] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerType]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerType](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JOB]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JOB](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[NameForm] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parameter]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parameter](
	[Name] [nvarchar](100) NOT NULL,
	[Value] [float] NULL,
	[Describe] [nvarchar](200) NULL,
	[DateModify] [smalldatetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceiveRoom]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiveRoom](
	[ID] [int] NOT NULL,
	[IDBookRoom] [int] NOT NULL,
	[IDRoom] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceiveRoomDetails]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiveRoomDetails](
	[IDReceiveRoom] [int] NOT NULL,
	[IDCustomerOther] [int] NOT NULL,
 CONSTRAINT [PK_ReceiveRoomDetails] PRIMARY KEY CLUSTERED 
(
	[IDReceiveRoom] ASC,
	[IDCustomerOther] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REPORT]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPORT](
	[idRoomType] [int] NOT NULL,
	[value] [int] NOT NULL,
	[rate] [float] NOT NULL,
	[Month] [int] NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[idRoomType] ASC,
	[Month] ASC,
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[IDServiceType] [int] NOT NULL,
	[Price] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceType]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceType](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](100) NOT NULL,
	[IDStaffType] [int] NOT NULL,
	[IDCard] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Sex] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[PhoneNumber] [int] NOT NULL,
	[StartDay] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StaffType]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffType](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusBill]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusBill](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusRoom]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusRoom](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 1)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 2)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 3)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 4)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 5)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 6)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 7)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 8)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 9)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 10)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (2, 1)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (2, 3)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (2, 4)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (2, 6)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (2, 7)
GO
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (1274, 2059, N'Admin1', CAST(N'2021-11-28T09:28:00' AS SmallDateTime), 4000000, 1100000, 5100000, 0, 2, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (1937, 1937, N'Admin1', CAST(N'2021-11-27T01:19:00' AS SmallDateTime), 4000000, 250000, 4250000, 0, 2, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (2145, 7915, N'Admin1', CAST(N'2021-11-28T04:27:00' AS SmallDateTime), 10000000, 1350000, 11350000, 0, 2, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3026, 5567, N'Admin1', CAST(N'2021-11-28T02:17:00' AS SmallDateTime), 1000000, 200000, 1200000, 0, 2, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (4132, 9902, N'Admin1', CAST(N'2021-11-28T02:25:00' AS SmallDateTime), 10000000, 0, 12500000, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (4210, 5683, N'Admin1', CAST(N'2021-11-28T02:18:00' AS SmallDateTime), 10000000, 0, 12500000, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (5135, 1906, N'Admin1', CAST(N'2021-11-28T23:04:00' AS SmallDateTime), 10000000, 2200000, 12200000, 0, 2, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (6324, 3095, N'Admin1', CAST(N'2021-11-27T01:20:00' AS SmallDateTime), 7000000, 200000, 7200000, 0, 2, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (8033, 6277, N'Admin1', CAST(N'2021-11-28T08:14:00' AS SmallDateTime), 7000000, 0, 9500000, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (8532, 1006, N'Admin1', CAST(N'2021-11-28T03:36:00' AS SmallDateTime), 10000000, 0, 12500000, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (8860, 5631, N'Admin1', CAST(N'2021-11-28T04:26:00' AS SmallDateTime), 7000000, 0, 9500000, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (8981, 7224, N'Admin1', CAST(N'2021-11-28T04:24:00' AS SmallDateTime), 10000000, 0, 12500000, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (9082, 5853, N'Admin1', CAST(N'2021-11-28T04:26:00' AS SmallDateTime), 4000000, 0, 6500000, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (9430, 3473, N'Admin1', CAST(N'2022-05-24T03:05:00' AS SmallDateTime), 10000000, 0, 12500000, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (9434, 2976, N'Admin1', CAST(N'2022-05-24T03:06:00' AS SmallDateTime), 10000000, 650000, 10650000, 0, 2, 2500000)
GO
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (1274, 1, 1, 1000000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (2145, 1, 1, 1000000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (1274, 2, 1, 100000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (1937, 3, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (2145, 3, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3026, 3, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (5135, 3, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (6324, 3, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (9430, 3, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (2145, 6, 1, 150000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (9082, 6, 1, 150000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (9434, 6, 1, 150000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (9434, 9, 1, 500000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (9430, 15, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (5135, 16, 1, 2000000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (1937, 17, 1, 50000)
GO
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (1002, 8186, 1, CAST(N'2021-11-28T04:20:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (1012, 6356, 3, CAST(N'2021-11-28T04:26:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (1118, 6356, 1, CAST(N'2021-11-28T02:18:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (1211, 8432, 1, CAST(N'2021-11-28T04:25:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (1609, 8432, 3, CAST(N'2021-11-28T08:10:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (1640, 8186, 1, CAST(N'2021-11-28T03:37:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (1981, 8432, 1, CAST(N'2021-11-28T02:25:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (2245, 8432, 1, CAST(N'2021-11-28T04:25:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (2708, 8186, 1, CAST(N'2021-11-27T01:18:00' AS SmallDateTime), CAST(N'2021-11-27' AS Date), CAST(N'2021-11-28' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (2828, 8186, 1, CAST(N'2021-12-02T03:40:00' AS SmallDateTime), CAST(N'2021-12-02' AS Date), CAST(N'2021-12-24' AS Date), 22, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (3041, 1782, 1, CAST(N'2021-11-28T04:24:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (3121, 8432, 1, CAST(N'2021-11-28T04:24:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (3527, 8186, 4, CAST(N'2021-11-28T09:25:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (4478, 8186, 1, CAST(N'2021-11-28T03:41:00' AS SmallDateTime), CAST(N'2021-12-09' AS Date), CAST(N'2021-12-11' AS Date), 2, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (4716, 8186, 1, CAST(N'2022-05-24T03:03:00' AS SmallDateTime), CAST(N'2022-05-24' AS Date), CAST(N'2022-05-25' AS Date), 1, N'Chua nh?n phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (4936, 8186, 3, CAST(N'2021-11-28T08:04:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (5104, 8186, 3, CAST(N'2021-11-27T01:18:00' AS SmallDateTime), CAST(N'2021-11-27' AS Date), CAST(N'2021-11-28' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (5468, 8186, 1, CAST(N'2021-12-02T03:40:00' AS SmallDateTime), CAST(N'2021-12-02' AS Date), CAST(N'2021-12-24' AS Date), 22, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (5499, 8186, 1, CAST(N'2021-11-28T08:07:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (6345, 8186, 3, CAST(N'2021-11-28T09:26:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (6496, 6356, 1, CAST(N'2021-11-28T08:08:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (7086, 8186, 1, CAST(N'2021-11-28T04:22:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (7269, 7269, 1, CAST(N'2022-05-24T03:05:00' AS SmallDateTime), CAST(N'2022-05-24' AS Date), CAST(N'2022-05-25' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (7273, 8186, 1, CAST(N'2021-12-02T03:40:00' AS SmallDateTime), CAST(N'2021-12-02' AS Date), CAST(N'2021-12-24' AS Date), 22, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (8541, 6356, 1, CAST(N'2021-11-28T03:36:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (8699, 8432, 1, CAST(N'2021-11-28T08:14:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (8780, 8432, 2, CAST(N'2021-11-28T04:26:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (9345, 6356, 2, CAST(N'2021-11-27T01:19:00' AS SmallDateTime), CAST(N'2021-11-27' AS Date), CAST(N'2021-11-28' AS Date), 1, N'Đã Nhận Phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (9454, 8186, 3, CAST(N'2021-11-28T23:03:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Chưa nhận phòng')
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut], [Days], [Checked]) VALUES (9864, 8186, 4, CAST(N'2021-11-28T02:17:00' AS SmallDateTime), CAST(N'2021-11-28' AS Date), CAST(N'2021-11-29' AS Date), 1, N'Đã Nhận Phòng')
GO
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (1, N'165220147', 1, N'Nguyễn Văn A', CAST(N'1998-04-06' AS Date), N'New York', 1648222347, N'Nam,', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (2, N'2026117926', 3, N'Nguyễn Nguyễn Văn B', CAST(N'1998-04-06' AS Date), N'Quảng Nam', 1648222347, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (4, N'1232456', 2, N'Khách Hàng 1', CAST(N'1998-04-06' AS Date), N'Hà Nội', 1648222347, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (5, N'127822389', 1, N'Khách Hàng 2', CAST(N'1998-04-06' AS Date), N'Đồng Nai', 12782389, N'Nữ', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (8, N'25623', 1, N'Khách Hàng 3', CAST(N'1998-04-06' AS Date), N'Hải Phòng', 147852, N'Nữ', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (9, N'1234256788', 1, N'Nguyễn Đức Bảo Sơn', CAST(N'1998-07-08' AS Date), N'Hà Nội', 123456789, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (10, N'1232456787', 1, N'Nguyễn Đức Nam', CAST(N'1998-04-06' AS Date), N'Hà nội', 123456785, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (11, N'272263950', 4, N'Đoàn Duy Anh', CAST(N'1998-06-06' AS Date), N'TP Hồ Chí Minh', 966144938, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (12, N'1452236', 1, N'Con gà', CAST(N'1998-04-06' AS Date), N'Thái Bình', 1655201124, N'Khác', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (13, N'968252361', 3, N'Con mèo', CAST(N'1998-04-06' AS Date), N'TP Hồ Chí Minh', 145230, N'Nữ', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (15, N'9623587', 3, N'Con Chó', CAST(N'1998-04-08' AS Date), N'Hà Nội', 164853564, N'Nữ', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (1134, N'1253452', 2, N'12312', CAST(N'1998-04-06' AS Date), N'1231', 123123, N'Nữ', N'Lào', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (1782, N'000', 1, N't', CAST(N'1998-04-06' AS Date), N'534', 4353, N'Nữ', N'Ytaly', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (3342, N'6565', 2, N'Quang Trung', CAST(N'1998-04-06' AS Date), N'12312', 123123123, N'Nam', N'Đức', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (6350, N'23', 2, N'23', CAST(N'1998-04-06' AS Date), N'23', 23, N'Nữ', N'Pháp', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (6356, N'00', 2, N'31', CAST(N'1998-04-06' AS Date), N'12', 23423, N'Nữ', N'Pháp', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (6872, N'123', 3, N'son', CAST(N'2001-02-20' AS Date), N'123', 123, N'Nam', N'Lào', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (7269, N'0396', 1, N'd', CAST(N'1998-04-06' AS Date), N'fff', 33, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (7824, N'31', 2, N'132', CAST(N'1998-04-06' AS Date), N'12', 12, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (8162, N'234', 2, N'14324', CAST(N'1998-04-06' AS Date), N'234', 23423, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (8186, N'123', 3, N'son', CAST(N'2001-02-20' AS Date), N'123', 123, N'Nam', N'Lào', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (8432, N'2001', 1, N'Nguyễn Đức Anh', CAST(N'1998-04-06' AS Date), N'Hà Nội', 123456789, N'Nam', N'Việt Nam', NULL)
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality], [Host]) VALUES (8991, N'123123', 2, N'31231', CAST(N'1998-04-06' AS Date), N'123', 1231, N'Nữ', N'Trung Quốc', NULL)
GO
INSERT [dbo].[CustomerType] ([ID], [Name]) VALUES (1, N'Khách du lịch')
INSERT [dbo].[CustomerType] ([ID], [Name]) VALUES (2, N'Khách vãng lai')
INSERT [dbo].[CustomerType] ([ID], [Name]) VALUES (3, N'Khách địa phương')
INSERT [dbo].[CustomerType] ([ID], [Name]) VALUES (4, N'Khách đi qua các tổ chức trung gian')
GO
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (1, N'Đặt Phòng', N'fBookRoom')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (2, N'Nhận Phòng', N'fReceiveRoom')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (3, N'Sử dụng dịch vụ và Thanh toán', N'fUseService')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (4, N'Thống kê và doanh thu', N'fReport')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (5, N'Quản lí phòng', N'fRoom')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (6, N'Quản lí nhân viên', N'fStaff')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (7, N'Quản lí khách hàng', N'fCustomer')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (8, N'Quản lí hoá đơn', N'fBill')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (9, N'Quản lí dịch vụ', N'fService')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (10, N'Quy định', N'fParameter')
GO
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ1.1', 9, N'Phòng Suite (SUT) có tối đa 9 người', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ1.2', 6, N'Phòng Deluxe (DLX) có tối đa 6 người', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ1.3', 4, N'Phòng Superior (SUP) có tối đa 4 người', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ1.4', 3, N'Phòng Standard (STD) có tối đa 3 người', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ2.1', 6, N'Đơn giá phòng cho 6 khách Phòng Suite (SUT)', CAST(N'2018-06-25T02:02:00' AS SmallDateTime))
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ2.2', 4, N'Đơn giá phòng cho 4 khách Phòng Deluxe (DLX)', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ2.3', 3, N'Đơn giá phòng cho 3 khách Phòng Superior (SUP)', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ2.4', 2, N'Đơn giá phòng cho 2 khách Phòng Phòng Standard (STD)', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ3', 0.25, N'Mỗi khách hàng vượt số lượng tiêu chuẩn phụ thu thêm 0.25', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ4', 1.5, N'Khách nước ngoài phụ thu 1.5', CAST(N'2018-06-24T18:29:00' AS SmallDateTime))
GO
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (1006, 8541, 17)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (1906, 3121, 1)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (1937, 5104, 11)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (2059, 6345, 9)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (2976, 2708, 17)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (3095, 9345, 12)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (3473, 7269, 17)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (5567, 9864, 20)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (5631, 8780, 18)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (5683, 1118, 17)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (5853, 1012, 24)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (6277, 8699, 2)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (7224, 3041, 17)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (7915, 1211, 5)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (9902, 1981, 17)
GO
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (1006, 6356)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (1906, 8432)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (1937, 8186)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (2059, 8186)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (2976, 8186)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (3095, 6356)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (3473, 7269)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (5567, 8186)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (5631, 8432)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (5683, 6356)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (5683, 6872)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (5853, 6356)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (6277, 8432)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (7224, 1782)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (7915, 8432)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (9902, 1134)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (9902, 8432)
GO
INSERT [dbo].[REPORT] ([idRoomType], [value], [rate], [Month], [Year]) VALUES (1, 60000000, 64.43, 6, 2018)
INSERT [dbo].[REPORT] ([idRoomType], [value], [rate], [Month], [Year]) VALUES (2, 0, 0, 6, 2018)
INSERT [dbo].[REPORT] ([idRoomType], [value], [rate], [Month], [Year]) VALUES (3, 8125000, 8.72, 6, 2018)
INSERT [dbo].[REPORT] ([idRoomType], [value], [rate], [Month], [Year]) VALUES (4, 25000000, 26.85, 6, 2018)
GO
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (1, N'Phòng 101', 1, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (2, N'Phòng 102', 2, 2)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (3, N'Phòng 103', 3, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (4, N'Phòng 104', 4, 2)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (5, N'Phòng 105', 1, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (6, N'Phòng 106', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (7, N'Phòng 107', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (8, N'Phòng 108', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (9, N'Phòng 109', 3, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (10, N'Phòng 201', 3, 2)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (11, N'Phòng 202', 3, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (12, N'Phòng 203', 2, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (13, N'Phòng 204', 2, 2)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (14, N'Phòng 205', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (15, N'Phòng 206', 3, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (16, N'Phòng 207', 2, 2)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (17, N'Phòng 208', 1, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (18, N'Phòng 209', 2, 2)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (19, N'Phòng 210', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (20, N'Phòng 211', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (24, N'Phòng 212', 3, 2)
GO
INSERT [dbo].[RoomType] ([ID], [Name], [Price], [LimitPerson]) VALUES (1, N'Phòng Suite (SUT)', 10000000, 6)
INSERT [dbo].[RoomType] ([ID], [Name], [Price], [LimitPerson]) VALUES (2, N'Phòng Deluxe (DLX)', 7000000, 4)
INSERT [dbo].[RoomType] ([ID], [Name], [Price], [LimitPerson]) VALUES (3, N'Phòng Superior (SUP)', 4000000, 3)
INSERT [dbo].[RoomType] ([ID], [Name], [Price], [LimitPerson]) VALUES (4, N'Phòng Standard (STD)', 1000000, 2)
GO
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (1, N'Spa', 2, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (2, N'Fitness', 2, 100000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (3, N'Tam dương trùng phùng với bông cải uyên ương', 1, 200000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (4, N'Karaoke', 2, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (6, N'Giặt ủi quần áo', 3, 150000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (8, N'Dịch vụ xe đưa đón sân bay', 3, 200000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (9, N'Dịch vụ cho thuê tự lái', 3, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (10, N'Dịch vụ trông trẻ', 3, 800000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (11, N'Bể bơi 4 mùa', 2, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (13, N'Sân tennis', 2, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (14, N'Mực khoanh chiên vàng & Gỏi bắp bò rau mùi với bánh tráng mè kiểu Thái & Phượng Hoàng tảo biển', 1, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (15, N'Súp nấm hải vị với gà và thịt cua', 1, 200000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (16, N'Heo sữa quay bánh bao nửa con', 1, 2000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (17, N'Chè bột báng trái cây kiểu Melaka', 1, 50000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (18, N'Gỏi bò Cung đình & Phượng hoàng tảo biển & Sườn heo nướng kiểu Hàn Quốc', 1, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (19, N'Súp kem bắp hải sản kiểu Pháp', 1, 150000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (20, N'Cơm chiên gà cá mặn kiểu Hongkong', 1, 75000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (21, N'Bánh tiramisu socola', 1, 50000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (22, N'Chivas 18', 4, 1800000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (23, N'Vodka 3 Zoka', 4, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (24, N'Chivas 12', 4, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (25, N'Cocktail Negroni', 4, 300000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (26, N'Cocktail Bellini', 4, 300000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (27, N'Cocktail The Bloody Mary', 4, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (28, N'Cocktail Old Fashioned', 4, 400000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (29, N'Lẩu dê', 1, 100000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (30, N'Vịt quay Bắc Kinh', 1, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (31, N'Lẩu hải sản', 1, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (32, N'Cháo vịt', 1, 200000)
GO
INSERT [dbo].[ServiceType] ([ID], [Name]) VALUES (1, N'Ăn uống')
INSERT [dbo].[ServiceType] ([ID], [Name]) VALUES (2, N'Giải trí')
INSERT [dbo].[ServiceType] ([ID], [Name]) VALUES (3, N'Tiện ích')
INSERT [dbo].[ServiceType] ([ID], [Name]) VALUES (4, N'Đồ uống')
GO
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'abcd', N'Nguyễn Văn A', N'1', 2, N'1234571345', CAST(N'1991-04-18' AS Date), N'Nam', N'Hà Nội', 123456895, CAST(N'2018-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'Admin', N'Nguyễn Đức Bảo Sơn', N'e10adc3949ba59abbe56e057f20f883e', 2, N'22', CAST(N'2001-04-18' AS Date), N'Nam', N'Hà Nội', 1234567890, CAST(N'2021-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'Admin1', N'Đoàn Duy Anh', N'e10adc3949ba59abbe56e057f20f883e', 1, N'22', CAST(N'2001-04-18' AS Date), N'Nam', N'Hà Nội', 1234567890, CAST(N'2021-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'Conga', N'Con Gà', N'1', 2, N'2061317926', CAST(N'1990-01-01' AS Date), N'Nữ', N'Hải Phòng', 1648222347, CAST(N'2018-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'gaugau', N'Gâu Gâu', N'1', 2, N'165321169', CAST(N'1990-01-01' AS Date), N'Nam', N'TP Hồ Chí Minh', 123456789, CAST(N'2018-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'meomeo', N'Đoàn Duy Anh', N'1', 2, N'12345371145', CAST(N'2001-04-18' AS Date), N'Nam', N'Hà Nội', 1234567890, CAST(N'2021-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'meomeo2', N'Meo Meo', N'1', 2, N'27312', CAST(N'1998-04-06' AS Date), N'Nam', N'Bắc Ninh', 123456789, CAST(N'2018-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'meoo', N'Đoàn Duy Anh', N'e10adc3949ba59abbe56e057f20f883e', 2, N'22', CAST(N'2001-04-18' AS Date), N'Nam', N'Hà Nội', 1234567890, CAST(N'2021-05-16' AS Date))
GO
INSERT [dbo].[StaffType] ([ID], [Name]) VALUES (1, N'Quản lí')
INSERT [dbo].[StaffType] ([ID], [Name]) VALUES (2, N'Lễ tân')
GO
INSERT [dbo].[StatusBill] ([ID], [Name]) VALUES (1, N'Chưa thanh toán')
INSERT [dbo].[StatusBill] ([ID], [Name]) VALUES (2, N'Đã thanh toán')
GO
INSERT [dbo].[StatusRoom] ([ID], [Name]) VALUES (1, N'Trống')
INSERT [dbo].[StatusRoom] ([ID], [Name]) VALUES (2, N'Có người')
GO
ALTER TABLE [dbo].[ACCESS]  WITH CHECK ADD FOREIGN KEY([IDJob])
REFERENCES [dbo].[JOB] ([ID])
GO
ALTER TABLE [dbo].[ACCESS]  WITH CHECK ADD FOREIGN KEY([IDStaffType])
REFERENCES [dbo].[StaffType] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([IDReceiveRoom])
REFERENCES [dbo].[ReceiveRoom] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([IDStatusBill])
REFERENCES [dbo].[StatusBill] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([StaffSetUp])
REFERENCES [dbo].[Staff] ([UserName])
GO
ALTER TABLE [dbo].[BillDetails]  WITH CHECK ADD FOREIGN KEY([IDBill])
REFERENCES [dbo].[Bill] ([ID])
GO
ALTER TABLE [dbo].[BillDetails]  WITH CHECK ADD FOREIGN KEY([IDService])
REFERENCES [dbo].[Service] ([ID])
GO
ALTER TABLE [dbo].[BookRoom]  WITH CHECK ADD FOREIGN KEY([IDRoomType])
REFERENCES [dbo].[RoomType] ([ID])
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD FOREIGN KEY([IDCustomerType])
REFERENCES [dbo].[CustomerType] ([ID])
GO
ALTER TABLE [dbo].[ReceiveRoom]  WITH CHECK ADD FOREIGN KEY([IDBookRoom])
REFERENCES [dbo].[BookRoom] ([ID])
GO
ALTER TABLE [dbo].[ReceiveRoom]  WITH CHECK ADD FOREIGN KEY([IDRoom])
REFERENCES [dbo].[Room] ([ID])
GO
ALTER TABLE [dbo].[ReceiveRoomDetails]  WITH CHECK ADD FOREIGN KEY([IDCustomerOther])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[ReceiveRoomDetails]  WITH CHECK ADD FOREIGN KEY([IDReceiveRoom])
REFERENCES [dbo].[ReceiveRoom] ([ID])
GO
ALTER TABLE [dbo].[REPORT]  WITH CHECK ADD FOREIGN KEY([idRoomType])
REFERENCES [dbo].[RoomType] ([ID])
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD FOREIGN KEY([IDRoomType])
REFERENCES [dbo].[RoomType] ([ID])
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD FOREIGN KEY([IDStatusRoom])
REFERENCES [dbo].[StatusRoom] ([ID])
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD FOREIGN KEY([IDServiceType])
REFERENCES [dbo].[ServiceType] ([ID])
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD FOREIGN KEY([IDStaffType])
REFERENCES [dbo].[StaffType] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[USP_ChekcAccess]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ChekcAccess] 
@username NVARCHAR(100), @formname NVARCHAR(100)
AS
BEGIN
	SELECT UserName FROM dbo.Staff INNER JOIN dbo.StaffType ON StaffType.ID = Staff.IDStaffType 
	INNER JOIN access ON access.Idstafftype = stafftype.ID INNER JOIN job ON job.id = access.idjob
	WHERE UserName = @username AND @formname LIKE NameForm
END
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadListFullRoom]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_LoadListFullRoom]
@getToday Date
as
begin
	select distinct A.*
	from Room A,ReceiveRoom B, BookRoom C
	where A.IDStatusRoom=2 and A.ID=B.IDRoom and B.IDBookRoom=C.ID and C.DateCheckOut>=@getToday
	order by A.ID asc
end
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 5/24/2022 4:17:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_Login]
@userName nvarchar(100),@passWord nvarchar(100)
as
Select * from Staff where UserName=@userName and PassWord=@passWord
GO
USE [master]
GO
ALTER DATABASE [KS7] SET  READ_WRITE 
GO


/****** Object:  UserDefinedTableType [dbo].[CandidateAvailabilitiesArray]    Script Date: 07-02-2020 15:45:39 ******/
CREATE TYPE [dbo].[CandidateAvailabilitiesArray] AS TABLE(
	[AvailableDate] [datetimeoffset](7) NULL,
	[FromTime] [time](7) NULL,
	[ToTime] [time](7) NULL,
	[CandidateId] [int] NULL
)
GO
/****** Object:  Table [dbo].[ApplicationLocales]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationLocales](
	[ApplicationLocaleId] [int] IDENTITY(1,1) NOT NULL,
	[LocaleCode] [varchar](50) NOT NULL,
	[LocaleName] [nvarchar](300) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_ApplicationLocales] PRIMARY KEY CLUSTERED 
(
	[ApplicationLocaleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationTimeZones]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationTimeZones](
	[ApplicationTimeZoneId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationTimeZoneName] [nvarchar](100) NOT NULL,
	[Comment] [nvarchar](200) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_TimeZones] PRIMARY KEY CLUSTERED 
(
	[ApplicationTimeZoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationLocaleId] [int] NOT NULL,
	[ApplicationTimeZoneId] [int] NOT NULL,
	[LanguageCode] [varchar](3) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [binary](132) NOT NULL,
	[Salt] [binary](140) NOT NULL,
	[LoginBlocked] [bit] NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vUsers]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vUsers]
AS
SELECT        appuser.UserId, timezone.ApplicationTimeZoneName, appuser.LanguageCode, appuser.UserName, appuser.Password, appuser.Salt, appuser.LoginBlocked, locale.LocaleCode
FROM            dbo.Users AS appuser INNER JOIN
                         dbo.ApplicationLocales AS locale ON appuser.ApplicationLocaleId = locale.ApplicationLocaleId INNER JOIN
                         dbo.ApplicationTimeZones AS timezone ON appuser.ApplicationTimeZoneId = timezone.ApplicationTimeZoneId
GO
/****** Object:  Table [dbo].[Candidates]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidates](
	[CandidateId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[EmailId] [varchar](50) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Designation] [varchar](50) NOT NULL,
	[Experience] [int] NOT NULL,
 CONSTRAINT [PK_Candidates] PRIMARY KEY CLUSTERED 
(
	[CandidateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vCandidates]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCandidates]
AS
SELECT        CandidateId, FirstName, EmailId, CountryId, Designation, Experience
FROM            dbo.Candidates
GO
/****** Object:  Table [dbo].[States]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[StateName] [nvarchar](100) NOT NULL,
	[StatusId] [int] NOT NULL,
	[CountryId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vStateRecords]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vStateRecords]
AS
SELECT        StateId, StateName, StatusId
FROM            dbo.States
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](100) NOT NULL,
	[StatusId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vCountryLookups]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCountryLookups]
AS
SELECT       CountryId, CountryName
FROM            dbo.Countries
GO
/****** Object:  View [dbo].[vCandidateRecords]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCandidateRecords]
AS
SELECT        CandidateId, FirstName, EmailId, CountryId, Designation, Experience
FROM            dbo.Candidates
GO
/****** Object:  Table [dbo].[ApplicationModules]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationModules](
	[ApplicationModuleId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleMasterId] [int] NOT NULL,
	[ParentApplicationModuleId] [int] NULL,
 CONSTRAINT [PK_ApplicationModules] PRIMARY KEY CLUSTERED 
(
	[ApplicationModuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationObjects]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationObjects](
	[ApplicationObjectId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationObjectTypeId] [int] NOT NULL,
	[ApplicationObjectName] [varchar](100) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_ApplicationObjects] PRIMARY KEY CLUSTERED 
(
	[ApplicationObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationObjectTypes]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationObjectTypes](
	[ApplicationObjectTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationObjectTypeName] [varchar](100) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_ApplicationObjectTypes] PRIMARY KEY CLUSTERED 
(
	[ApplicationObjectTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationUserTokens]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationUserTokens](
	[ApplicationUserTokenId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[SecurityKey] [varchar](200) NOT NULL,
	[JwtToken] [varchar](max) NOT NULL,
	[AudienceType] [varchar](50) NOT NULL,
	[CreatedDateTime] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_ApplicationUserTokens] PRIMARY KEY CLUSTERED 
(
	[ApplicationUserTokenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CandidateAvailabilities]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidateAvailabilities](
	[CandidateAvailabilityId] [int] IDENTITY(1,1) NOT NULL,
	[AvailableDate] [datetimeoffset](7) NOT NULL,
	[FromTime] [time](7) NOT NULL,
	[ToTime] [time](7) NOT NULL,
	[CandidateId] [int] NOT NULL,
 CONSTRAINT [PK_CandidateAvailabilities] PRIMARY KEY CLUSTERED 
(
	[CandidateAvailabilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComponentLanguageContents]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComponentLanguageContents](
	[ComponentLanguageContentId] [int] IDENTITY(1,1) NOT NULL,
	[ComponentKeyId] [int] NOT NULL,
	[LanguageContentId] [int] NOT NULL,
	[En] [varchar](max) NULL,
	[Fr] [varchar](max) NULL,
 CONSTRAINT [PK_ModuleProperties] PRIMARY KEY CLUSTERED 
(
	[ComponentLanguageContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LanguageContentKeys]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageContentKeys](
	[LanguageContentKeyId] [int] IDENTITY(1,1) NOT NULL,
	[KeyName] [varchar](50) NOT NULL,
	[IsComponent] [bit] NOT NULL,
 CONSTRAINT [PK_LanguageContentKeys] PRIMARY KEY CLUSTERED 
(
	[LanguageContentKeyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LanguageContents]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageContents](
	[LanguageContentId] [int] IDENTITY(1,1) NOT NULL,
	[LanguageContentKeyId] [int] NOT NULL,
	[ContentType] [varchar](3) NOT NULL,
	[En] [varchar](max) NOT NULL,
	[Fr] [varchar](max) NULL,
 CONSTRAINT [PK_LanguageContents] PRIMARY KEY CLUSTERED 
(
	[LanguageContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ModuleMasters]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleMasters](
	[ModuleMasterId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleMasterName] [varchar](100) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_ModuleMasters] PRIMARY KEY CLUSTERED 
(
	[ModuleMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermissions]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermissions](
	[RolePermissionId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[ApplicationModuleId] [int] NOT NULL,
	[CanView] [bit] NULL,
	[CanAdd] [bit] NULL,
	[CanEdit] [bit] NULL,
	[CanDelete] [bit] NULL,
	[PermissionPriority] [int] NOT NULL,
 CONSTRAINT [PK_RolePermissions] PRIMARY KEY CLUSTERED 
(
	[RolePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ApplicationLocales] ON 

INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (1, N'', N'Invariant Language (Invariant Country)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (2, N'aa', N'Qafar', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (3, N'aa-DJ', N'Qafar (Yabuuti)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (4, N'aa-ER', N'Qafar (Eretria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (5, N'aa-ET', N'Qafar (Otobbia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (6, N'af', N'Afrikaans', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (7, N'af-NA', N'Afrikaans (Namibië)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (8, N'af-ZA', N'Afrikaans (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (9, N'agq', N'Aghem', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (10, N'agq-CM', N'Aghem (Kàmàlû?)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (11, N'ak', N'Akan', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (12, N'ak-GH', N'Akan (Gaana)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (13, N'am', N'Amharic', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (14, N'am-ET', N'Amharic (Ethiopia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (15, N'ar', N'Arabic', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (16, N'ar-001', N'??????? (??????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (17, N'ar-AE', N'Arabic (United Arab Emirates)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (18, N'ar-BH', N'Arabic (Bahrain)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (19, N'ar-DJ', N'??????? (??????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (20, N'ar-DZ', N'Arabic (Algeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (21, N'ar-EG', N'Arabic (Egypt)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (22, N'ar-ER', N'??????? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (23, N'ar-IL', N'??????? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (24, N'ar-IQ', N'Arabic (Iraq)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (25, N'ar-JO', N'Arabic (Jordan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (26, N'ar-KM', N'??????? (??? ?????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (27, N'ar-KW', N'Arabic (Kuwait)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (28, N'ar-LB', N'Arabic (Lebanon)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (29, N'ar-LY', N'Arabic (Libya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (30, N'ar-MA', N'Arabic (Morocco)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (31, N'ar-MR', N'??????? (?????????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (32, N'ar-OM', N'Arabic (Oman)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (33, N'ar-PS', N'??????? (?????? ??????????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (34, N'ar-QA', N'Arabic (Qatar)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (35, N'ar-SA', N'Arabic (Saudi Arabia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (36, N'ar-SD', N'??????? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (37, N'ar-SO', N'??????? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (38, N'ar-SS', N'??????? (???? ???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (39, N'ar-SY', N'Arabic (Syria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (40, N'ar-TD', N'??????? (????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (41, N'ar-TN', N'Arabic (Tunisia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (42, N'ar-YE', N'Arabic (Yemen)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (43, N'arn', N'Mapudungun', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (44, N'arn-CL', N'Mapudungun (Chile)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (45, N'as', N'Assamese', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (46, N'as-IN', N'Assamese (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (47, N'asa', N'Kipare', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (48, N'asa-TZ', N'Kipare (Tadhania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (49, N'ast', N'asturianu', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (50, N'ast-ES', N'asturianu (España)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (51, N'az', N'Azerbaijani', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (52, N'az-Cyrl', N'Azerbaijani (Cyrillic)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (53, N'az-Cyrl-AZ', N'Azerbaijani (Cyrillic, Azerbaijan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (54, N'az-Latn', N'Azerbaijani (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (55, N'az-Latn-AZ', N'Azerbaijani (Latin, Azerbaijan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (56, N'ba', N'Bashkir', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (57, N'ba-RU', N'Bashkir (Russia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (58, N'bas', N'?àsàa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (59, N'bas-CM', N'?àsàa (Kàm?`rûn)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (60, N'be', N'Belarusian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (61, N'be-BY', N'Belarusian (Belarus)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (62, N'bem', N'Ichibemba', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (63, N'bem-ZM', N'Ichibemba (Zambia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (64, N'bez', N'Hibena', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (65, N'bez-TZ', N'Hibena (Hutanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (66, N'bg', N'Bulgarian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (67, N'bg-BG', N'Bulgarian (Bulgaria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (68, N'bin', N'Edo', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (69, N'bin-NG', N'Edo (Nigeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (70, N'bm', N'bamanakan', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (71, N'bm-Latn', N'bamanakan', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (72, N'bm-Latn-ML', N'bamanakan (Mali)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (73, N'bn', N'Bangla', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (74, N'bn-BD', N'Bangla (Bangladesh)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (75, N'bn-IN', N'Bengali (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (76, N'bo', N'Tibetan', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (77, N'bo-CN', N'Tibetan (China)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (78, N'bo-IN', N'???????? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (79, N'br', N'Breton', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (80, N'br-FR', N'Breton (France)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (81, N'brx', N'????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (82, N'brx-IN', N'???? (????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (83, N'bs', N'Bosnian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (84, N'bs-Cyrl', N'Bosnian (Cyrillic)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (85, N'bs-Cyrl-BA', N'Bosnian (Cyrillic, Bosnia and Herzegovina)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (86, N'bs-Latn', N'Bosnian (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (87, N'bs-Latn-BA', N'Bosnian (Latin, Bosnia and Herzegovina)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (88, N'byn', N'???', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (89, N'byn-ER', N'??? (????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (90, N'ca', N'Catalan', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (91, N'ca-AD', N'català (Andorra)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (92, N'ca-ES', N'Catalan (Catalan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (93, N'ca-ES-valencia', N'Valencian (Spain)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (94, N'ca-FR', N'català (França)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (95, N'ca-IT', N'català (Itàlia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (96, N'ce', N'???????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (97, N'ce-RU', N'??????? (?????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (98, N'cgg', N'Rukiga', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (99, N'cgg-UG', N'Rukiga (Uganda)', 1)
GO
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (100, N'chr', N'Cherokee', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (101, N'chr-Cher', N'Cherokee', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (102, N'chr-Cher-US', N'Cherokee (Cherokee, United States)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (103, N'co', N'Corsican', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (104, N'co-FR', N'Corsican (France)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (105, N'cs', N'Czech', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (106, N'cs-CZ', N'Czech (Czechia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (107, N'cu', N'?????????????´?????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (108, N'cu-RU', N'?????????????´????? (?????´?)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (109, N'cy', N'Welsh', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (110, N'cy-GB', N'Welsh (United Kingdom)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (111, N'da', N'Danish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (112, N'da-DK', N'Danish (Denmark)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (113, N'da-GL', N'dansk (Grønland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (114, N'dav', N'Kitaita', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (115, N'dav-KE', N'Kitaita (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (116, N'de', N'German', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (117, N'de-AT', N'German (Austria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (118, N'de-BE', N'Deutsch (Belgien)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (119, N'de-CH', N'German (Switzerland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (120, N'de-DE', N'German (Germany)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (121, N'de-IT', N'Deutsch (Italien)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (122, N'de-LI', N'German (Liechtenstein)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (123, N'de-LU', N'German (Luxembourg)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (124, N'dje', N'Zarmaciine', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (125, N'dje-NE', N'Zarmaciine (Nižer)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (126, N'dsb', N'Lower Sorbian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (127, N'dsb-DE', N'Lower Sorbian (Germany)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (128, N'dua', N'duálá', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (129, N'dua-CM', N'duálá (Cameroun)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (130, N'dv', N'Divehi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (131, N'dv-MV', N'Divehi (Maldives)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (132, N'dyo', N'joola', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (133, N'dyo-SN', N'joola (Senegal)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (134, N'dz', N'??????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (135, N'dz-BT', N'Dzongkha (Bhutan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (136, N'ebu', N'Kiembu', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (137, N'ebu-KE', N'Kiembu (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (138, N'ee', N'E?egbe', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (139, N'ee-GH', N'E?egbe (Ghana nutome)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (140, N'ee-TG', N'E?egbe (Togo nutome)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (141, N'el', N'Greek', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (142, N'el-CY', N'???????? (??p???)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (143, N'el-GR', N'Greek (Greece)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (144, N'en', N'English', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (145, N'en-001', N'English (World)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (146, N'en-029', N'English (Caribbean)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (147, N'en-150', N'English (Europe)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (148, N'en-AG', N'English (Antigua and Barbuda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (149, N'en-AI', N'English (Anguilla)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (150, N'en-AS', N'English (American Samoa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (151, N'en-AT', N'English (Austria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (152, N'en-AU', N'English (Australia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (153, N'en-BB', N'English (Barbados)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (154, N'en-BE', N'English (Belgium)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (155, N'en-BI', N'English (Burundi)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (156, N'en-BM', N'English (Bermuda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (157, N'en-BS', N'English (Bahamas)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (158, N'en-BW', N'English (Botswana)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (159, N'en-BZ', N'English (Belize)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (160, N'en-CA', N'English (Canada)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (161, N'en-CC', N'English (Cocos (Keeling) Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (162, N'en-CH', N'English (Switzerland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (163, N'en-CK', N'English (Cook Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (164, N'en-CM', N'English (Cameroon)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (165, N'en-CX', N'English (Christmas Island)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (166, N'en-CY', N'English (Cyprus)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (167, N'en-DE', N'English (Germany)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (168, N'en-DK', N'English (Denmark)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (169, N'en-DM', N'English (Dominica)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (170, N'en-ER', N'English (Eritrea)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (171, N'en-FI', N'English (Finland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (172, N'en-FJ', N'English (Fiji)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (173, N'en-FK', N'English (Falkland Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (174, N'en-FM', N'English (Micronesia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (175, N'en-GB', N'English (United Kingdom)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (176, N'en-GD', N'English (Grenada)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (177, N'en-GG', N'English (Guernsey)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (178, N'en-GH', N'English (Ghana)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (179, N'en-GI', N'English (Gibraltar)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (180, N'en-GM', N'English (Gambia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (181, N'en-GU', N'English (Guam)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (182, N'en-GY', N'English (Guyana)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (183, N'en-HK', N'English (Hong Kong SAR)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (184, N'en-ID', N'English (Indonesia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (185, N'en-IE', N'English (Ireland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (186, N'en-IL', N'English (Israel)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (187, N'en-IM', N'English (Isle of Man)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (188, N'en-IN', N'English (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (189, N'en-IO', N'English (British Indian Ocean Territory)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (190, N'en-JE', N'English (Jersey)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (191, N'en-JM', N'English (Jamaica)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (192, N'en-KE', N'English (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (193, N'en-KI', N'English (Kiribati)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (194, N'en-KN', N'English (Saint Kitts and Nevis)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (195, N'en-KY', N'English (Cayman Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (196, N'en-LC', N'English (Saint Lucia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (197, N'en-LR', N'English (Liberia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (198, N'en-LS', N'English (Lesotho)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (199, N'en-MG', N'English (Madagascar)', 1)
GO
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (200, N'en-MH', N'English (Marshall Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (201, N'en-MO', N'English (Macao SAR)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (202, N'en-MP', N'English (Northern Mariana Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (203, N'en-MS', N'English (Montserrat)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (204, N'en-MT', N'English (Malta)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (205, N'en-MU', N'English (Mauritius)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (206, N'en-MW', N'English (Malawi)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (207, N'en-MY', N'English (Malaysia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (208, N'en-NA', N'English (Namibia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (209, N'en-NF', N'English (Norfolk Island)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (210, N'en-NG', N'English (Nigeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (211, N'en-NL', N'English (Netherlands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (212, N'en-NR', N'English (Nauru)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (213, N'en-NU', N'English (Niue)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (214, N'en-NZ', N'English (New Zealand)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (215, N'en-PG', N'English (Papua New Guinea)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (216, N'en-PH', N'English (Philippines)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (217, N'en-PK', N'English (Pakistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (218, N'en-PN', N'English (Pitcairn Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (219, N'en-PR', N'English (Puerto Rico)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (220, N'en-PW', N'English (Palau)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (221, N'en-RW', N'English (Rwanda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (222, N'en-SB', N'English (Solomon Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (223, N'en-SC', N'English (Seychelles)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (224, N'en-SD', N'English (Sudan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (225, N'en-SE', N'English (Sweden)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (226, N'en-SG', N'English (Singapore)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (227, N'en-SH', N'English (St Helena, Ascension, Tristan da Cunha)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (228, N'en-SI', N'English (Slovenia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (229, N'en-SL', N'English (Sierra Leone)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (230, N'en-SS', N'English (South Sudan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (231, N'en-SX', N'English (Sint Maarten)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (232, N'en-SZ', N'English (Eswatini)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (233, N'en-TC', N'English (Turks and Caicos Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (234, N'en-TK', N'English (Tokelau)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (235, N'en-TO', N'English (Tonga)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (236, N'en-TT', N'English (Trinidad and Tobago)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (237, N'en-TV', N'English (Tuvalu)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (238, N'en-TZ', N'English (Tanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (239, N'en-UG', N'English (Uganda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (240, N'en-UM', N'English (U.S. Outlying Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (241, N'en-US', N'English (United States)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (242, N'en-VC', N'English (Saint Vincent and the Grenadines)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (243, N'en-VG', N'English (British Virgin Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (244, N'en-VI', N'English (U.S. Virgin Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (245, N'en-VU', N'English (Vanuatu)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (246, N'en-WS', N'English (Samoa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (247, N'en-ZA', N'English (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (248, N'en-ZM', N'English (Zambia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (249, N'en-ZW', N'English (Zimbabwe)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (250, N'eo', N'esperanto', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (251, N'eo-001', N'esperanto (World)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (252, N'es', N'Spanish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (253, N'es-419', N'Spanish (Latin America)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (254, N'es-AR', N'Spanish (Argentina)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (255, N'es-BO', N'Spanish (Bolivia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (256, N'es-BR', N'español (Brasil)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (257, N'es-BZ', N'español (Belice)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (258, N'es-CL', N'Spanish (Chile)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (259, N'es-CO', N'Spanish (Colombia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (260, N'es-CR', N'Spanish (Costa Rica)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (261, N'es-CU', N'Spanish (Cuba)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (262, N'es-DO', N'Spanish (Dominican Republic)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (263, N'es-EC', N'Spanish (Ecuador)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (264, N'es-ES', N'Spanish (Spain, International Sort)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (265, N'es-GQ', N'español (Guinea Ecuatorial)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (266, N'es-GT', N'Spanish (Guatemala)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (267, N'es-HN', N'Spanish (Honduras)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (268, N'es-MX', N'Spanish (Mexico)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (269, N'es-NI', N'Spanish (Nicaragua)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (270, N'es-PA', N'Spanish (Panama)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (271, N'es-PE', N'Spanish (Peru)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (272, N'es-PH', N'español (Filipinas)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (273, N'es-PR', N'Spanish (Puerto Rico)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (274, N'es-PY', N'Spanish (Paraguay)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (275, N'es-SV', N'Spanish (El Salvador)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (276, N'es-US', N'Spanish (United States)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (277, N'es-UY', N'Spanish (Uruguay)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (278, N'es-VE', N'Spanish (Venezuela)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (279, N'et', N'Estonian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (280, N'et-EE', N'Estonian (Estonia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (281, N'eu', N'Basque', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (282, N'eu-ES', N'Basque (Basque)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (283, N'ewo', N'ewondo', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (284, N'ewo-CM', N'ewondo (Kam?rún)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (285, N'fa', N'Persian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (286, N'fa-IR', N'Persian (Iran)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (287, N'ff', N'Fulah (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (288, N'ff-Latn', N'Fulah (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (289, N'ff-Latn-BF', N'Pulaar (Burkibaa Faaso)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (290, N'ff-Latn-CM', N'Pulaar (Kameruun)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (291, N'ff-Latn-GH', N'Pulaar (Ganaa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (292, N'ff-Latn-GM', N'Pulaar (Gammbi)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (293, N'ff-Latn-GN', N'Pulaar (Gine)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (294, N'ff-Latn-GW', N'Pulaar (Gine-Bisaawo)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (295, N'ff-Latn-LR', N'Pulaar (Liberiyaa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (296, N'ff-Latn-MR', N'Pulaar (Muritani)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (297, N'ff-Latn-NE', N'Pulaar (Nijeer)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (298, N'ff-Latn-NG', N'Fulah (Latin, Nigeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (299, N'ff-Latn-SL', N'Pulaar (Seraa liyon)', 1)
GO
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (300, N'ff-Latn-SN', N'Fulah (Latin, Senegal)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (301, N'fi', N'Finnish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (302, N'fi-FI', N'Finnish (Finland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (303, N'fil', N'Filipino', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (304, N'fil-PH', N'Filipino (Philippines)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (305, N'fo', N'Faroese', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (306, N'fo-DK', N'føroyskt (Danmark)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (307, N'fo-FO', N'Faroese (Faroe Islands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (308, N'fr', N'French', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (309, N'fr-029', N'French (Caribbean)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (310, N'fr-BE', N'French (Belgium)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (311, N'fr-BF', N'français (Burkina Faso)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (312, N'fr-BI', N'français (Burundi)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (313, N'fr-BJ', N'français (Bénin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (314, N'fr-BL', N'français (Saint-Barthélemy)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (315, N'fr-CA', N'French (Canada)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (316, N'fr-CD', N'French Congo (DRC)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (317, N'fr-CF', N'français (République centrafricaine)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (318, N'fr-CG', N'français (Congo)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (319, N'fr-CH', N'French (Switzerland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (320, N'fr-CI', N'French (Côte d’Ivoire)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (321, N'fr-CM', N'French (Cameroon)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (322, N'fr-DJ', N'français (Djibouti)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (323, N'fr-DZ', N'français (Algérie)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (324, N'fr-FR', N'French (France)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (325, N'fr-GA', N'français (Gabon)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (326, N'fr-GF', N'français (Guyane française)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (327, N'fr-GN', N'français (Guinée)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (328, N'fr-GP', N'français (Guadeloupe)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (329, N'fr-GQ', N'français (Guinée équatoriale)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (330, N'fr-HT', N'French (Haiti)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (331, N'fr-KM', N'français (Comores)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (332, N'fr-LU', N'French (Luxembourg)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (333, N'fr-MA', N'French (Morocco)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (334, N'fr-MC', N'French (Monaco)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (335, N'fr-MF', N'français (Saint-Martin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (336, N'fr-MG', N'français (Madagascar)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (337, N'fr-ML', N'French (Mali)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (338, N'fr-MQ', N'français (Martinique)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (339, N'fr-MR', N'français (Mauritanie)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (340, N'fr-MU', N'français (Maurice)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (341, N'fr-NC', N'français (Nouvelle-Calédonie)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (342, N'fr-NE', N'français (Niger)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (343, N'fr-PF', N'français (Polynésie française)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (344, N'fr-PM', N'français (Saint-Pierre-et-Miquelon)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (345, N'fr-RE', N'French (Réunion)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (346, N'fr-RW', N'français (Rwanda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (347, N'fr-SC', N'français (Seychelles)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (348, N'fr-SN', N'French (Senegal)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (349, N'fr-SY', N'français (Syrie)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (350, N'fr-TD', N'français (Tchad)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (351, N'fr-TG', N'français (Togo)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (352, N'fr-TN', N'français (Tunisie)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (353, N'fr-VU', N'français (Vanuatu)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (354, N'fr-WF', N'français (Wallis-et-Futuna)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (355, N'fr-YT', N'français (Mayotte)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (356, N'fur', N'furlan', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (357, N'fur-IT', N'furlan (Italie)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (358, N'fy', N'Western Frisian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (359, N'fy-NL', N'Western Frisian (Netherlands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (360, N'ga', N'Irish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (361, N'ga-IE', N'Irish (Ireland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (362, N'gd', N'Scottish Gaelic', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (363, N'gd-GB', N'Scottish Gaelic (United Kingdom)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (364, N'gl', N'Galician', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (365, N'gl-ES', N'Galician (Galician)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (366, N'gn', N'Guarani', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (367, N'gn-PY', N'Guarani (Paraguay)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (368, N'gsw', N'Swiss German', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (369, N'gsw-CH', N'Schwiizertüütsch (Schwiiz)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (370, N'gsw-FR', N'Alsatian (France)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (371, N'gsw-LI', N'Schwiizertüütsch (Liächteschtäi)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (372, N'gu', N'Gujarati', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (373, N'gu-IN', N'Gujarati (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (374, N'guz', N'Ekegusii', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (375, N'guz-KE', N'Ekegusii (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (376, N'gv', N'Gaelg', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (377, N'gv-IM', N'Gaelg (Ellan Vannin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (378, N'ha', N'Hausa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (379, N'ha-Latn', N'Hausa (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (380, N'ha-Latn-GH', N'Hausa (Gana)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (381, N'ha-Latn-NE', N'Hausa (Nijar)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (382, N'ha-Latn-NG', N'Hausa (Latin, Nigeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (383, N'haw', N'Hawaiian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (384, N'haw-US', N'Hawaiian (United States)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (385, N'he', N'Hebrew', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (386, N'he-IL', N'Hebrew (Israel)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (387, N'hi', N'Hindi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (388, N'hi-IN', N'Hindi (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (389, N'hr', N'Croatian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (390, N'hr-BA', N'Croatian (Bosnia and Herzegovina)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (391, N'hr-HR', N'Croatian (Croatia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (392, N'hsb', N'Upper Sorbian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (393, N'hsb-DE', N'Upper Sorbian (Germany)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (394, N'hu', N'Hungarian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (395, N'hu-HU', N'Hungarian (Hungary)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (396, N'hy', N'Armenian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (397, N'hy-AM', N'Armenian (Armenia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (398, N'ia', N'interlingua', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (399, N'ia-001', N'interlingua (Mundo)', 1)
GO
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (400, N'ibb', N'Ibibio', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (401, N'ibb-NG', N'Ibibio (Nigeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (402, N'id', N'Indonesian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (403, N'id-ID', N'Indonesian (Indonesia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (404, N'ig', N'Igbo', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (405, N'ig-NG', N'Igbo (Nigeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (406, N'ii', N'Yi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (407, N'ii-CN', N'Yi (China)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (408, N'is', N'Icelandic', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (409, N'is-IS', N'Icelandic (Iceland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (410, N'it', N'Italian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (411, N'it-CH', N'Italian (Switzerland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (412, N'it-IT', N'Italian (Italy)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (413, N'it-SM', N'italiano (San Marino)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (414, N'it-VA', N'italiano (Città del Vaticano)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (415, N'iu', N'Inuktitut', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (416, N'iu-Cans', N'Inuktitut (Syllabics)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (417, N'iu-Cans-CA', N'Inuktitut (Syllabics, Canada)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (418, N'iu-Latn', N'Inuktitut (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (419, N'iu-Latn-CA', N'Inuktitut (Latin, Canada)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (420, N'ja', N'Japanese', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (421, N'ja-JP', N'Japanese (Japan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (422, N'jgo', N'Nda?a', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (423, N'jgo-CM', N'Nda?a (Kam?lûn)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (424, N'jmc', N'Kimachame', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (425, N'jmc-TZ', N'Kimachame (Tanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (426, N'jv', N'Basa Jawa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (427, N'jv-Java', N'????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (428, N'jv-Java-ID', N'???? (Indonesia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (429, N'jv-Latn', N'Basa Jawa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (430, N'jv-Latn-ID', N'Basa Jawa (Indonesia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (431, N'ka', N'Georgian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (432, N'ka-GE', N'Georgian (Georgia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (433, N'kab', N'Taqbaylit', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (434, N'kab-DZ', N'Taqbaylit (Lezzayer)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (435, N'kam', N'Kikamba', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (436, N'kam-KE', N'Kikamba (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (437, N'kde', N'Chimakonde', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (438, N'kde-TZ', N'Chimakonde (Tanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (439, N'kea', N'kabuverdianu', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (440, N'kea-CV', N'kabuverdianu (Kabu Verdi)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (441, N'khq', N'Koyra ciini', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (442, N'khq-ML', N'Koyra ciini (Maali)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (443, N'ki', N'Gikuyu', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (444, N'ki-KE', N'Gikuyu (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (445, N'kk', N'Kazakh', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (446, N'kk-KZ', N'Kazakh (Kazakhstan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (447, N'kkj', N'kak?', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (448, N'kkj-CM', N'kak? (Kam?run)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (449, N'kl', N'Greenlandic', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (450, N'kl-GL', N'Greenlandic (Greenland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (451, N'kln', N'Kalenjin', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (452, N'kln-KE', N'Kalenjin (Emetab Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (453, N'km', N'Khmer', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (454, N'km-KH', N'Khmer (Cambodia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (455, N'kn', N'Kannada', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (456, N'kn-IN', N'Kannada (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (457, N'ko', N'Korean', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (458, N'ko-KP', N'??? (???????????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (459, N'ko-KR', N'Korean (Korea)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (460, N'kok', N'Konkani', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (461, N'kok-IN', N'Konkani (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (462, N'kr', N'Kanuri', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (463, N'kr-Latn', N'Kanuri', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (464, N'kr-Latn-NG', N'Kanuri (Nigeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (465, N'ks', N'Kashmiri', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (466, N'ks-Arab', N'Kashmiri (Perso-Arabic)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (467, N'ks-Arab-IN', N'????? (?????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (468, N'ks-Deva', N'?????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (469, N'ks-Deva-IN', N'Kashmiri (Devanagari)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (470, N'ksb', N'Kishambaa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (471, N'ksb-TZ', N'Kishambaa (Tanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (472, N'ksf', N'rikpa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (473, N'ksf-CM', N'rikpa (kam?rún)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (474, N'ksh', N'Kölsch', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (475, N'ksh-DE', N'Kölsch (Doütschland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (476, N'ku', N'Central Kurdish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (477, N'ku-Arab', N'Central Kurdish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (478, N'ku-Arab-IQ', N'Central Kurdish (Iraq)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (479, N'ku-Arab-IR', N'????? (?????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (480, N'kw', N'kernewek', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (481, N'kw-GB', N'kernewek (Rywvaneth Unys)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (482, N'ky', N'Kyrgyz', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (483, N'ky-KG', N'Kyrgyz (Kyrgyzstan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (484, N'la', N'Latin', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (485, N'la-001', N'Latin (World)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (486, N'lag', N'K?laangi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (487, N'lag-TZ', N'K?laangi (Taansanía)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (488, N'lb', N'Luxembourgish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (489, N'lb-LU', N'Luxembourgish (Luxembourg)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (490, N'lg', N'Luganda', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (491, N'lg-UG', N'Luganda (Yuganda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (492, N'lkt', N'Lak?ól''iyapi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (493, N'lkt-US', N'Lak?ól''iyapi (Mílaha?ska T?amák?oche)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (494, N'ln', N'lingála', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (495, N'ln-AO', N'lingála (Angóla)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (496, N'ln-CD', N'lingála (Republíki ya Kongó Demokratíki)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (497, N'ln-CF', N'lingála (Repibiki ya Afríka ya Káti)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (498, N'ln-CG', N'lingála (Kongo)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (499, N'lo', N'Lao', 1)
GO
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (500, N'lo-LA', N'Lao (Laos)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (501, N'lrc', N'???? ??????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (502, N'lrc-IQ', N'???? ?????? (Iraq)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (503, N'lrc-IR', N'???? ?????? (Iran)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (504, N'lt', N'Lithuanian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (505, N'lt-LT', N'Lithuanian (Lithuania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (506, N'lu', N'Tshiluba', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (507, N'lu-CD', N'Tshiluba (Ditunga wa Kongu)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (508, N'luo', N'Dholuo', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (509, N'luo-KE', N'Dholuo (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (510, N'luy', N'Luluhia', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (511, N'luy-KE', N'Luluhia (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (512, N'lv', N'Latvian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (513, N'lv-LV', N'Latvian (Latvia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (514, N'mas', N'Maa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (515, N'mas-KE', N'Maa (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (516, N'mas-TZ', N'Maa (Tansania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (517, N'mer', N'Kimiru', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (518, N'mer-KE', N'Kimiru (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (519, N'mfe', N'kreol morisien', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (520, N'mfe-MU', N'kreol morisien (Moris)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (521, N'mg', N'Malagasy', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (522, N'mg-MG', N'Malagasy (Madagasikara)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (523, N'mgh', N'Makua', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (524, N'mgh-MZ', N'Makua (Umozambiki)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (525, N'mgo', N'meta''', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (526, N'mgo-CM', N'meta'' (Kamalun)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (527, N'mi', N'Maori', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (528, N'mi-NZ', N'Maori (New Zealand)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (529, N'mk', N'Macedonian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (530, N'mk-MK', N'Macedonian (North Macedonia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (531, N'ml', N'Malayalam', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (532, N'ml-IN', N'Malayalam (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (533, N'mn', N'Mongolian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (534, N'mn-Cyrl', N'Mongolian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (535, N'mn-MN', N'Mongolian (Mongolia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (536, N'mn-Mong', N'Mongolian (Traditional Mongolian)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (537, N'mn-Mong-CN', N'Mongolian (Traditional Mongolian, China)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (538, N'mn-Mong-MN', N'Mongolian (Traditional Mongolian, Mongolia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (539, N'mni', N'Manipuri', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (540, N'mni-IN', N'Manipuri (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (541, N'moh', N'Mohawk', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (542, N'moh-CA', N'Mohawk (Mohawk)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (543, N'mr', N'Marathi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (544, N'mr-IN', N'Marathi (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (545, N'ms', N'Malay', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (546, N'ms-BN', N'Malay (Brunei)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (547, N'ms-MY', N'Malay (Malaysia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (548, N'ms-SG', N'Melayu (Singapura)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (549, N'mt', N'Maltese', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (550, N'mt-MT', N'Maltese (Malta)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (551, N'mua', N'MUNDA?', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (552, N'mua-CM', N'MUNDA? (kameru?)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (553, N'my', N'Burmese', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (554, N'my-MM', N'Burmese (Myanmar)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (555, N'mzn', N'???????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (556, N'mzn-IR', N'??????? (?????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (557, N'naq', N'Khoekhoegowab', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (558, N'naq-NA', N'Khoekhoegowab (Namibiab)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (559, N'nb', N'Norwegian Bokmål', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (560, N'nb-NO', N'Norwegian Bokmål (Norway)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (561, N'nb-SJ', N'norsk bokmål (Svalbard og Jan Mayen)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (562, N'nd', N'isiNdebele', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (563, N'nd-ZW', N'isiNdebele (Zimbabwe)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (564, N'nds', N'Neddersass’sch', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (565, N'nds-DE', N'Neddersass’sch (Düütschland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (566, N'nds-NL', N'Neddersass’sch (Nedderlannen)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (567, N'ne', N'Nepali', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (568, N'ne-IN', N'Nepali (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (569, N'ne-NP', N'Nepali (Nepal)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (570, N'nl', N'Dutch', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (571, N'nl-AW', N'Nederlands (Aruba)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (572, N'nl-BE', N'Dutch (Belgium)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (573, N'nl-BQ', N'Nederlands (Bonaire, Sint Eustatius en Saba)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (574, N'nl-CW', N'Nederlands (Curaçao)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (575, N'nl-NL', N'Dutch (Netherlands)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (576, N'nl-SR', N'Nederlands (Suriname)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (577, N'nl-SX', N'Nederlands (Sint-Maarten)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (578, N'nmg', N'Kwasio', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (579, N'nmg-CM', N'Kwasio (Kamerun)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (580, N'nn', N'Norwegian Nynorsk', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (581, N'nn-NO', N'Norwegian Nynorsk (Norway)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (582, N'nnh', N'Shwó?ò ngiemb??n', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (583, N'nnh-CM', N'Shwó?ò ngiemb??n (Kàmalûm)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (584, N'no', N'Norwegian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (585, N'nqo', N'???', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (586, N'nqo-GN', N'??? (?????? ??????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (587, N'nr', N'isiNdebele', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (588, N'nr-ZA', N'isiNdebele (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (589, N'nso', N'Sesotho sa Leboa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (590, N'nso-ZA', N'Sesotho sa Leboa (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (591, N'nus', N'Thok Nath', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (592, N'nus-SS', N'Thok Nath (South Sudan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (593, N'nyn', N'Runyankore', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (594, N'nyn-UG', N'Runyankore (Uganda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (595, N'oc', N'Occitan', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (596, N'oc-FR', N'Occitan (France)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (597, N'om', N'Oromo', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (598, N'om-ET', N'Oromo (Ethiopia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (599, N'om-KE', N'Oromoo (Keeniyaa)', 1)
GO
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (600, N'or', N'Odia', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (601, N'or-IN', N'Odia (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (602, N'os', N'????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (603, N'os-GE', N'???? (???????????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (604, N'os-RU', N'???? (??????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (605, N'pa', N'Punjabi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (606, N'pa-Arab', N'Punjabi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (607, N'pa-Arab-PK', N'Punjabi (Pakistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (608, N'pa-Guru', N'??????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (609, N'pa-IN', N'Punjabi (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (610, N'pap', N'Papiamento', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (611, N'pap-029', N'Papiamento (Caribbean)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (612, N'pl', N'Polish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (613, N'pl-PL', N'Polish (Poland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (614, N'prg', N'prusiskan', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (615, N'prg-001', N'prusiskan (switai)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (616, N'prs', N'Dari', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (617, N'prs-AF', N'Dari (Afghanistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (618, N'ps', N'Pashto', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (619, N'ps-AF', N'Pashto (Afghanistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (620, N'pt', N'Portuguese', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (621, N'pt-AO', N'português (Angola)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (622, N'pt-BR', N'Portuguese (Brazil)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (623, N'pt-CH', N'português (Suíça)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (624, N'pt-CV', N'português (Cabo Verde)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (625, N'pt-GQ', N'português (Guiné Equatorial)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (626, N'pt-GW', N'português (Guiné-Bissau)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (627, N'pt-LU', N'português (Luxemburgo)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (628, N'pt-MO', N'português (RAE de Macau)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (629, N'pt-MZ', N'português (Moçambique)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (630, N'pt-PT', N'Portuguese (Portugal)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (631, N'pt-ST', N'português (São Tomé e Príncipe)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (632, N'pt-TL', N'português (Timor-Leste)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (633, N'quc', N'Kiche', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (634, N'quc-Latn', N'Kiche', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (635, N'quc-Latn-GT', N'Kiche (Guatemala)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (636, N'quz', N'Quechua', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (637, N'quz-BO', N'Quechua (Bolivia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (638, N'quz-EC', N'Quechua (Ecuador)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (639, N'quz-PE', N'Quechua (Peru)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (640, N'rm', N'Romansh', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (641, N'rm-CH', N'Romansh (Switzerland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (642, N'rn', N'Ikirundi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (643, N'rn-BI', N'Ikirundi (Uburundi)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (644, N'ro', N'Romanian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (645, N'ro-MD', N'Romanian (Moldova)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (646, N'ro-RO', N'Romanian (Romania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (647, N'rof', N'Kihorombo', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (648, N'rof-TZ', N'Kihorombo (Tanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (649, N'ru', N'Russian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (650, N'ru-BY', N'??????? (????????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (651, N'ru-KG', N'??????? (????????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (652, N'ru-KZ', N'??????? (?????????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (653, N'ru-MD', N'Russian (Moldova)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (654, N'ru-RU', N'Russian (Russia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (655, N'ru-UA', N'??????? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (656, N'rw', N'Kinyarwanda', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (657, N'rw-RW', N'Kinyarwanda (Rwanda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (658, N'rwk', N'Kiruwa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (659, N'rwk-TZ', N'Kiruwa (Tanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (660, N'sa', N'Sanskrit', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (661, N'sa-IN', N'Sanskrit (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (662, N'sah', N'Sakha', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (663, N'sah-RU', N'Sakha (Russia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (664, N'saq', N'Kisampur', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (665, N'saq-KE', N'Kisampur (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (666, N'sbp', N'Ishisangu', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (667, N'sbp-TZ', N'Ishisangu (Tansaniya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (668, N'sd', N'Sindhi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (669, N'sd-Arab', N'Sindhi', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (670, N'sd-Arab-PK', N'Sindhi (Pakistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (671, N'sd-Deva', N'??????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (672, N'sd-Deva-IN', N'Sindhi (Devanagari, India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (673, N'se', N'Northern Sami', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (674, N'se-FI', N'Sami, Northern (Finland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (675, N'se-NO', N'Sami, Northern (Norway)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (676, N'se-SE', N'Sami, Northern (Sweden)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (677, N'seh', N'sena', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (678, N'seh-MZ', N'sena (Moçambique)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (679, N'ses', N'Koyraboro senni', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (680, N'ses-ML', N'Koyraboro senni (Maali)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (681, N'sg', N'Sängö', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (682, N'sg-CF', N'Sängö (Ködörösêse tî Bêafrîka)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (683, N'shi', N'???????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (684, N'shi-Latn', N'Tashel?iyt', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (685, N'shi-Latn-MA', N'Tashel?iyt (lm?rib)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (686, N'shi-Tfng', N'???????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (687, N'shi-Tfng-MA', N'??????? (??????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (688, N'si', N'Sinhala', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (689, N'si-LK', N'Sinhala (Sri Lanka)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (690, N'sk', N'Slovak', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (691, N'sk-SK', N'Slovak (Slovakia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (692, N'sl', N'Slovenian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (693, N'sl-SI', N'Slovenian (Slovenia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (694, N'sma', N'Sami (Southern)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (695, N'sma-NO', N'Sami, Southern (Norway)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (696, N'sma-SE', N'Sami, Southern (Sweden)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (697, N'smj', N'Sami (Lule)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (698, N'smj-NO', N'Sami, Lule (Norway)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (699, N'smj-SE', N'Sami, Lule (Sweden)', 1)
GO
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (700, N'smn', N'Sami (Inari)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (701, N'smn-FI', N'Sami, Inari (Finland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (702, N'sms', N'Sami (Skolt)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (703, N'sms-FI', N'Sami, Skolt (Finland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (704, N'sn', N'chiShona', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (705, N'sn-Latn', N'chiShona (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (706, N'sn-Latn-ZW', N'chiShona (Zimbabwe)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (707, N'so', N'Somali', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (708, N'so-DJ', N'Soomaali (Jabuuti)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (709, N'so-ET', N'Soomaali (Itoobiya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (710, N'so-KE', N'Soomaali (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (711, N'so-SO', N'Somali (Somalia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (712, N'sq', N'Albanian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (713, N'sq-AL', N'Albanian (Albania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (714, N'sq-MK', N'shqip (Maqedonia e Veriut)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (715, N'sq-XK', N'shqip (Kosovë)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (716, N'sr', N'Serbian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (717, N'sr-Cyrl', N'Serbian (Cyrillic)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (718, N'sr-Cyrl-BA', N'Serbian (Cyrillic, Bosnia and Herzegovina)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (719, N'sr-Cyrl-ME', N'Serbian (Cyrillic, Montenegro)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (720, N'sr-Cyrl-RS', N'Serbian (Cyrillic, Serbia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (721, N'sr-Cyrl-XK', N'?????? (??????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (722, N'sr-Latn', N'Serbian (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (723, N'sr-Latn-BA', N'Serbian (Latin, Bosnia and Herzegovina)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (724, N'sr-Latn-ME', N'Serbian (Latin, Montenegro)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (725, N'sr-Latn-RS', N'Serbian (Latin, Serbia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (726, N'sr-Latn-XK', N'srpski (Kosovo)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (727, N'ss', N'Siswati', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (728, N'ss-SZ', N'siSwati (eSwatini)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (729, N'ss-ZA', N'siSwati (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (730, N'ssy', N'Saho', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (731, N'ssy-ER', N'Saho (Eretria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (732, N'st', N'Sesotho', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (733, N'st-LS', N'Sesotho (Lesotho)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (734, N'st-ZA', N'Sesotho (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (735, N'sv', N'Swedish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (736, N'sv-AX', N'svenska (Åland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (737, N'sv-FI', N'Swedish (Finland)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (738, N'sv-SE', N'Swedish (Sweden)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (739, N'sw', N'Kiswahili', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (740, N'sw-CD', N'Kiswahili (Jamhuri ya Kidemokrasia ya Kongo)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (741, N'sw-KE', N'Kiswahili (Kenya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (742, N'sw-TZ', N'Kiswahili (Tanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (743, N'sw-UG', N'Kiswahili (Uganda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (744, N'syr', N'Syriac', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (745, N'syr-SY', N'Syriac (Syria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (746, N'ta', N'Tamil', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (747, N'ta-IN', N'Tamil (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (748, N'ta-LK', N'Tamil (Sri Lanka)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (749, N'ta-MY', N'????? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (750, N'ta-SG', N'????? (???????????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (751, N'te', N'Telugu', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (752, N'te-IN', N'Telugu (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (753, N'teo', N'Kiteso', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (754, N'teo-KE', N'Kiteso (Kenia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (755, N'teo-UG', N'Kiteso (Uganda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (756, N'tg', N'Tajik', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (757, N'tg-Cyrl', N'Tajik (Cyrillic)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (758, N'tg-Cyrl-TJ', N'Tajik (Cyrillic, Tajikistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (759, N'th', N'Thai', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (760, N'th-TH', N'Thai (Thailand)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (761, N'ti', N'Tigrinya', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (762, N'ti-ER', N'Tigrinya (Eritrea)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (763, N'ti-ET', N'Tigrinya (Ethiopia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (764, N'tig', N'???', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (765, N'tig-ER', N'??? (????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (766, N'tk', N'Turkmen', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (767, N'tk-TM', N'Turkmen (Turkmenistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (768, N'tn', N'Setswana', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (769, N'tn-BW', N'Setswana (Botswana)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (770, N'tn-ZA', N'Setswana (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (771, N'to', N'lea fakatonga', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (772, N'to-TO', N'lea fakatonga (Tonga)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (773, N'tr', N'Turkish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (774, N'tr-CY', N'Türkçe (Kibris)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (775, N'tr-TR', N'Turkish (Turkey)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (776, N'ts', N'Tsonga', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (777, N'ts-ZA', N'Xitsonga (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (778, N'tt', N'Tatar', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (779, N'tt-RU', N'Tatar (Russia)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (780, N'twq', N'Tasawaq senni', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (781, N'twq-NE', N'Tasawaq senni (Nižer)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (782, N'tzm', N'Central Atlas Tamazight', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (783, N'tzm-Arab', N'???? ???????? ???????????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (784, N'tzm-Arab-MA', N'Central Atlas Tamazight (Arabic, Morocco)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (785, N'tzm-Latn', N'Central Atlas Tamazight (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (786, N'tzm-Latn-DZ', N'Central Atlas Tamazight (Latin, Algeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (787, N'tzm-Latn-MA', N'Tamazi?t n la?la? (Me??uk)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (788, N'tzm-Tfng', N'Central Atlas Tamazight (Tifinagh)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (789, N'tzm-Tfng-MA', N'Central Atlas Tamazight (Tifinagh, Morocco)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (790, N'ug', N'Uyghur', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (791, N'ug-CN', N'Uyghur (China)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (792, N'uk', N'Ukrainian', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (793, N'uk-UA', N'Ukrainian (Ukraine)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (794, N'ur', N'Urdu', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (795, N'ur-IN', N'Urdu (India)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (796, N'ur-PK', N'Urdu (Pakistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (797, N'uz', N'Uzbek', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (798, N'uz-Arab', N'??????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (799, N'uz-Arab-AF', N'?????? (?????????)', 1)
GO
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (800, N'uz-Cyrl', N'Uzbek (Cyrillic)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (801, N'uz-Cyrl-UZ', N'Uzbek (Cyrillic, Uzbekistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (802, N'uz-Latn', N'Uzbek (Latin)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (803, N'uz-Latn-UZ', N'Uzbek (Latin, Uzbekistan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (804, N'vai', N'??', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (805, N'vai-Latn', N'Vai', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (806, N'vai-Latn-LR', N'Vai (Laibhiya)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (807, N'vai-Vaii', N'??', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (808, N'vai-Vaii-LR', N'?? (????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (809, N've', N'Venda', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (810, N've-ZA', N'Venda (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (811, N'vi', N'Vietnamese', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (812, N'vi-VN', N'Vietnamese (Vietnam)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (813, N'vo', N'Volapük', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (814, N'vo-001', N'Volapük (World)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (815, N'vun', N'Kyivunjo', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (816, N'vun-TZ', N'Kyivunjo (Tanzania)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (817, N'wae', N'Walser', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (818, N'wae-CH', N'Walser (Schwiz)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (819, N'wal', N'?????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (820, N'wal-ET', N'????? (?????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (821, N'wo', N'Wolof', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (822, N'wo-SN', N'Wolof (Senegal)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (823, N'xh', N'isiXhosa', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (824, N'xh-ZA', N'isiXhosa (South Africa)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (825, N'xog', N'Olusoga', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (826, N'xog-UG', N'Olusoga (Yuganda)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (827, N'yav', N'nuasue', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (828, N'yav-CM', N'nuasue (Kemelún)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (829, N'yi', N'Yiddish', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (830, N'yi-001', N'Yiddish (World)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (831, N'yo', N'Yoruba', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (832, N'yo-BJ', N'Èdè Yorùbá (Oríl?´ède B?`n?`)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (833, N'yo-NG', N'Yoruba (Nigeria)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (834, N'zgh', N'????????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (835, N'zgh-Tfng', N'????????', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (836, N'zgh-Tfng-MA', N'???????? (??????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (837, N'zh', N'Chinese', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (838, N'zh-CN', N'Chinese (Simplified, China)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (839, N'zh-Hans', N'Chinese (Simplified)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (840, N'zh-Hans-HK', N'?? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (841, N'zh-Hans-MO', N'?? (???????)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (842, N'zh-Hant', N'Chinese (Traditional)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (843, N'zh-HK', N'Chinese (Traditional, Hong Kong SAR)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (844, N'zh-MO', N'Chinese (Traditional, Macao SAR)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (845, N'zh-SG', N'Chinese (Simplified, Singapore)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (846, N'zh-TW', N'Chinese (Traditional, Taiwan)', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (847, N'zu', N'isiZulu', 1)
INSERT [dbo].[ApplicationLocales] ([ApplicationLocaleId], [LocaleCode], [LocaleName], [StatusId]) VALUES (848, N'zu-ZA', N'isiZulu (South Africa)', 1)
SET IDENTITY_INSERT [dbo].[ApplicationLocales] OFF
SET IDENTITY_INSERT [dbo].[ApplicationModules] ON 

INSERT [dbo].[ApplicationModules] ([ApplicationModuleId], [ModuleMasterId], [ParentApplicationModuleId]) VALUES (1, 1, NULL)
SET IDENTITY_INSERT [dbo].[ApplicationModules] OFF
SET IDENTITY_INSERT [dbo].[ApplicationObjects] ON 

INSERT [dbo].[ApplicationObjects] ([ApplicationObjectId], [ApplicationObjectTypeId], [ApplicationObjectName], [StatusId]) VALUES (1, 1, N'Active', 1)
INSERT [dbo].[ApplicationObjects] ([ApplicationObjectId], [ApplicationObjectTypeId], [ApplicationObjectName], [StatusId]) VALUES (3, 1, N'InActive', 1)
INSERT [dbo].[ApplicationObjects] ([ApplicationObjectId], [ApplicationObjectTypeId], [ApplicationObjectName], [StatusId]) VALUES (4, 1, N'Deleted', 1)
SET IDENTITY_INSERT [dbo].[ApplicationObjects] OFF
SET IDENTITY_INSERT [dbo].[ApplicationObjectTypes] ON 

INSERT [dbo].[ApplicationObjectTypes] ([ApplicationObjectTypeId], [ApplicationObjectTypeName], [StatusId]) VALUES (1, N'Status', 1)
SET IDENTITY_INSERT [dbo].[ApplicationObjectTypes] OFF
SET IDENTITY_INSERT [dbo].[ApplicationTimeZones] ON 

INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (1, N'Europe/Andorra', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (2, N'Pacific/Port_Moresby', N'Papua New Guinea (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (3, N'Pacific/Gambier', N'Gambier Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (4, N'Pacific/Marquesas', N'Marquesas Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (5, N'Pacific/Tahiti', N'Society Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (6, N'America/Lima', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (7, N'America/Panama', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (8, N'Asia/Muscat', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (9, N'Pacific/Chatham', N'Chatham Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (10, N'Pacific/Auckland', N'New Zealand (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (11, N'Pacific/Niue', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (12, N'Pacific/Bougainville', N'Bougainville', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (13, N'Pacific/Nauru', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (14, N'Europe/Oslo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (15, N'Europe/Amsterdam', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (16, N'America/Managua', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (17, N'Africa/Lagos', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (18, N'Pacific/Norfolk', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (19, N'Africa/Niamey', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (20, N'Pacific/Noumea', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (21, N'Africa/Windhoek', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (22, N'Africa/Maputo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (23, N'Asia/Kuching', N'Sabah, Sarawak', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (24, N'Asia/Kathmandu', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (25, N'Asia/Manila', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (26, N'Asia/Karachi', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (27, N'Europe/Warsaw', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (28, N'Europe/Samara', N'MSK+01 - Samara, Udmurtia', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (29, N'Europe/Ulyanovsk', N'MSK+01 - Ulyanovsk', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (30, N'Europe/Saratov', N'MSK+01 - Saratov', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (31, N'Europe/Astrakhan', N'MSK+01 - Astrakhan', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (32, N'Europe/Kirov', N'MSK+00 - Kirov', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (33, N'Europe/Volgograd', N'MSK+00 - Volgograd', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (34, N'Europe/Simferopol', N'MSK+00 - Crimea', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (35, N'Europe/Moscow', N'MSK+00 - Moscow area', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (36, N'Europe/Kaliningrad', N'MSK-01 - Kaliningrad', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (37, N'Europe/Belgrade', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (38, N'Europe/Bucharest', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (39, N'Indian/Reunion', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (40, N'Asia/Qatar', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (41, N'America/Asuncion', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (42, N'Pacific/Palau', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (43, N'Atlantic/Azores', N'Azores', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (44, N'Atlantic/Madeira', N'Madeira Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (45, N'Europe/Lisbon', N'Portugal (mainland)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (46, N'Asia/Hebron', N'West Bank', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (47, N'Asia/Gaza', N'Gaza Strip', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (48, N'America/Puerto_Rico', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (49, N'Pacific/Pitcairn', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (50, N'America/Miquelon', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (51, N'Asia/Kuala_Lumpur', N'Malaysia (peninsula)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (52, N'Asia/Yekaterinburg', N'MSK+02 - Urals', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (53, N'America/Bahia_Banderas', N'Central Time - Bahia de Banderas', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (54, N'America/Hermosillo', N'Mountain Standard Time - Sonora', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (55, N'Europe/Podgorica', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (56, N'Europe/Chisinau', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (57, N'Europe/Monaco', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (58, N'Africa/Casablanca', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (59, N'Africa/Tripoli', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (60, N'Europe/Riga', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (61, N'Europe/Luxembourg', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (62, N'Europe/Vilnius', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (63, N'Africa/Maseru', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (64, N'Africa/Monrovia', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (65, N'America/Marigot', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (66, N'Asia/Colombo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (67, N'America/St_Lucia', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (68, N'Asia/Beirut', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (69, N'Asia/Vientiane', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (70, N'Asia/Oral', N'West Kazakhstan', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (71, N'Asia/Atyrau', N'Atyrau/Atirau/Gur''yev', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (72, N'Asia/Aqtau', N'Mangghystau/Mankistau', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (73, N'Asia/Aqtobe', N'Aqtobe/Aktobe', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (74, N'Asia/Qyzylorda', N'Qyzylorda/Kyzylorda/Kzyl-Orda', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (75, N'Asia/Almaty', N'Kazakhstan (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (76, N'America/Cayman', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (77, N'Europe/Vaduz', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (78, N'Indian/Antananarivo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (79, N'Pacific/Majuro', N'Marshall Islands (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (80, N'Pacific/Kwajalein', N'Kwajalein', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (81, N'America/Ojinaga', N'Mountain Time US - Chihuahua (US border)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (82, N'America/Chihuahua', N'Mountain Time - Chihuahua (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (83, N'America/Mazatlan', N'Mountain Time - Baja California Sur, Nayarit, Sinaloa', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (84, N'America/Matamoros', N'Central Time US - Coahuila, Nuevo Leon, Tamaulipas (US border)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (85, N'America/Monterrey', N'Central Time - Durango; Coahuila, Nuevo Leon, Tamaulipas (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (86, N'America/Merida', N'Central Time - Campeche, Yucatan', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (87, N'America/Cancun', N'Eastern Standard Time - Quintana Roo', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (88, N'America/Mexico_City', N'Central Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (89, N'Africa/Blantyre', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (90, N'Indian/Maldives', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (91, N'Indian/Mauritius', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (92, N'Europe/Malta', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (93, N'America/Montserrat', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (94, N'Africa/Nouakchott', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (95, N'America/Martinique', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (96, N'Pacific/Saipan', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (97, N'Asia/Macau', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (98, N'Asia/Choibalsan', N'Dornod, Sukhbaatar', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (99, N'Asia/Hovd', N'Bayan-Olgiy, Govi-Altai, Hovd, Uvs, Zavkhan', 1)
GO
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (100, N'Asia/Ulaanbaatar', N'Mongolia (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (101, N'Asia/Yangon', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (102, N'Africa/Bamako', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (103, N'Europe/Skopje', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (104, N'America/Tijuana', N'Pacific Time US - Baja California', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (105, N'Asia/Kuwait', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (106, N'Asia/Omsk', N'MSK+03 - Omsk', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (107, N'Asia/Barnaul', N'MSK+04 - Altai', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (108, N'America/North_Dakota/Beulah', N'Central - ND (Mercer)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (109, N'America/North_Dakota/New_Salem', N'Central - ND (Morton rural)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (110, N'America/North_Dakota/Center', N'Central - ND (Oliver)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (111, N'America/Menominee', N'Central - MI (Wisconsin border)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (112, N'America/Indiana/Knox', N'Central - IN (Starke)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (113, N'America/Indiana/Tell_City', N'Central - IN (Perry)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (114, N'America/Chicago', N'Central (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (115, N'America/Indiana/Vevay', N'Eastern - IN (Switzerland)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (116, N'America/Indiana/Petersburg', N'Eastern - IN (Pike)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (117, N'America/Indiana/Marengo', N'Eastern - IN (Crawford)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (118, N'America/Denver', N'Mountain (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (119, N'America/Indiana/Winamac', N'Eastern - IN (Pulaski)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (120, N'America/Indiana/Indianapolis', N'Eastern - IN (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (121, N'America/Kentucky/Monticello', N'Eastern - KY (Wayne)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (122, N'America/Kentucky/Louisville', N'Eastern - KY (Louisville area)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (123, N'America/Detroit', N'Eastern - MI (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (124, N'America/New_York', N'Eastern Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (125, N'Pacific/Wake', N'Wake Island', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (126, N'Pacific/Midway', N'Midway Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (127, N'Africa/Kampala', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (128, N'Europe/Zaporozhye', N'Zaporozh''ye/Zaporizhia; Lugansk/Luhansk (east)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (129, N'Europe/Uzhgorod', N'Ruthenia', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (130, N'America/Indiana/Vincennes', N'Eastern - IN (Da, Du, K, Mn)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (131, N'America/Boise', N'Mountain - ID (south); OR (east)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (132, N'America/Phoenix', N'MST - Arizona (except Navajo)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (133, N'America/Los_Angeles', N'Pacific', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (134, N'Africa/Johannesburg', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (135, N'Indian/Mayotte', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (136, N'Asia/Aden', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (137, N'Pacific/Apia', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (138, N'Pacific/Wallis', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (139, N'Pacific/Efate', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (140, N'Asia/Ho_Chi_Minh', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (141, N'America/St_Thomas', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (142, N'America/Tortola', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (143, N'America/Caracas', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (144, N'America/St_Vincent', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (145, N'Europe/Vatican', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (146, N'Asia/Tashkent', N'Uzbekistan (east)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (147, N'Asia/Samarkand', N'Uzbekistan (west)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (148, N'America/Montevideo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (149, N'Pacific/Honolulu', N'Hawaii', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (150, N'America/Adak', N'Aleutian Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (151, N'America/Nome', N'Alaska (west)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (152, N'America/Yakutat', N'Alaska - Yakutat', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (153, N'America/Metlakatla', N'Alaska - Annette Island', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (154, N'America/Sitka', N'Alaska - Sitka area', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (155, N'America/Juneau', N'Alaska - Juneau area', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (156, N'America/Anchorage', N'Alaska (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (157, N'Europe/Kiev', N'Ukraine (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (158, N'Asia/Novosibirsk', N'MSK+04 - Novosibirsk', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (159, N'Africa/Dar_es_Salaam', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (160, N'Pacific/Funafuti', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (161, N'Atlantic/St_Helena', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (162, N'Asia/Singapore', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (163, N'Europe/Stockholm', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (164, N'Africa/Khartoum', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (165, N'Indian/Mahe', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (166, N'Pacific/Guadalcanal', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (167, N'Asia/Riyadh', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (168, N'Africa/Kigali', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (169, N'Asia/Anadyr', N'MSK+09 - Bering Sea', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (170, N'Asia/Kamchatka', N'MSK+09 - Kamchatka', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (171, N'Europe/Ljubljana', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (172, N'Asia/Srednekolymsk', N'MSK+08 - Sakha (E); North Kuril Is', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (173, N'Asia/Magadan', N'MSK+08 - Magadan', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (174, N'Asia/Ust-Nera', N'MSK+07 - Oymyakonsky', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (175, N'Asia/Vladivostok', N'MSK+07 - Amur River', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (176, N'Asia/Khandyga', N'MSK+06 - Tomponsky, Ust-Maysky', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (177, N'Asia/Yakutsk', N'MSK+06 - Lena River', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (178, N'Asia/Chita', N'MSK+06 - Zabaykalsky', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (179, N'Asia/Irkutsk', N'MSK+05 - Irkutsk, Buryatia', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (180, N'Asia/Krasnoyarsk', N'MSK+04 - Krasnoyarsk area', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (181, N'Asia/Novokuznetsk', N'MSK+04 - Kemerovo', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (182, N'Asia/Tomsk', N'MSK+04 - Tomsk', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (183, N'Asia/Sakhalin', N'MSK+08 - Sakhalin Island', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (184, N'Arctic/Longyearbyen', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (185, N'Europe/Bratislava', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (186, N'Africa/Freetown', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (187, N'America/Port_of_Spain', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (188, N'Europe/Istanbul', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (189, N'Pacific/Tongatapu', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (190, N'Africa/Tunis', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (191, N'Asia/Ashgabat', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (192, N'Asia/Dili', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (193, N'Pacific/Fakaofo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (194, N'Asia/Dushanbe', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (195, N'Asia/Bangkok', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (196, N'Africa/Lome', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (197, N'Indian/Kerguelen', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (198, N'Africa/Ndjamena', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (199, N'America/Grand_Turk', N'', 1)
GO
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (200, N'Africa/Mbabane', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (201, N'Asia/Damascus', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (202, N'America/Lower_Princes', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (203, N'America/El_Salvador', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (204, N'Africa/Sao_Tome', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (205, N'Africa/Juba', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (206, N'America/Paramaribo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (207, N'Africa/Mogadishu', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (208, N'Africa/Dakar', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (209, N'Europe/San_Marino', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (210, N'Asia/Taipei', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (211, N'Asia/Seoul', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (212, N'Asia/Pyongyang', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (213, N'America/St_Kitts', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (214, N'America/Manaus', N'Amazonas (east)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (215, N'America/Boa_Vista', N'Roraima', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (216, N'America/Porto_Velho', N'Rondonia', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (217, N'America/Santarem', N'Para (west)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (218, N'America/Cuiaba', N'Mato Grosso', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (219, N'America/Campo_Grande', N'Mato Grosso do Sul', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (220, N'America/Sao_Paulo', N'Brazil (southeast: GO, DF, MG, ES, RJ, SP, PR, SC, RS)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (221, N'America/Bahia', N'Bahia', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (222, N'America/Maceio', N'Alagoas, Sergipe', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (223, N'America/Araguaina', N'Tocantins', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (224, N'America/Eirunepe', N'Amazonas (west)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (225, N'America/Recife', N'Pernambuco', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (226, N'America/Belem', N'Para (east); Amapa', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (227, N'America/Noronha', N'Atlantic islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (228, N'America/Kralendijk', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (229, N'America/La_Paz', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (230, N'Asia/Brunei', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (231, N'Atlantic/Bermuda', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (232, N'America/St_Barthelemy', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (233, N'Africa/Porto-Novo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (234, N'Africa/Bujumbura', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (235, N'Asia/Bahrain', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (236, N'America/Fortaleza', N'Brazil (northeast: MA, PI, CE, RN, PB)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (237, N'America/Rio_Branco', N'Acre', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (238, N'America/Nassau', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (239, N'Asia/Thimphu', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (240, N'America/Cambridge_Bay', N'Mountain - NU (west)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (241, N'America/Edmonton', N'Mountain - AB; BC (E); SK (W)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (242, N'America/Swift_Current', N'CST - SK (midwest)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (243, N'America/Regina', N'CST - SK (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (244, N'America/Rankin_Inlet', N'Central - NU (central)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (245, N'America/Resolute', N'Central - NU (Resolute)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (246, N'America/Rainy_River', N'Central - ON (Rainy R, Ft Frances)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (247, N'America/Winnipeg', N'Central - ON (west); Manitoba', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (248, N'America/Atikokan', N'EST - ON (Atikokan); NU (Coral H)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (249, N'America/Pangnirtung', N'Eastern - NU (Pangnirtung)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (250, N'America/Iqaluit', N'Eastern - NU (most east areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (251, N'America/Thunder_Bay', N'Eastern - ON (Thunder Bay)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (252, N'America/Nipigon', N'Eastern - ON, QC (no DST 1967-73)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (253, N'America/Toronto', N'Eastern - ON, QC (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (254, N'America/Blanc-Sablon', N'AST - QC (Lower North Shore)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (255, N'America/Goose_Bay', N'Atlantic - Labrador (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (256, N'America/Moncton', N'Atlantic - New Brunswick', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (257, N'America/Glace_Bay', N'Atlantic - NS (Cape Breton)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (258, N'America/Halifax', N'Atlantic - NS (most areas); PE', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (259, N'America/St_Johns', N'Newfoundland; Labrador (southeast)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (260, N'America/Belize', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (261, N'Europe/Minsk', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (262, N'Africa/Gaborone', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (263, N'Europe/Sofia', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (264, N'America/Yellowknife', N'Mountain - NT (central)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (265, N'Africa/Ouagadougou', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (266, N'Asia/Dhaka', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (267, N'America/Argentina/Tucuman', N'Tucuman (TM)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (268, N'America/Argentina/Jujuy', N'Jujuy (JY)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (269, N'America/Argentina/Salta', N'Salta (SA, LP, NQ, RN)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (270, N'America/Argentina/Cordoba', N'Argentina (most areas: CB, CC, CN, ER, FM, MN, SE, SF)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (271, N'America/Argentina/Buenos_Aires', N'Buenos Aires (BA, CF)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (272, N'Antarctica/Vostok', N'Vostok', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (273, N'Antarctica/Troll', N'Troll', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (274, N'Antarctica/Syowa', N'Syowa', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (275, N'Antarctica/Rothera', N'Rothera', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (276, N'Antarctica/Palmer', N'Palmer', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (277, N'America/Argentina/Catamarca', N'Catamarca (CT); Chubut (CH)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (278, N'Antarctica/Mawson', N'Mawson', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (279, N'Antarctica/Davis', N'Davis', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (280, N'Antarctica/Casey', N'Casey', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (281, N'Antarctica/McMurdo', N'New Zealand time - McMurdo, South Pole', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (282, N'Africa/Luanda', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (283, N'Asia/Yerevan', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (284, N'Europe/Tirane', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (285, N'America/Anguilla', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (286, N'America/Antigua', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (287, N'Asia/Kabul', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (288, N'Asia/Dubai', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (289, N'Antarctica/DumontDUrville', N'Dumont-d''Urville', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (290, N'America/Argentina/La_Rioja', N'La Rioja (LR)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (291, N'America/Argentina/San_Juan', N'San Juan (SJ)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (292, N'America/Argentina/Mendoza', N'Mendoza (MZ)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (293, N'America/Barbados', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (294, N'Europe/Sarajevo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (295, N'Asia/Baku', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (296, N'Europe/Mariehamn', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (297, N'America/Aruba', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (298, N'Australia/Eucla', N'W. Australia Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (299, N'Australia/Perth', N'W. Australia Standard Time', 1)
GO
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (300, N'Australia/Darwin', N'AUS Central Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (301, N'Australia/Adelaide', N'Cen. Australia Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (302, N'Australia/Lindeman', N'AUS Eastern Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (303, N'Australia/Brisbane', N'E. Australia Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (304, N'Australia/Broken_Hill', N'AUS Central Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (305, N'Australia/Sydney', N'AUS Eastern Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (306, N'Australia/Melbourne', N'AUS Eastern Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (307, N'Australia/Currie', N'AUS Eastern Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (308, N'Australia/Hobart', N'Tasmania Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (309, N'Antarctica/Macquarie', N'Macquarie Island', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (310, N'Australia/Lord_Howe', N'Lord Howe Standard Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (311, N'Europe/Vienna', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (312, N'Pacific/Pago_Pago', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (313, N'America/Argentina/Ushuaia', N'Tierra del Fuego (TF)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (314, N'America/Argentina/Rio_Gallegos', N'Santa Cruz (SC)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (315, N'America/Argentina/San_Luis', N'San Luis (SL)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (316, N'Europe/Brussels', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (317, N'America/Inuvik', N'Mountain - NT (west)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (318, N'America/Creston', N'MST - BC (Creston)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (319, N'America/Dawson_Creek', N'MST - BC (Dawson Cr, Ft St John)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (320, N'America/Tegucigalpa', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (321, N'Asia/Hong_Kong', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (322, N'America/Guyana', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (323, N'Africa/Bissau', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (324, N'Pacific/Guam', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (325, N'America/Guatemala', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (326, N'Atlantic/South_Georgia', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (327, N'Europe/Athens', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (328, N'Africa/Malabo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (329, N'America/Guadeloupe', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (330, N'Europe/Zagreb', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (331, N'Africa/Conakry', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (332, N'America/Thule', N'Thule/Pituffik', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (333, N'America/Scoresbysund', N'Scoresbysund/Ittoqqortoormiit', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (334, N'America/Danmarkshavn', N'National Park (east coast)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (335, N'America/Godthab', N'Greenland (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (336, N'Europe/Gibraltar', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (337, N'Africa/Accra', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (338, N'Europe/Guernsey', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (339, N'America/Cayenne', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (340, N'Asia/Tbilisi', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (341, N'America/Grenada', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (342, N'Africa/Banjul', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (343, N'America/Port-au-Prince', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (344, N'Europe/Budapest', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (345, N'Asia/Jakarta', N'Java, Sumatra', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (346, N'Indian/Comoro', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (347, N'Pacific/Kiritimati', N'Line Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (348, N'Pacific/Enderbury', N'Phoenix Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (349, N'Pacific/Tarawa', N'Gilbert Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (350, N'Asia/Phnom_Penh', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (351, N'Asia/Bishkek', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (352, N'Africa/Nairobi', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (353, N'Asia/Tokyo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (354, N'Asia/Amman', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (355, N'America/Jamaica', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (356, N'Europe/Jersey', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (357, N'Europe/Rome', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (358, N'Atlantic/Reykjavik', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (359, N'Asia/Tehran', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (360, N'Asia/Baghdad', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (361, N'Indian/Chagos', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (362, N'Asia/Kolkata', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (363, N'Europe/Isle_of_Man', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (364, N'Asia/Jerusalem', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (365, N'Europe/Dublin', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (366, N'Asia/Jayapura', N'New Guinea (West Papua / Irian Jaya); Malukus/Moluccas', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (367, N'Asia/Makassar', N'Borneo (east, south); Sulawesi/Celebes, Bali, Nusa Tengarra; Timor (west)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (368, N'Asia/Pontianak', N'Borneo (west, central)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (369, N'Europe/London', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (370, N'Africa/Libreville', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (371, N'Europe/Paris', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (372, N'Atlantic/Faroe', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (373, N'America/Curacao', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (374, N'Atlantic/Cape_Verde', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (375, N'America/Havana', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (376, N'America/Costa_Rica', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (377, N'America/Bogota', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (378, N'Asia/Urumqi', N'Xinjiang Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (379, N'Asia/Shanghai', N'Beijing Time', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (380, N'Africa/Douala', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (381, N'Pacific/Easter', N'Easter Island', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (382, N'America/Punta_Arenas', N'Region of Magallanes', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (383, N'America/Santiago', N'Chile (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (384, N'Pacific/Rarotonga', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (385, N'Africa/Abidjan', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (386, N'Europe/Zurich', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (387, N'Africa/Brazzaville', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (388, N'Africa/Bangui', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (389, N'Africa/Lubumbashi', N'Dem. Rep. of Congo (east)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (390, N'Africa/Kinshasa', N'Dem. Rep. of Congo (west)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (391, N'Indian/Cocos', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (392, N'America/Dawson', N'Pacific - Yukon (north)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (393, N'America/Whitehorse', N'Pacific - Yukon (south)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (394, N'America/Vancouver', N'Pacific - BC (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (395, N'America/Fort_Nelson', N'MST - BC (Ft Nelson)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (396, N'Indian/Christmas', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (397, N'Africa/Lusaka', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (398, N'Asia/Nicosia', N'Cyprus (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (399, N'Europe/Prague', N'', 1)
GO
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (400, N'Pacific/Kosrae', N'Kosrae', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (401, N'Pacific/Pohnpei', N'Pohnpei/Ponape', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (402, N'Pacific/Chuuk', N'Chuuk/Truk, Yap', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (403, N'Atlantic/Stanley', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (404, N'Pacific/Fiji', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (405, N'Europe/Helsinki', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (406, N'Africa/Addis_Ababa', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (407, N'Atlantic/Canary', N'Canary Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (408, N'Africa/Ceuta', N'Ceuta, Melilla', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (409, N'Europe/Madrid', N'Spain (mainland)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (410, N'Africa/Asmara', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (411, N'Africa/El_Aaiun', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (412, N'Africa/Cairo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (413, N'Europe/Tallinn', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (414, N'Pacific/Galapagos', N'Galapagos Islands', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (415, N'America/Guayaquil', N'Ecuador (mainland)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (416, N'Africa/Algiers', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (417, N'America/Santo_Domingo', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (418, N'America/Dominica', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (419, N'Europe/Copenhagen', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (420, N'Africa/Djibouti', N'', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (421, N'Europe/Busingen', N'Busingen', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (422, N'Europe/Berlin', N'Germany (most areas)', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (423, N'Asia/Famagusta', N'Northern Cyprus', 1)
INSERT [dbo].[ApplicationTimeZones] ([ApplicationTimeZoneId], [ApplicationTimeZoneName], [Comment], [StatusId]) VALUES (424, N'Africa/Harare', N'', 1)
SET IDENTITY_INSERT [dbo].[ApplicationTimeZones] OFF
SET IDENTITY_INSERT [dbo].[ApplicationUserTokens] ON 

INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (1, 5, N'MQ9cPdCKp9Kfy1q2wAdwPpS/kU/Z0iflqxfJkgVyC5g=', N'CfDJ8GaXerj857JJvdOfhqCqicBjPUemabo2lW6VnJmvT_eD0fozFhBxA2iB3F8sSzVR4V_K_ndTLoSBxGJP2fUnE9QzF6HV-HXQgG-T6GudGwuL4Cr-IbiAfYjl20ekNrGR0FQmiZs4D6-XO0M84I1wvccX_2lxt9G-_bjCIHhjnE9D4DYAeDQye_z040qr3ZXbjmh5Y01E8ZF9Au_OZ4mXETyxA1NFDRc589ys53pf43p7TW0xh9tgSQZuqJZaYZ1Iuws_o3UKx-HnnSqLCi7MYN3tulG2ijthSHtdf9DJZIW9gLwWfM13v2AdnzvUqZ1eyW3P4LlafPdfhW4YPL159eM7dkb8gzWBc3OorMBaR9MU6-tv5u8c4bjZuw7NUuQpc0vuByREM19HFDMcDXP7QgiyeB3HvbC09peT7VeZLMM57j8JvmQwCsg-nUjNx25Q6-x6LM2rrnKUUYAh9F29mnYu2AZO_HPuwufSCuhsl6QyXcuGIR0KcJzcS0uoC-0bJGaF9vwXzYNDfEdOop6WvkO3_HG1kqq6wTO0TEm7On2jUE5ZtoUqZ66ScliwkCY2WhIT9I8J8zAE7WXbtkp4Sf2uvLgNTj55oGKw0ibCoCxsAd4O34VaH4lLx-Wrj4YUiFa8XzuVAns08AI39SY1y2yeU1Nym9a6QFxWTaSZRkDn8qWyak4I39ILV9NQW_5bdb4j6htXFXLpSN_OVEf2ijM', N'web', CAST(N'2020-01-28T12:45:36.5081875+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (2, 5, N'HdxK2ZiqYZs0ReNnkOOf+4LyNmjeLY1/fps9WbiN3mU=', N'CfDJ8GaXerj857JJvdOfhqCqicDtALEKEm6laXtxmC4JAYfn6NcSIVpehER3lA8sgUUH6-XCa4Rv04YexqFvh5Lj8yea1Mwhb_27E9w-MWQ47Sshii3DCzxE-z-BzIs_UKvMyab6b26nVoITgqGTXRLIBdHkjJLLWI_Jwsk98DVGI5TjvxtJ-L6sr-EcC71oAf4U6UB5nNHZPwo3xBTlMHQtLX5XHslwAzOsjjDLBKaRYEiMfXdjDgW-ARDEbuoSeKnFkjHC6L-wbegqY1UwtjOHpwpbPAOgySzNb5I-0PiVBzttSXSg7W8QGRpo0vgW0JYpLUu2pHkqndkBijHHWqPsooR--GR9EHOixXuiEGpITPaB2jl_YXuHP6tmz3m_bBDZaB3V_aUyZUztQ62FukvwhhiYC-fh7GE2Ut-1r8kB5W7H--NA4UoMc_I1yv6WMuMNOoZmNUGN0YAbLVmsK3HxrkqcLKM1G_eKBamJRYE28jDRAqc4kZe5cguUgK7Q75ML-cVVA_J_M9w3aDVXP13AekP3rLXNWYGuHAAbYwBKd0W-ZGlwG9HPzEwt1M4hqjE2DMp_s0X5XJ0RzYbNz54aSFe7pez-VjUtGME73HEck6eF6bGhLLkTmumWM79zXdZm_kdmW3pfODXMOHelcZ45H9iGagsMuOnLX5tkj9mdQw9NdZFrJfMZjJ2bvrwFHp_WWDPywPVJlydRRsJVCFqtD6s', N'web', CAST(N'2020-01-30T06:46:31.3081228+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (3, 5, N'EAvJTuf55AOe41XrjoLva4RJt+JIWFk7Sz1ZJOWAXpk=', N'CfDJ8NctXcruCgNIoRmA-kk38t_ezxX9JqgfJtY5fT2dKXVBtaGCX87b_EZS6NmxJk-L3MyXzt44PWmAq9GD7FuS5BoDWShc-juW8X6W-0hvzWG0Ury36YHBu7pdzC5NmFQNf6kmw8nG1Y762rx9bVksRFjlqmlpkz_sNunuJrnPnezpAl4efu40OXR96aODs4eLptWZY-b9ecIfZGal26nuUyPjqPKrXR5e4-ToFksQDz2opHRNKnYE3K3-g9BTC5KKt0mo5QnMuQZ5h85-jltkp8HenSF_DRrtZ-GqUUiMS2-BO63X7CA-akDQ0aoRlakNmj_4nLmHldwaEwWnAEal2IZHbJBuFs_J7mPNoPNvbUeIMuzmhWChqC1ODdwkL7az0QEDk2cpDDVgXBRxrB2OaEjq18p2VoSbpHP_wbJVKpdXbWs1nw9TrIMUexAbKzK6DSWfaA8XZ0Unfc6zsmKPuFPK-Wk93kX2tbmSUUbWWuj3PpZ4Y6g00IIix4CWAlLWAY4NUQvw856F4pHeItdyZcQYuiezl3M6mt9J67CUIOoUmPzU9W7WDAilQ0bPpoL19jaSF6ZJf3LQ2pl6K6qKn4BMQDIOLe7ZhGSn5XLKjlAvW8iNLJKBDORnO2R2YzYOyubLoTLl5qVEmrKuT65OH9xdrsJdfhuOqrlrPhoJ6K42BbDnx0fvs9IjIqsQngoWiIGeUTppzf_5CR0ujCvIKuk', N'web', CAST(N'2020-01-31T07:18:51.4495194+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (4, 5, N'/6BBSE6siI2l0pPWP/AhPDkMmaqCJzaluxGJG8taPNg=', N'CfDJ8GaXerj857JJvdOfhqCqicBoBAV79PES7CSbEOUey7riG5e2uRpuJQPMg1cb5LzHFLuss7jO438pakakbWic2Oi4DwZniR_mMjp77jHofowEinm4hC3iAZ3qFfPrEPXj-E2OU8Jdt4qQhFF2W4HyYOl4_jH9Sub4Tcjxy5hakYgGk6W68NsIQJ-vMYuR15JFLYlo5H6N5wVDzWvSfH2r6WnvCS3soJedNHrl20xK2qgvxvDuHg-mL3CnRt2nDSKC1rV9f3p4pfO-EH21EmvysvmJnrguT8N2Z0hNBmwq8u0r1y0wUL_F2Io8TKy6M-w57qatblmz7Px9OtUwlLGJ46-_gft2nWCrSddAXMHhvC0xwOHZl5d23QSDfnYu6Re7kVTUjtlxF3VaTya0r-cw4Lbm6GDzjTjfgR-KhLeybnLgRO3EtZLdzsHN7bFwqycoXh-SJZ11Uyzayuih1eTk3En3Kex6IVg8dzZQIZ2lO8EjXpi_UABJ-XjwKuYfJTC4OVfKZJoBJ6erzfMBd_MpjufSWb6utAJrsWKogbC-SE2uqDfarXIVgt0E8FpBsiKOBP7LIEvs0YodLS34pmWLtnGMDLi6GBJZGCIUqlRChao3Mw26T3s57FM3rUn_A4SHSkLqGNX9Tyn9xH2XnSA992f-GZoU4QPiPfO1fvMeUnYrZQCn5Z9R1VJiGyOeg6fZ6ZVet5mniIHI9EcMwJkWSs4', N'web', CAST(N'2020-01-31T08:33:46.3463453+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (5, 5, N'+3cMC9hwEBd97a4Un1rzWnAPFyIE8Qv5lH91gn2moI8=', N'CfDJ8GaXerj857JJvdOfhqCqicCoGMTGhpKD5tG1uHoXTTAUh3COk437JkkrD3z6X5nqCI_2Udca4RgE6tpLttbkdUG4KWF0kNm8T-_bVwNE90MMF1NrwP0wbpRNwWDXPMyPDXzdPBlimVzbLuGvm_hYpzE7ltDwR3JHrhwpKJT_S6Oeo75KI1RIPu8H9JGTyOcr6YAXGqLI6IOC7-HW3Sl9QqK-qedwRh3ZPi5IWliPPZP-hpRjNMlFKSx6-LgC0O58uzUysmSRPECIOjh5XE335ynRNjb9q75qvb8bVSWEt4BVi6vRnbTDppFEkUW3U6Js6zCtihAWu9JTTILU1HszcL4a6vA2qlDvo3KpmRMjiEPRoiMIH-lg-7qImI_30-EKAnsWPuvzmHnkq756dcI_Wzkj9_jP2SIyVOewB_roA8mSmqI7_C1wgLOksxO1m8dSuZnB3JqFVh8zWa2sW37rk5J3_JUmL5_pnPZp3g75caymtCWHNH0DIcS20tyDO4J8MoMGlOuzr_vYmviV6qaFq8C_pmNOKFpFu2ctlioPRfTTX-Ju2-_B1oMvKkWe-0X0kfhEuKFUZCiSCnMyepOzwwHTd0iLy6BCtCHl6ABCZoJGIZyv9ix9KoLnIHNeu4mr_mE1KZ7K7erW3O3pXd4VVhzNxsO4eskd_V-afUn-RuUhlFn_Hp9xr6IMleoG73ZYIdZe7LzC3RGM9boxhKVPXBA', N'web', CAST(N'2020-01-31T08:41:14.8319690+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (6, 5, N'Z3W18Qv6TO8Zpcpf76hgJoPQ95SM/OhDB1mJX+WNJd8=', N'CfDJ8GaXerj857JJvdOfhqCqicDYTfRqx589LYuNcwai676mEQd8laYyY9IzqnGReVTs7nAohSn9SJIbBT7QLma9f8MmU42QpKNA1l_QwWEgDwcuLiBrh5mjTpU5dLuKQr7PTYNFQrixELT6-EEKbFwKQp-jEAN_Ke62sWSIlJ5wMU6lf69IR_iBQJUqKt-NtPMAtx80XJhpv2awURYh11PxV4koqShcHu7KJvZ-xg79pUvFHZbAizgxr2SvWuHRwPPCmxt_XtJZEMHPWM6KStVapFAJAOEwomTNwQ43adOjtrKZnGp0yaLRuIR5OBuhP3eDJd5_IWmI0B7Fr92oTbo7md1kLlhiJiHObDADcKGJhDYs8xAkyHW-WdbfDrMbcJu4wCEwdQ1aD8vAKr7DMpiK4Zl2evhfLuHo1dqFrE3mpCLYtSWowfwAlQsHLX_UfMcDHP68Zji4vcZB7h-IKEzwidhrG5fSSiziTDWiThBXThM9EitxLMG8TGfFKm5bj0eBq21FBS-sajFpr33EvW-VbVlPR3IkKz7rzwd_0j4BT-M6Lp2BUuq7NEIB82iLJy2dpF9bD9atVMH2HJQKRsj7fs81Y-FkE4QkuCYgTDiaY1cXwrTVG6cfOuWWR6qrp5TtMRsMJQVQ1DsdnjlqBIJmvlHzZSEUggBPNjZTRXjwD_qvACWy8J9bIo2htBSZ66vasMaG_oOqLLbd-ytihR8rNBc', N'web', CAST(N'2020-01-31T08:46:53.7531589+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (7, 5, N'C7Rw07MwOS4WRYghVP5xiz3JnZWZZLq0mPNFZXyixo8=', N'CfDJ8GaXerj857JJvdOfhqCqicCzIkFg1xraZSJCMDQvkBNL7aRkb_eT6PMo01LOV361JFa-1XzOCzunD0LreH_VtuduwtkjGXkVGDPY6oB6KYI8dTJVxEKYp6lU2eiBJioVBPHlF0QRkXZrx8g2uyzssvpKR5J9plJ4H3onp8zRmc8dRE42WimdUk4e5hPUudapDP3KnnAPVw2VRGgHm3bs9xEemmJAAq6eTxmSxpEK1OGCQaHS26ezw5ohAt0WI05szys1jJXEEjnY7OOCH2mKKrjP2WKi9zJ97bZLC0y5fpxMVs0UDdVe5yHwyTMjJ3NIm48ngd_hMbMqSKMxBhGdWo6BVwmjtZd9F3Hfb3deJn7Zjp7kwtXkZ8F5FhE8wLW6CImTfkmxjuHTtIsCtW7gtwVCkJII8oZ_wxeGK_7SN8S_sJicMDp_j_cH6NgeyYu8VjStwS7nXSteRB69zejxochymuP--LE8GHfLcrqo1touAuuyQyrDEVDFCW7YNuwVlJ11PIskZyjIvVQz4WPuSkuXLN1nnB6xK-tP-G45FRZXmKN-Wonjxx8kvLGrju_JegyS2SpEnTt4EORj5e7O9VjsedWO0dWN7poRh_2gy5qlnT87lV_81QjZqMlmW9GawYEsTdB0Y5vOPOyE0EqpndOB50pV6Rh6nQldiuc_haFFOf4Pen7iWXeg9W8Fw2TN4iyA_a8wlHMUNz4mExtM1ag', N'web', CAST(N'2020-01-31T09:06:01.2600099+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (8, 5, N'vVXw62cxp90WQf3ymu5H6GvGEyuX3zXgOwQGD0eD1PM=', N'CfDJ8GaXerj857JJvdOfhqCqicC4BtTEfGyqxjyF1Rfwtq6xiDqCK0pyMgYm-Kg3g63oebkwVI7PYp94jvt0uu_3DVCJmyMNP1ti7iPgz_AcDhaZZJmUmX9m85ReASdFKWj-zCAlcwaqHNOUWKLeGeeFG7v7jeRJC0F3ViVexP8HHgy0ZClGan5GWNi5Ie3hjy9ThSUiQAsgFpYuIC5p_uRHqN1AdKvb_ywgDV5EE4q7hovspkjRksDqRxlm6As9CTwpRaZK_5i2-es_ehcKxQ9VNeFlcF4RShr7KtehibVsEH46IFONu09hntbnWtJDDt2BOlQwfeDZVuiHUFeNn4GwjhC55zA5b8s048IFY0lK1qYW8gXKLRSjvUgtEeFmByDJ2gywTrTkhEufEvDzu4MMiFtI7mCEt3f-j8j9rzPCMvho8K-PC5Mtbjn1pij4UbNIpiwY5PJ4Q9csIbs1DLS_1cyOcaU0mvIY9QVJsB-Mhb7LtvIj4UWm181tQwkyg9Qi_7thsabvrRL03OLJHQSkPWHjgSAV-BpZZ1hzJc8DFev6IkvpX1tB6NxMpRtoI9fDZV0KSZ8XtfH7lwoZV7uozBlbCcPl4GzuwF56ZHWBRAgD6ik2ORHPD1G84OwKdBFBH-ulMOhwHi8uI0au6xsWhFnpaRUnIffCYBRFtcgFmTVquRMqj94zgMnWbYbk7chpzjH9PSVHljKM_9-vpD5eGa0', N'web', CAST(N'2020-01-31T09:13:57.5654287+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (9, 5, N'ITz98OxHMxZBdhqDAcXUXJFWncrcDiy7up4wV9QtC7I=', N'CfDJ8GaXerj857JJvdOfhqCqicAeDYTgtn93dHC178A89meNuUM450u4gWNwU0Z2WWiaenx8gnFVISFAV66KVejGXpFVbFWEUncOEtrItL2RlzQ96Bzv4DgqWiZjVr4F4gl2uLwuB3acx-tla6mZNKFjtZfeaEP9rq7RQFRq8DLqsLG6x83fM1Wtv_sMT1PphHOoMqEreVMXoBVHXNutngshUSl_i25Q1rnXps-fiStOkIEG8RFzF5z4rBgMAhybj2e9cX2HG4uQn_sOJAsmhUgSEy2IkYUZwTpTCv8kM79XLSz8ERdyOZgVlew2MLlfO8nmPxEdGFJ5OXhbV6XnT6Rw4S0tE1QJErI0pYE8-lZRFpLJE7q6EeTxw9NalXO2Cyzyj9Suinw-xjfHSm3AYGFEVdLTs7kdi0AiKwg4y0P1mjqEdZf1uod1BQVna2s3ZhnQ65P2Owu2LbGl2BPaw0Fp_rYNbkWHYVBEQ70p41o3cnc4OqMCLjCru3rTx6LkLwT3t1gynxK2N7oH6j_V1wxmwm1fvl9pXevlLjhdzqmduNLfaci0VXritu-Pq2tKhjkiiyMBZ8UYVXd7LPGkijvZVRLz3tu1PPR2UYwAaoAiHQe8599WakXCuARDSb5eLX8Tpo6KgTMTzXEJ4BFYo5Xb2Dp24mMqaXvi1xz9sOYSzLJzdO0w5Cnt1Bz6jXuvNRJmoEse3NT2hijIgCWE6LuB-og', N'web', CAST(N'2020-01-31T09:49:24.4278888+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (10, 5, N'w4uJRrvrRnQtby5xEay4+ZS8V9isPtEJ6qnsBjQyEEo=', N'CfDJ8GaXerj857JJvdOfhqCqicBXDldOfvLZ-cwszZNnFS1M_92ubUGLKCa1fqKnRDaRbvQrLqbnjtTcX98rFvrPZ6Ub96bKjuc9XKPw2Iyp6TUwep9hb7lps5olahu7LZp6tx6nv2Y2-Mnxs_wty_qol2IxkGUgNnuY2e3sSmLwKUpYlhlurdw88at4gXAGm71Ww7ZcWY87KX0VpthXByhNaEliWLWHHmdB3DbkxwXr5Gc9iyNfGZ8FaUXmr4EYM5rP8zkOJuFUlFVN3bt3saRYErW4Dn5ukQeh6r4Qg9w8ExNSI6TyJ6vbl382qO3YrKhW47G-WCefjAcGgwYXFk_uUEFU4het6vJlWlAQoDjoMNXXCESiha_Ub8GS9XCDqtxLJX-2nu4Eq6jNFcQjTGsg17hCID4_JLGyHRqRxO62uBjXNyGnL03NGJ_SCI1_r1imzZDFrxdX9DA23uASexvsfQmgqpbCLp_ScrAK-qlBv4d_r9MJjXcBoMbf4iXtParhW2QhBrAx-RRp6U8OGqx4Ln5xCMCDRuHrgizoHQJRlS18SzUsy5qF41tdkRzQmkIGXBpRdfWDckjRkRi1HRN6s3VMWfDdTWhGcU1_l3ZQxlhNEnKFp6szH8dtiAW1mx5Ah0QBuAPpnl2k1Q02CPX56VD5AJs6YmNK6xIpbDdyjTdUIyjJ1ZQi-2IWomEnMMmJ3aY1irQWuOVI9wYyPnR210A', N'web', CAST(N'2020-01-31T09:58:13.5299710+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (11, 5, N'eAvtPtzVFMIvuNgjEviTxuzMGqTIFjDDb6Qs2vnB/eE=', N'CfDJ8GaXerj857JJvdOfhqCqicBRP3ynwReQMFWD4YGCdWd20vBL6JqVwHOtqRF_EnrGHElXREHKBhx4rcqFJTaWr1946fkLOU2d1aoebtovabJwWKupRkNR1voF6dqb90BUgtYfdHH3D3eOuCm0mC1-PAMoyiNWCnGvgNJUWKxbUIAAa9uJnlYZjEADQvjwmgDS2od-EgGoy0Vd6ygVN5O6ev47OllGdtSyXNIoMnKVDpP7qQ92r2Pd85MLOQDY8VLlSA3eTFSbhQsiC-AaecQBjRK2bfNpBTXco0ZjJfDKxNV_6PoMMbnKMmr6eeihFe7ZsxVojNo0OW_E6vFvzgmrSIfwzBKdOO6AN1TXCQJK_C5COWVYWCEO1HVO3SVBnZ5ywPS8HTayqz3ntB3usBSCyPDtnFrowIdN1YQAhq4_LPEjoECsICF5L2pvzXtP0MrfUI7FYDQR1g-vopgDBMz-Raf8iYQ-pIjekhW0QkEeaPMXtmH1NcmRA0PB3TM05QP5csoy5szj8sM-8Jca_rOcGo374_QdTXHBR83CWFYdMbgSSGx3467tx7Gqfl8-i9YE7pELxzLimMJNQUl-kG7GIeFK4pv5Y1Nqn-PeaHnfR0yqIaAVPq0jf2JH3KjHNW5oy6RSsgHZMIwYRQ_fl3hLkcvZf3n7dnzF6lKn1TMNjBJan_IXVeR5QfSLX9gj575KhNNg9hRASZw0PtL6bwBkI3c', N'web', CAST(N'2020-01-31T10:16:01.2707902+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (12, 5, N'xwaNVE5SE9hOxU5wSWa2XN4CVlS345wzwKTteKx/uvA=', N'CfDJ8GaXerj857JJvdOfhqCqicCQC_nVVYkNKKonrQm4pCfrfZFJ1u1Yl1AhFyHG4qbin-YVr6DSZl-g1rws2ZFdRNfhu2GDA9OinN00B8j9jG2efMUaC2OMXvTJmeIkwb8Hq7ucoPtx9uV7nqtehuXF1a2Zg5IFAWDXLcejr7IHwD6C4HOz3WjBKs2-CrV3bKC82sZ0QGnRA3Pis6Du2Q9SdSYrMkY-82aVCxziDsijx0i6am-F5wC3EDg0IcJVg39d7WqQfWDzPksRQkq4kZcKUqQGiSOvnXGuaBdwl8AcwM_IpFoo3DSoViN3PaJQXh6HWTH8VljUGEIOO0BufhMoJK8sfUEBiFKORtrT0DYPLrwJIZBVNJv9xfR2DOpUflKqy4S1mZFb4FWHToP5wqmVVQ_DaeleUrgeXuHCYreI6j_-pCklx1Xo6z6WaIDs41cbMPZbhHG68Gvs71gVSqPeEj7uov44nSAIhg_FJBZYJknf_C7lnUxPUUUNdxhyJb6H81hrWbnClSfNvUvy3MBrP419sr0vtdfSbo7IbGz81JQWSK7yjW8ltzSBs1c_tLkM0fSrgyjnJoUYSBtcsNR2Qibo3ZKSEILy1v00Hc3zcDCUhP8TnNL8HMV_k4hYUVau6K_01gSXIbTkieiRHmywj85Y5mJ8wKkVndjZVt3JY_wHjSS3bv5cvfS9HGQ7TMjRv9VJjV6fX06FefuDEr-jnKg', N'web', CAST(N'2020-01-31T10:28:44.9149775+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (13, 5, N'VbTtuBWR3Pdh4ECbtkz6piMlH3rHMulNCCBMX93Rm0o=', N'CfDJ8GaXerj857JJvdOfhqCqicA24zAydxWLJO_L9Ob10swpEp6Hvc53M8i6nKMvTZrnsjE5zjSVw_sigIV7q8fRVgPicFAMUDdQicsTRXaJolEtOOa8ObQLyBLK03pdxPK5JYjJm8wr-MZHb6S9XAABeT4mk6bcZPCyPdEwMcSSgTqhxXu3hiM6Ven7Fz_o_z-hjUtS1V5CIADBefGPe0iPrHIuzlQ5IMMDulIDIplbc6Je2-jsf5O3rvOcZVb4sYitZIGB9oqqBRVIkBNfMslr8KhuJAqSFf8w9dbtg2FQMBqE4iPDOrymtqpzs0LPntKWPlaZCatYASfC1NRYv_UwEoe6E05tWQEDMPsVyd_B2H1nd_EaGpf3jZApFFrj3J5-N7Z8S2kP10vKHj3FmXO1TilbsNx_BY8G4lRL2hQUUEVySWTOPcyPh9NUs06LGOXfJzwmPUmIPalKLkxB7C3zq-nBIThyrlKwtfyFaTlofB36u62q0PuRy6Bjvx5SLfNb3yCWlpsapJkgo6oorcGbnz_vjXN4YzJHU7E5dJhSUBinuEUMNZ3aPFRlYk0yvq0yLG2rfs9AdX9o652jym69bQi3t74gEl2PUy3c8ROOx22UfCGwpExZsLR7Ac-Qw9GNGmk3myoHlCwekSQou8XGncecy9we8KeDE9ayXsbiIviABoI3GKcOs801h7z7zAlaqo7sX7auKQ_opFbsvBnsO-I', N'web', CAST(N'2020-01-31T11:14:26.1112312+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (14, 5, N'SJJr9KoRkBvkqro6Y+7P68633NzN7EIg/8XD6WkUCxA=', N'CfDJ8GaXerj857JJvdOfhqCqicCBy1fsOc1VjnnN-8IjEleHSW6-D6-VFtRG77HCMC9Q0hVPmmFZnPJYvPspQhdK_wqBDlbctZpWCZ01DUgbtEt24lCmybpcOXKsmaMsLKSl56Y_PzchNwaSvvXDUSJXKPEQ5OMzhmmWzqEtI-Q64VX5mh403RN4RRFVhtfiZnmgaruGS2Tc5UtiHWXCP9ZTsofnmxktnW27jClUcM5ZcMCfS5N73pA0jlIvABLbwKZFV-Izy4_JlbaUeSFKIn5eiCOPTBSGzfCAEczEe98f4CNnLobXZ_ZMDdpxB4lE_JJMbVgmrBaHtpJaHYy4aQdAyO_TI4W7GnuD2Wzo8s8qo65Ig5Lgk70Eo7qIlxmkpJCx7oFvoI1HcsC6jVCSXhW1RdJ9dJ-rLNusMyx-KSI4EPyzKgZ2u6rZrtbxNCdWdiVD-RBugDP5yOvdUkEXG5wMQPJqAgohlO2jS7n8AJpPCyVh_qAiRrLss5ET2x-YzEPtWlDRW1eumUyK-R8kgUCYodaNYaBsgWwZ-CiYLpaS9-ervtG9zLFsLrUsBWHbqYWoxYCR7hxkjLjJrTkFcmrR35S0PiufUZ8CVZD3lEQxAcXLxfAgBGbTOLKXiUMjh4A2T_sLgtXtLjXveBgY3OHnxSF1HappfXIVcOs6sOKiMnPCLfjX9-I_MID8ZOSQPMDzZctex-2CJVf5igLEs47l2Ok', N'web', CAST(N'2020-01-31T11:21:21.0565156+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (15, 5, N'ziHBAhpBK29kPG/+RRtEI5JXqIrsXAhsqlGs2UGKwXY=', N'CfDJ8GaXerj857JJvdOfhqCqicBym2Vqj-M3hxDbPHzuzauOqKSJCHrRFem1RgCtj_CYMBLuhYaR3cRv-lN8m-nII3ZMPj8mkE98drzzFWCzJUko22oKDAbbQgAaZ19lnigGb1rJkUvHxr8WUFu6YonQdKNYeA9BpIrPkRIrjZxP9apJOA68dmf_4dqXM24_K9KLhhV4Al6MJZwm1-uDhpsKNEAbSF6Ckp_vy-57AJ2tKixlmVgMeHnhqt365LNVRyX8CurumKlaWObc1PKqp3G0uAgjVWpVKDn6vja7qpPmqRL49JVyyV9hs5yEAW-rCxmuHMPeJo6jJCXHAGWyu893jCTcfU0eif0SstO6__1BeFgJhazLCsV08W76AHvcU-cjDy6oetQkymLEkS-9dpbVpMVfp2STOmrvLLGs0N7TWrs5QNvvuO5HO3PHxH5AQI9fMrAhyMieOiWHCKKTBFL6ou9jr1nebioTniigmyyHesrK6P0a9LvN4j0W3QhndbQMdgaXqzXlu6SJQi7njw9fvyoW91W0xaw_fD-TiIhJ8HKxkMK2m_HIoSBgdbq9Ub6Hxm-gnZuIGQA2EKxFFnqHZhURbVBim_xxY-BFwbl3P9CuxLkD-ew3BUDCgmsIrAOheOJZ7hiU4QFiN2qSEQbrxmott_Mo-AQU8XRgScDXxaJmb5lWiQ3OKIaZQL7jNiGuHxxPYjIxO1NxsZboZ9kcUW0', N'web', CAST(N'2020-01-31T11:57:32.5584120+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (16, 5, N'H//v62uT9w6Unmze7urQYjX5vyvVQZ7Gj/cawkRHH+M=', N'CfDJ8GaXerj857JJvdOfhqCqicDvtWRCB3Q3fpm7IaBK7amIaT8DYTAsOk60H5ZYX4Fnbd7Ey1AMk_c8bC-4lJSbeU0Ygme8rEav6BMA0m0gwFC-c_a3ZeijNH420e-K5IXyFgJWFX1IbsJ5aNI-b9HeKIbpXr3dNxrOfzccuZF-TxQ0rb00JBusYjDM8xRBCHq1fvNAbcY4m_ac4ujeoJgCAdrUx4GZBDrYHFqxRq5QTEpuQyQZgcNKeI2i4H0NH8tf5gEhUWma9DHfP8epr2-fwGGugS4WrQXBOsiOpnDfgzfmHTgwgGn5_3QhrIwQAuznre1KxtzqNm_2-u266xkdEDX9JjD1dwy48YPXhQfPjoBqBPxQIHQcUjyzDg8Xp8i7n10EmDQxHczqwbKSH99GF_4KUM3jBH0dzi_OQn2ma-mBH9b1eaBmx7yL7Eoat8KwiH-HdcgpgQUDDxYqIPP6wSOz4weT1ARovBIFzW5MxjztS-F_Fkc5VKVqM-AA9s1s56sPoQvNkhFHAcy2pfZLDWxjcvuJEAVB9SCHu8hzd7FdGognxaEoNAhezjtbVaEhrYuj_nK4CYMSqfykFfLRVnFr70Kz_jHlNzRGuul9Pmj0K5SsNkjSavCT1COf0agJ4xqjjw1lKLY8PQPBnUNh4a-KFqoEGrOz82qMfafS-Lx8XbW9NVAo8isKxXxrV4AXSGXAFQZaA6PNppBMc8wO2kU', N'web', CAST(N'2020-01-31T12:05:16.4708195+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (17, 5, N's0AVJxQRZq51im4bpsygTv+8siU4VT+X3PNvw9+WXEw=', N'CfDJ8GaXerj857JJvdOfhqCqicC-1C1l72zrAd-NDj3Rk5QjE1B41on4Ovq-JC4-cNlqf5Sl-J5QmRCnQFNHFNILd6_rRmIwAcxlkhqkufUtoqvIbKkvEycqzNEustTq6Fd7uvip3QgO9TAy9DyZQNyd0OOMm5PMhepZElgiCPk9CdjLFAfmCC5mmu3namNA74tkghi-nwAHPCM4714Mm6xhGGDNId0sgF_1EXVvUfem2vg_1YBhhBVl6YJasFEHaNheDHi7hUA7xX5J_7fR06f8NohOE8KWtqJg--cva3I5tlc8NbNp-GcyPbvNaoa1aqLu-KUR2w4YoJ6QVPc3nNXD9HDGmFRwFzoanug7MCYVWf2px9JlReJg1Hr5kHcwfonWxxVpNPGT0dcW8dMJaBOqIiJQfvWT9TIws-W4wyglWoCSPAdsafG8fgneuZ6dO4mbbeOIh2m3XslzmGtwKiUMEM-YfqKK1XtQXh0MgKIB5Kn32c_cm6W2_N3J0-JEFalDpNrWTCERfB3Hh13YPDv-j51LdhBHl7JXuH9bD17zTtVXvRs_d4Up8jr1PmBXbIc1ci8m_vk35DsHOEcVcIauTMMjh9QHmLBTlQESOHqYAwD2hb11FYeZQINIx1g1QAAqmbDOpzj7fvdGBTOpuUUlKLjCTi8cxw2ES0cPpHT20wMylF8p7Aelcn1YOdsERBRsWa59gq3kET28MYfNH0pyILo', N'web', CAST(N'2020-01-31T12:07:08.2846467+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (18, 5, N'/NSRNWiMl/FndLxlKXkmtPFQtVsgkxZPiOSIqFkGzQw=', N'CfDJ8GaXerj857JJvdOfhqCqicC-xbEi4nHDZgX_OgGnVVAhB65PVlMwirroPKejJ4u3ucawUrd1XE4x7I2EwQ93XyZyDTPCwarB1YYmok5n7AkTiFJRt_f9_IEvB6zlVWMSqmIR__6n7yrWgyFS_5QIGW_ckMoM2E_xgeYm7VoAofCSkL-pTcl37ql7O7X-_joPSpNA8eIBHrXMd-342kAJCaByAg20Q8gp0iQgTmrn1LnhqSvP6CBKt00XWojUg0ZEeKmoxI3ZWKeDlc7LrynS5OEnYhijxMMab_uAlsPmqtkwry5K3kR4GAtEeb1bOatbuSxJDPINpStHqJmAI_400Z-ophjt0PMjjLg9KRBuGF3tF7jvdrFr4AMso_XI-FMX7sNfc3rp00ITx8oTTeOsg7yPz83MqxLE-QOdKEffyjhLs-ufoD355rkpiIhR0DWlOhvSL_xEoQSNmHokRh8d8UYOrj7MN-iORQ_qE-41pEVigxudsBDFk9NV8iL5qfQJNJyGDli88A0HJhAC2qYa9SvtBxf6P1d9EEcmVN3ZoiXgPM3rwDZjK6_auHsD0O30Za8fP_uf6_IIoyjnTjb9yau9BEJ_YXaIZpMdNgIdh7NYteLgZVXKZm4AEu_-9WXbX3hdnf9i2pm3l7seB1x7x68Kl4AH5-lsSSOOkjSfsPpF_VfR6sSsnnaYhtfQqeEVURfdD_3vgVPnkHDhSva_KhE', N'web', CAST(N'2020-01-31T12:10:48.6103326+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (19, 5, N'l8R4k2C3quOc0IZVk4RFNutcbcAKYF6vRFFO9mo6LwM=', N'CfDJ8GaXerj857JJvdOfhqCqicAgHN_vHmdd1KBWS1PsNP-hsMjx6QPVRVAwBRxa7TFlbMtaKJyY17lJofkFul0yJt6fxJN4_IXd82gQeHJ3d04qiZ7ukaEEa7XnPGe42Aeh8MIbEDP1-1Ul-dTyxuGmQw6yVvW4dBR3NPJzgQZQedM5k5E1DIh_8mXbhOhG7x5vNBnTaZNdvKwDYpLNKXHIir1eSi5U2ob_TKleLAdupwDarQQp1nCnhnNkQAp7pqGOl-nzMZWXQNCtFz8Dn6DqE8x3lz8eej7SIFKQcC7TenbDHY2D_6l2sQ4J1S045XdOwDZ70_Rsygls_rkZjD5fdPWG9IRuoscjpa2lVUAjSn9pMYoHXEnPv8hUPqDh0jaWPRhTOFq-bDtp7kraYw1UCnUFKLO5F1bOH-uC3563CoN7sjS1szYjii70cu8z2f8CjWjHdyg4hnj9xrK4j6HiN8FptpgEWT_2n8nwyjGMBPGM1NFfDMQJxPqPYnLLMlsgNe0Dp4OlhKT4MV23FFYcxE1hP6BZRzd3gn-yJJbfKVAesnLQGL2kYGOd95CHTKPd_eb5N1YK3ELf6C5NWY4DGvjFiKuiAaL78zSzWuzt7EXoMl7pI47wN8RHNqu4JSjMz-t_1f-Ahs4sh1DtMEA_5Y_xkbUmBTtuJ721D2-bGw4sCve49BMqLOgpr3uJkCNUhkOSWHkeZcRXaS1BFu2BsUM', N'web', CAST(N'2020-01-31T12:15:34.7117709+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (20, 5, N'PFbSN/C1K7lKZEDlKzv0yF+l5LMfs7PGzhGBXX2KTwA=', N'CfDJ8GaXerj857JJvdOfhqCqicC5oEzrJOvIHKaTkGUl4MLYTDFfNcMy1gAa-HZ674EfGMNNOmxRy9jr9DzUGlLAGBCraMVwlaAKDatMKdvg7Di7tu9ZvBz-JIlq4YrrabjCGS7SA2DzS_QaQ8RqgVPJ-i8VU8oBCeXxxqHjvGMHq8yoIEfS3ZhSnxampDBuZYfuqR3TeOFC7KtVrYJ8RmRl80YudFWBoZx5BoW4thVDArMlayS447V5oN5ZZTOuYGtU4RtS_9QqbSKMryz_JsTSElIuHW4tfQSyhK5_7BpIK68xwniQclIXJJJ9QYacL5Ewi8ylVp-GfPtWjHJBQJnY7O2UsB_lghwgH4JkYDEuqOEdJjc6b2eVxOmY9PYOb2A4SjRrHVnKcD77zlWA5JvnmwIHW5Na9oMu5Ie8iCDXM1s_h7PwbUUkQltrwb7QeMPOSxAll6iELZsT0gILJpDC_Rk3Po2D_69R2Of3JQYXnAPati6u26oWYBEYNlJfEYiJrYlSDESwhOzE9BxCXsomNEo-WLIQBkurxxC1eZ6viLIFor4jHkNv-AJW6nK60iKuyUG5lYASn3AGer7b-p_4woI9Iv1BWw_s7U3AW-TT82tiUgJGIMT_WNbou7Eu1Us9mLrzYjyZDBfKMREVUadP3otGO1c3sUQjt6PupJJn1CzPpJWSQ8Od0kRm3DR1RCJ9tfLR26BB_LTBIb4HdNuEsCY', N'web', CAST(N'2020-01-31T12:19:10.7584899+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (21, 5, N'Wg0yarQQsl+tLBaN1nzPM/6vJKRwiFODp/02VUbBhyo=', N'CfDJ8GaXerj857JJvdOfhqCqicB_pOZ07bpGxIm7wqcEzjyx1ScKFKFdkiKoLV4_6w20VAtCFEjLsdHvo2oyoHZqDdhSsJfFQUAcuEg-OEQqkUYLKF4mnnkAn5Zys4JTncIKE7atOCRX1GQAtxgrz54lHGSzbfDzSBVnOS0oTiFJ2-F4iLkGKwXD-H3S2IT7hikcv_sst_PqzYUGhknjoqlMBTp6nMTo-LPc1yZudoUksojq0KiqaR22_xQ8uFRVsBpcnfUKjfk7tN-bO3-hq0pHyuAfJSW31BdvV_WrJFkip_XWzenjSLi5R61qGDR3rLAM-GkPFb7ad0h6suy8LBYmipy0rOv78ajbA1OCQ3j5FGHBccDUihCjSEZSoYSDh_W46OV1XAD3hazzT7TMP-n71QkhDfo8TEIMTSipeV0Zlr5mH1_sst_oKrB80YsQj7CrCJuHZ2YN2kki6EToEumA98WsWo8STRfebJ5LHrM8FRRM2lYaNqP8T3acozNpPdpXIFIgIgHIKXwndM1vSGXVRyiLFamg6CEe7yYvRb6W_MJOiKbEavdJuYAqRD5gBEo_FHp4f_htU9FWKZndbUCHJKbk3wf3t5-HU6ILL_JhRMVXfoxYa5OjHwybqq5HfLkNFSvKgDRYcrRTbIpPDH95TuARRFRplOvEJFFLNMjYP-C5oXo-oHWRw_1sRc70IfNc_Nn_cTh17agwI-yeY1ZBM30', N'web', CAST(N'2020-01-31T12:23:05.5381630+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (22, 5, N'zfUGro9nmfAsn1WKVxYwKYfBz8jB/TxJNKGNNA/cspc=', N'CfDJ8GaXerj857JJvdOfhqCqicCj8exFBaQAmoBVxo5fAdF7KNWz_GpA31RPMuhAWaJ7bcQwvjNWbV_AR9K6Hg6cVZV1tv9ZDcxLKh8KIE-e2LrDj2W5lCD4bpIX9vnuo_EX80KwpTSrh9fINPt_3oJvnqDeRdgydMqr_K151lJNYXz2UmjPSiIzFF-O1cbKhchlWBMt5wL5Io5MZuUpsEPIBKlrFsu3QzBV4Y-sT_w5cEDB_akdr3SgzY4N7dU3S1nnIfobWgzw9myJ7Q2JcmBa-8CyzDz1cnHB3gcSDxZmJ4nO1-9d4mDf0_M3FNZhNIds_gd7gIWIL-iWnnH0ltp-UMUKDuF_GWULId87KflgDY_2qkIcU_kS4pt9PL1mdUJ8IziJQQt_s_D_LbbCbSUERDWM9sDQ1GkX63qWq_-aasp1hygwN5ktSeLXtjM4_xtCiCDYcUo7E04X_OdIXYEm245hZoHv6n_2DS6L7-ERUEpB8opJvqexqkJWNHzTpI3nLW2_hKDbNTVfl45V3oue6ZAFV9T1-iUetZronm8h4PCve7SE1541LgRJu20yTrtWaxhPmbgTYNwCzPDKt4fbq65R75RY1LQ_L5c6D2EN1CbtjdYTTm_jtUML4F5VGuB3lXsjYTq9pM47IsS00Vt6lsd55qMEQmTZxNGxPIZ51cDWZrkNkfhFq1496GkWH0MMAF-jVBE7eIjPC8Ixxs70eCs', N'web', CAST(N'2020-01-31T12:28:45.5629414+00:00' AS DateTimeOffset))
INSERT [dbo].[ApplicationUserTokens] ([ApplicationUserTokenId], [UserId], [SecurityKey], [JwtToken], [AudienceType], [CreatedDateTime]) VALUES (23, 5, N'DA0GF4fF7YPZBDndljVRSLCENW2G3IaW9sOdm/BZBZU=', N'CfDJ8GaXerj857JJvdOfhqCqicAaOJn9UYU16rAMGTv-UlRdKD7PqxnjZLIr2X1aSt11_ZrAh2Ql9x9E7m3f-DL84WLTU5SUCrejf7EEBpmLocIKJ8wBroh7FynnCLYuFQuq7RFJ5hIFUdew6Kc8WO681kVCTA0oELwNkqlFDrTmwodT4plJ83OmHzmVmVNGBCS9OECnXpbU_61yuq0d43uiB8IKEg5Rr5hdWpsSdASm3XmLl9NQY4MCsPROZ41lwpp7TTDIyKFOK5JrDR6x-iyIjlR7UmbXzzzKu5EThVVMnjblVuNRhcsezwjjBO6HHIbW1Z8pbRrIVH9V2Zx52zsyA9q0O91EQInFjIYrdey5kMYvrQy6OT7_xsl8kflcn19hvTZynxvlePu0RxelohsTq0det6SZHtbn-g5AEq_Z7OBMIwWnr7gDyCeunm4jkNwgul_n5uxargchd-JMDgeEaBcZqG3EtVBDQV3vVLc6NbO-zh_S-6xF67zjw4E_h23f47yBErM0es5_EDkj7DkFsHz3K6SajjSTO1hwm3ykdPoaCCdJhr9GZiPzPAg5PFa9iSiPnqd45bsPM6jAxfwTC1X6DPqSKcLhI9R2eLRhx_StCS37wG7gmQ6MMD2TEkTvkzUKZWzmsRtdFWZhED98ECcvzap4MCSjeYbw8MBTwFOwiFxxONJ0NN2R3LbZMSC6nq1qJS9YYZt7x3rPNhuU4wA', N'web', CAST(N'2020-01-31T12:34:37.6484429+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[ApplicationUserTokens] OFF
SET IDENTITY_INSERT [dbo].[CandidateAvailabilities] ON 

INSERT [dbo].[CandidateAvailabilities] ([CandidateAvailabilityId], [AvailableDate], [FromTime], [ToTime], [CandidateId]) VALUES (2, CAST(N'2020-01-31T10:29:47.8620000+00:00' AS DateTimeOffset), CAST(N'10:10:10' AS Time), CAST(N'10:20:20' AS Time), 2)
INSERT [dbo].[CandidateAvailabilities] ([CandidateAvailabilityId], [AvailableDate], [FromTime], [ToTime], [CandidateId]) VALUES (3, CAST(N'2020-01-31T11:22:33.9170000+00:00' AS DateTimeOffset), CAST(N'10:09:02' AS Time), CAST(N'10:10:02' AS Time), 2)
SET IDENTITY_INSERT [dbo].[CandidateAvailabilities] OFF
SET IDENTITY_INSERT [dbo].[Candidates] ON 

INSERT [dbo].[Candidates] ([CandidateId], [FirstName], [EmailId], [CountryId], [Designation], [Experience]) VALUES (2, N'John', N'XXXX', 3, N'Software Engineer', 2)
SET IDENTITY_INSERT [dbo].[Candidates] OFF
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([CountryId], [CountryName], [StatusId], [LanguageId]) VALUES (3, N'1', 1, 1)
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[LanguageContentKeys] ON 

INSERT [dbo].[LanguageContentKeys] ([LanguageContentKeyId], [KeyName], [IsComponent]) VALUES (1, N'required', 0)
INSERT [dbo].[LanguageContentKeys] ([LanguageContentKeyId], [KeyName], [IsComponent]) VALUES (2, N'maxLength', 0)
INSERT [dbo].[LanguageContentKeys] ([LanguageContentKeyId], [KeyName], [IsComponent]) VALUES (3, N'range', 0)
INSERT [dbo].[LanguageContentKeys] ([LanguageContentKeyId], [KeyName], [IsComponent]) VALUES (4, N'unique', 0)
INSERT [dbo].[LanguageContentKeys] ([LanguageContentKeyId], [KeyName], [IsComponent]) VALUES (5, N'hardDelete', 0)
INSERT [dbo].[LanguageContentKeys] ([LanguageContentKeyId], [KeyName], [IsComponent]) VALUES (6, N'exceptionMessage', 0)
INSERT [dbo].[LanguageContentKeys] ([LanguageContentKeyId], [KeyName], [IsComponent]) VALUES (7, N'unauthorizedMessage', 0)
INSERT [dbo].[LanguageContentKeys] ([LanguageContentKeyId], [KeyName], [IsComponent]) VALUES (8, N'invalidTokenMessage', 0)
SET IDENTITY_INSERT [dbo].[LanguageContentKeys] OFF
SET IDENTITY_INSERT [dbo].[LanguageContents] ON 

INSERT [dbo].[LanguageContents] ([LanguageContentId], [LanguageContentKeyId], [ContentType], [En], [Fr]) VALUES (1, 1, N'g', N'The {0} field is required', NULL)
INSERT [dbo].[LanguageContents] ([LanguageContentId], [LanguageContentKeyId], [ContentType], [En], [Fr]) VALUES (2, 2, N'g', N'The allowed max length is {0}', NULL)
INSERT [dbo].[LanguageContents] ([LanguageContentId], [LanguageContentKeyId], [ContentType], [En], [Fr]) VALUES (3, 3, N'g', N'You can enter {0} to {1} length', NULL)
INSERT [dbo].[LanguageContents] ([LanguageContentId], [LanguageContentKeyId], [ContentType], [En], [Fr]) VALUES (4, 4, N'g', N'The {0} Field Should be unique', NULL)
SET IDENTITY_INSERT [dbo].[LanguageContents] OFF
SET IDENTITY_INSERT [dbo].[ModuleMasters] ON 

INSERT [dbo].[ModuleMasters] ([ModuleMasterId], [ModuleMasterName], [StatusId]) VALUES (1, N'User Management', 1)
SET IDENTITY_INSERT [dbo].[ModuleMasters] OFF
SET IDENTITY_INSERT [dbo].[RolePermissions] ON 

INSERT [dbo].[RolePermissions] ([RolePermissionId], [RoleId], [ApplicationModuleId], [CanView], [CanAdd], [CanEdit], [CanDelete], [PermissionPriority]) VALUES (2, 1, 1, 1, 1, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[RolePermissions] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName], [StatusId]) VALUES (1, N'Super Admin', 1)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [StatusId]) VALUES (2, N'Admin', 1)
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([UserRoleId], [UserId], [RoleId]) VALUES (2, 5, 1)
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [ApplicationLocaleId], [ApplicationTimeZoneId], [LanguageCode], [UserName], [Password], [Salt], [LoginBlocked], [StatusId]) VALUES (5, 144, 362, N'en', N'admin', 0x01A508148A63F344F3A52C5B9F065CB3166788F713EF1C6831D4218937C259740CB2ABF9F20D2CC0FCEC4769496A0B35103CA91DEE84C61F2E0F01D7110D01702D35019B0F7CECD7DDB282C6EEE3C75049D069775903D9CBC044527F1C648BBAF3D96B24070CAD7F6BC79AD739C101CF2DD2D54EEAE7198B44D53985C1787D320F6A1A22, 0x4543533542000000019E5F0EFB0E97B45F0DCCAE88F38A88D1E9707F7B54479D351D2A402D27911955859B99DD02A70689A550B6341958A06C4A1E74D9FFF78B01791EB99EE0AB0603440118EBDAA1BC51919C6B4BA455EF9448BCAF1CB0A92674E612EDB51B99DA2C99F31B6348350E38740E64D71C6AEE5ECA20D025FB7E387895BB0EC104C4ACD8F1296E, 0, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[RolePermissions] ADD  CONSTRAINT [DF__RolePermi__NoAcc__114A936A]  DEFAULT ((0)) FOR [CanView]
GO
ALTER TABLE [dbo].[RolePermissions] ADD  CONSTRAINT [DF__RolePermi__Reado__123EB7A3]  DEFAULT ((0)) FOR [CanAdd]
GO
ALTER TABLE [dbo].[RolePermissions] ADD  CONSTRAINT [DF_RolePermissions_AllowView]  DEFAULT ((0)) FOR [CanEdit]
GO
ALTER TABLE [dbo].[RolePermissions] ADD  CONSTRAINT [DF__RolePermi__FullA__1332DBDC]  DEFAULT ((0)) FOR [CanDelete]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_LoginBlocked]  DEFAULT ((0)) FOR [LoginBlocked]
GO
ALTER TABLE [dbo].[ApplicationLocales]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationLocales_ApplicationObjects] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ApplicationObjects] ([ApplicationObjectId])
GO
ALTER TABLE [dbo].[ApplicationLocales] CHECK CONSTRAINT [FK_ApplicationLocales_ApplicationObjects]
GO
ALTER TABLE [dbo].[ApplicationModules]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationModules_ModuleMasters] FOREIGN KEY([ModuleMasterId])
REFERENCES [dbo].[ModuleMasters] ([ModuleMasterId])
GO
ALTER TABLE [dbo].[ApplicationModules] CHECK CONSTRAINT [FK_ApplicationModules_ModuleMasters]
GO
ALTER TABLE [dbo].[ApplicationObjects]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationObjects_ApplicationObjectTypes] FOREIGN KEY([ApplicationObjectTypeId])
REFERENCES [dbo].[ApplicationObjectTypes] ([ApplicationObjectTypeId])
GO
ALTER TABLE [dbo].[ApplicationObjects] CHECK CONSTRAINT [FK_ApplicationObjects_ApplicationObjectTypes]
GO
ALTER TABLE [dbo].[ApplicationTimeZones]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationTimeZones_ApplicationObjects] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ApplicationObjects] ([ApplicationObjectId])
GO
ALTER TABLE [dbo].[ApplicationTimeZones] CHECK CONSTRAINT [FK_ApplicationTimeZones_ApplicationObjects]
GO
ALTER TABLE [dbo].[ApplicationUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationUserTokens_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ApplicationUserTokens] CHECK CONSTRAINT [FK_ApplicationUserTokens_Users]
GO
ALTER TABLE [dbo].[ComponentLanguageContents]  WITH CHECK ADD  CONSTRAINT [FK_ComponentLanguageContents_LanguageContentKeys] FOREIGN KEY([ComponentKeyId])
REFERENCES [dbo].[LanguageContentKeys] ([LanguageContentKeyId])
GO
ALTER TABLE [dbo].[ComponentLanguageContents] CHECK CONSTRAINT [FK_ComponentLanguageContents_LanguageContentKeys]
GO
ALTER TABLE [dbo].[ComponentLanguageContents]  WITH CHECK ADD  CONSTRAINT [FK_ComponentLanguageContents_LanguageContents] FOREIGN KEY([LanguageContentId])
REFERENCES [dbo].[LanguageContents] ([LanguageContentId])
GO
ALTER TABLE [dbo].[ComponentLanguageContents] CHECK CONSTRAINT [FK_ComponentLanguageContents_LanguageContents]
GO
ALTER TABLE [dbo].[LanguageContents]  WITH CHECK ADD  CONSTRAINT [FK_LanguageContents_LanguageContentKeys] FOREIGN KEY([LanguageContentKeyId])
REFERENCES [dbo].[LanguageContentKeys] ([LanguageContentKeyId])
GO
ALTER TABLE [dbo].[LanguageContents] CHECK CONSTRAINT [FK_LanguageContents_LanguageContentKeys]
GO
ALTER TABLE [dbo].[ModuleMasters]  WITH CHECK ADD  CONSTRAINT [FK_ModuleMasters_ApplicationObjects] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ApplicationObjects] ([ApplicationObjectId])
GO
ALTER TABLE [dbo].[ModuleMasters] CHECK CONSTRAINT [FK_ModuleMasters_ApplicationObjects]
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissions_ApplicationModules] FOREIGN KEY([ApplicationModuleId])
REFERENCES [dbo].[ApplicationModules] ([ApplicationModuleId])
GO
ALTER TABLE [dbo].[RolePermissions] CHECK CONSTRAINT [FK_RolePermissions_ApplicationModules]
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissions_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[RolePermissions] CHECK CONSTRAINT [FK_RolePermissions_Roles]
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [FK_Roles_ApplicationObjects] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ApplicationObjects] ([ApplicationObjectId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [FK_Roles_ApplicationObjects]
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [FK_Roles_ApplicationObjects1] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ApplicationObjects] ([ApplicationObjectId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [FK_Roles_ApplicationObjects1]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_ApplicationObjects] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ApplicationObjects] ([ApplicationObjectId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_ApplicationObjects]
GO
/****** Object:  StoredProcedure [dbo].[spCanDeleteRecord]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spCanDeleteRecord](@TableName nvarchar(50), @RecordId int)
AS
BEGIN
			--DECLARE @RecordId INT=1
			--DECLARE @TableName nvarchar(50)='ApplicationModules'

			DECLARE @FkName nvarchar(250)
			DECLARE @ParentTable nvarchar(100)
			DECLARE @KeyName nvarchar(100)
			DECLARE @ReferenceTable nvarchar(100)
			DECLARE @TableSchema nvarchar(100)

			DECLARE @DynSql nvarchar(max)
			DECLARE @ReturnValue bit = 0
			CREATE TABLE #myTable(Cnt int)

			DECLARE RefCursor Cursor FOR
							SELECT
								    fk.name 'FkName',
								    tp.name 'ParentTable',
								    cp.name 'KeyName', 
									tr.name 'RefrenceTable',
									info.TABLE_SCHEMA 'TableSchema'
							FROM 
									sys.foreign_keys fk
									INNER JOIN 
									    sys.tables tp ON fk.parent_object_id = tp.object_id
									INNER JOIN 
										sys.tables tr ON fk.referenced_object_id = tr.object_id
									INNER JOIN 
										sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
									INNER JOIN 
										sys.columns cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
									INNER JOIN 
										sys.columns cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id
						             INNER JOIN 
									    INFORMATION_SCHEMA.COLUMNS info ON tp.[name] =info.TABLE_NAME
							WHERE 
									tr.name=@TableName
									and tp.name!='Addresses' --To be removed once actual implementation done with Archi. 14-07-2017

			OPEN RefCursor
			FETCH NEXT FROM RefCursor INTO @FkName, @ParentTable, @KeyName, @ReferenceTable,@TableSchema
			WHILE @@FETCH_STATUS=0
			BEGIN
					--SELECT 	@FkName, @ParentTable, @KeyName, @ReferenceTable
					SET @DynSql	='	SELECT COUNT(*) Cnt FROM ' +@TableSchema+'.' + @ParentTable + '  WHERE ' + @KeyName + ' = ' + Cast(@RecordId as nvarchar(5))

					INSERT INTO #myTable(Cnt)
					EXEC (@DynSQL)  

					IF EXISTS(Select CNT from #myTable WHERE CNT>0)
					BEGIN
							SET @ReturnValue =1
							BREAK;
					END
					SET @DynSql=''		
					FETCH NEXT FROM RefCursor INTO @FkName, @ParentTable, @KeyName, @ReferenceTable,@TableSchema
			END
			CLOSE RefCursor
			Deallocate RefCursor
			DROP TABLE #myTable
			SELECT 1 as Id,  @ReturnValue as Result

END
GO
/****** Object:  StoredProcedure [dbo].[spEmployeeLookups]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spEmployeeLookups]
	@EmployeeName nVARCHAR(50)
AS
BEGIN
	select  CAST(RAND() * 1000 + 1 AS INT) as Id,
	(Select EmployeeId, EmployeeName from Employees where EmployeeName like @EmployeeName+'%') as Result
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertcandidateAvailabilities]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertcandidateAvailabilities]
@CandidateAvailabilityArray AS dbo.CandidateAvailabilitiesArray READONLY
AS
BEGIN
    INSERT INTO CandidateAvailabilities SELECT * FROM @CandidateAvailabilityArray 
END
GO
/****** Object:  StoredProcedure [dbo].[spSearchEmployees]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSearchEmployees]
	@Query VARCHAR(MAX)
AS
BEGIN
 select  CAST(RAND() * 1000 + 1 AS INT) as Id,
 (Select EmployeeId ,EmployeeName from Employees  where EmployeeName like @Query+'%' FOR JSON PATH) as Result
END
GO
/****** Object:  StoredProcedure [dbo].[spSearchUsers]    Script Date: 07-02-2020 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSearchUsers]
	@Query VARCHAR(MAX)
AS
BEGIN
 select  CAST(RAND() * 1000 + 1 AS INT) as Id,
 (Select UserId ,UserName from Users  where UserName like @Query+'%' FOR JSON PATH) as Result
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Parent Application Module' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationModules', @level2type=N'COLUMN',@level2name=N'ParentApplicationModuleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Main Primary Key' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationObjects', @level2type=N'COLUMN',@level2name=N'ApplicationObjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Application Objects is used Application wide' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationObjects'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Thid field is the reference of LanguageContentKeys table, This stores only those ids of the respective IsComponent column value is true.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ComponentLanguageContents', @level2type=N'COLUMN',@level2name=N'ComponentKeyId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'only respective values are allowed  like for placeholder ''p'', label ''l'',gridHeader ''gh''' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LanguageContents', @level2type=N'COLUMN',@level2name=N'ContentType'
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
         Begin Table = "appuser"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locale"
            Begin Extent = 
               Top = 6
               Left = 289
               Bottom = 136
               Right = 483
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "timezone"
            Begin Extent = 
               Top = 6
               Left = 521
               Bottom = 136
               Right = 756
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vUsers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vUsers'
GO
USE [master]
GO
ALTER DATABASE [HumanResourceDb] SET  READ_WRITE 
GO

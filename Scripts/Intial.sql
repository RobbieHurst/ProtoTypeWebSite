CREATE TABLE [dbo].[UserPermissionType](
	[ID] [int] NOT NULL,
	[Name] [varchar](200) NOT NULL,
 CONSTRAINT [PK_UserPermissionType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'UserPermissionType'
GO

CREATE TABLE [dbo].[LandingPageSetup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Url] [varchar](100) NOT NULL,
	[UserPermissionTypeID] [int] NOT NULL,
 CONSTRAINT [LandingPageSetup_PK] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[UserType](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Internal] [bit] NOT NULL,
	[IsStaff] [bit] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[InactiveDate] [datetime] NULL,
	[Status]  AS (isnull(CONVERT([bit],case when [EffectiveDate]<=CONVERT([date],getdate()) AND ([InactiveDate] IS NULL OR [InactiveDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
	[IsTeamLeader] [bit] NOT NULL,
	[LandingPageSetupID] [int] NULL,
 CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[UserPermission](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserPermissionTypeID] [int] NOT NULL,
	[UserTypeID] [int] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[InactiveDate] [datetime] NULL,
	[Status]  AS (isnull(CONVERT([bit],case when ([EffectiveDate] IS NULL OR [EffectiveDate]<=CONVERT([date],getdate())) AND ([InactiveDate] IS NULL OR [InactiveDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
 CONSTRAINT [PK_UserPermission] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1000,1) NOT FOR REPLICATION NOT NULL,
	[UserTypeID] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[Active] [bit] NOT NULL,
	[WindowsDomainName] [varchar](8000) NULL,
	[MaintenanceUser] [bit] NOT NULL,
	[Encrypted] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[UserSetting](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserID] [int] NOT NULL,
	[Key] [varchar](100) NOT NULL,
	[Value] [varbinary](max) NULL,
 CONSTRAINT [PK_UserSetting] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


CREATE TABLE [dbo].[ActionStatus](
	[ID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[IsError] [bit] NOT NULL,
	[IsComplete] [bit] NOT NULL,
 CONSTRAINT [PK_ActionStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ActionStatus'
GO

CREATE TABLE [dbo].[ActionSystem](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ActionSystem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ActionSystem'
GO

CREATE TABLE [dbo].[ActionType](
	[ID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ActionType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ActionType'
GO


CREATE TABLE [dbo].[Action](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CaseID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[ActionTypeID] [int] NOT NULL,
	[ActionStatusID] [int] NOT NULL,
	[ActionSystemID] [int] NOT NULL,
	[ErrorMessage] [text] NULL,
	[DateToRun] [datetime2](7) NOT NULL,
	[DateSent] [datetime] NULL,
	[UserID] [int] NULL,
	[Parameters] [varchar](max) NULL,
 CONSTRAINT [PK_Action] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[Instruction](
	[ID] [int] IDENTITY(400,1) NOT NULL,
	[InstructionStatusID] [int] NOT NULL,
	[PreviousInstructionStatusID] [int] NULL,
	[InstructionTypeID] [int] NULL,
	[TitleID] [int] NULL,
	[ProvinceID] [int] NULL,
	[InsurerID] [int] NOT NULL,
	[ClaimHandlerID] [int] NOT NULL,
	[RegionID] [int] NULL,
	[ClaimNo] [varchar](50) NOT NULL,
	[PolicyNo] [varchar](50) NOT NULL,
	[ContactInitials] [varchar](50) NOT NULL,
	[ContactSurname] [varchar](50) NOT NULL,
	[IdNumber] [varchar](50) NULL,
	[Email] [varchar](100) NOT NULL,
	[MobileNo] [varchar](50) NOT NULL,
	[WorkNo] [varchar](50) NOT NULL,
	[HomeNo] [varchar](50) NOT NULL,
	[Address] [varchar](500) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[PostalCode] [varchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[PolicyType] [varchar](50) NOT NULL,
	[DateOfLoss] [datetime] NULL,
	[Excess] [money] NULL,
	[Notes] [text] NOT NULL,
	[SumInsured] [money] NULL,
	[PolicyHolderTypeID] [int] NULL,
	[PolicyHolder] [varchar](50) NOT NULL,
	[ExcessLimit] [money] NULL,
	[ExcessPercentage] [money] NULL,
	[UserID] [int] NULL,
	[DelayUseWebServices] [bit] NULL,
	[TotalVatExVat] [money] NULL,
	[DateCompleted] [datetime] NULL,
 CONSTRAINT [PK_Instruction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[Company](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CompanyTypeID] [int] NOT NULL,
	[Name] [varchar](8000) NOT NULL,
	[Email] [varchar](200) NULL,
	[TelephoneNumber] [varchar](20) NULL,
	[MobileNumber] [varchar](20) NULL,
	[CompanyRegNumber] [varchar](200) NULL,
	[CompanyCode] [varchar](50) NULL,
	[CompanyWebAddress] [varchar](200) NULL,
	[EffectiveDate] [datetime] NULL,
	[InactiveDate] [datetime] NULL,
	[CompanyAvailabilityID] [int] NULL,
	[ServiceProviderStatusID] [int] NULL,
	[PaymentFrequencyID] [int] NULL,
	[VatRegistered] [bit] NULL,
	[VatNumber] [varchar](50) NULL,
	[Status]  AS (isnull(CONVERT([bit],case when ([EffectiveDate] IS NULL OR [EffectiveDate]<=CONVERT([date],getdate())) AND ([InactiveDate] IS NULL OR [InactiveDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
	[UserID] [int] NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[CompanyAddress](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CompanyID] [int] NOT NULL,
	[AddressID] [int] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[InactiveDate] [datetime] NULL,
	[Status]  AS (isnull(CONVERT([bit],case when [EffectiveDate]<=CONVERT([date],getdate()) AND ([InactiveDate] IS NULL OR [InactiveDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
 CONSTRAINT [PK_CompanyAddress] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[CompanyAvailability](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](8000) NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[InactiveDate] [datetime] NULL,
	[Status]  AS (isnull(CONVERT([bit],case when [EffectiveDate]<=CONVERT([date],getdate()) AND ([InactiveDate] IS NULL OR [InactiveDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
 CONSTRAINT [PK_CompanyAvailability] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[CompanyType](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](8000) NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[InactiveDate] [datetime] NULL,
	[Status]  AS (isnull(CONVERT([bit],case when [EffectiveDate]<=CONVERT([date],getdate()) AND ([InactiveDate] IS NULL OR [InactiveDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
 CONSTRAINT [PK_CompanyType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CompanyType'
GO

CREATE TABLE [dbo].[Country](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[DeallocationReason](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](8000) NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[InactiveDate] [datetime] NULL,
	[Status]  AS (isnull(CONVERT([bit],case when [EffectiveDate]<=CONVERT([date],getdate()) AND ([InactiveDate] IS NULL OR [InactiveDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
 CONSTRAINT [PK_DeallocationReason] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DeclineReason](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_DeclineReason] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DeclineReason'
GO

CREATE TABLE [dbo].[Error](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Exception] [varchar](200) NOT NULL,
	[Message] [varchar](8000) NOT NULL,
	[StackTrace] [varchar](8000) NOT NULL,
	[InnerExceptions] [varchar](8000) NULL,
	[DateCreated] [datetime] NOT NULL,
	[Reported] [bit] NULL,
 CONSTRAINT [PK_Error] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Person](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TitleID] [int] NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Surname] [varchar](200) NOT NULL,
	[CellNumber] [varchar](50) NOT NULL,
	[LandLine] [varchar](50) NULL,
	[EmailAddress] [varchar](200) NULL,
	[IDNumber] [varchar](50) NULL,
	[DateOfBirth] [datetime] NULL,
	[EmployeeNo] [varchar](50) NOT NULL,
	[RelationshipID] [int] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[PluginSetting](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[NextRunTime] [datetime] NOT NULL,
	[IntervalInMinutes] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_PluginSetting] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PluginSetting'
GO

CREATE TABLE [dbo].[PolicyHolder](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ValidationGroupID] [int] NOT NULL,
	[PolicyNumber] [varchar](200) NOT NULL,
	[PolicyHolderID] [varchar](200) NULL,
	[PolicyHolderTitleID] [int] NOT NULL,
	[PolicyHolderName] [varchar](200) NOT NULL,
	[PolicyHolderSurname] [varchar](200) NOT NULL,
	[PolicyHolderInitials] [varchar](200) NULL,
	[PolicyHolderPostalAddressID] [int] NULL,
	[PolicyHolderContactDetails] [varchar](200) NULL,
	[Email] [varchar](8000) NULL,
	[PhoneNumberHome] [varchar](200) NULL,
	[PhoneNumberWork] [varchar](200) NULL,
	[PhoneNumberMobile] [varchar](200) NULL,
	[PolicyCover] [varchar](200) NULL,
	[RecordSourceID] [int] NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NULL,
	[UserID] [int] NULL,
	[InceptionDate] [datetime] NOT NULL,
	[CancellationDate] [datetime] NULL,
	[MemberToPayIndicator] [bit] NOT NULL,
	[Status]  AS (isnull(CONVERT([bit],case when [InceptionDate]<=CONVERT([date],getdate()) AND ([CancellationDate] IS NULL OR [CancellationDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
	[PolicyHolderGender] [varchar](10) NULL,
 CONSTRAINT [PK_PolicyHolder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[ProviderAllocation](
	[CaseID] [int] NULL,
	[CaseProvider] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Province](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CountryID] [int] NOT NULL,
 CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Region](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Description] [varchar](200) NULL,
	[ProvinceID] [int] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[InactiveDate] [datetime] NULL,
	[PostalCode] [varchar](20) NOT NULL,
	[Status]  AS (isnull(CONVERT([bit],case when [EffectiveDate]<=CONVERT([date],getdate()) AND ([InactiveDate] IS NULL OR [InactiveDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Scheme](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ValidationGroupID] [int] NULL,
	[ValidationMethodID] [int] NULL,
	[GroupID] [int] NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[SchemeTypeID] [int] NOT NULL,
	[InceptionDate] [datetime] NOT NULL,
	[CancellationDate] [datetime] NULL,
	[CoverSetupID] [int] NOT NULL,
	[ShareCallNumber] [varchar](200) NULL,
	[TelephonyDisplay] [varchar](200) NULL,
	[Status]  AS (isnull(CONVERT([bit],case when [InceptionDate]<=CONVERT([date],getdate()) AND ([CancellationDate] IS NULL OR [CancellationDate]>CONVERT([date],getdate())) then (1) else (0) end),(0))),
	[AlertAccountID] [varchar](15) NULL,
	[AgentNoteDetail] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_Scheme] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Session](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SessionID] [varchar](80) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[LastUsed] [datetime2](7) NOT NULL,
	[LockDate] [datetime2](7) NOT NULL,
	[LockID] [uniqueidentifier] NOT NULL,
	[Data] [varbinary](8000) NULL,
	[UserID] [int] NULL,
	[Active] [bit] NOT NULL,
	[Application] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Suburb](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](8000) NOT NULL,
	[CityID] [int] NOT NULL,
 CONSTRAINT [PK_Suburb] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[UpdateScriptLog](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScriptName] [varchar](256) NOT NULL,
	[DateApplied] [datetime] NOT NULL,
	[Script] [varchar](max) NOT NULL,
 CONSTRAINT [PK_UpdateScriptLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[UpdateScriptLog] ADD  CONSTRAINT [DF_UpdateScriptLog_DateApplied]  DEFAULT (getdate()) FOR [DateApplied]
GO


CREATE TABLE [dbo].[WebService](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
 CONSTRAINT [PK_WebService] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'WebService'
GO

CREATE TABLE [dbo].[Diary](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InstructionID] [int] NOT NULL,
	[DiaryTypeID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ExternalID] [int] NULL,
	[Message] [varchar](8000) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Diary] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DiaryType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Colour] [varchar](50) NULL,
 CONSTRAINT [PK_DiaryType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'FrameworkEnum', @value=N'Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DiaryType'
GO





















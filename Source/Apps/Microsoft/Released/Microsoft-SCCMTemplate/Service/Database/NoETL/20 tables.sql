CREATE TABLE [pbist_sccm].[ClientHealthClientInstalledVersionDetails](
	[Netbios] [nvarchar](256) NULL,
	[Domain] [nvarchar](256) NULL,
	[User] [nvarchar](256) NULL,
	[Client Version] [nvarchar](256) NULL,
	[Creation Date] [datetime] NULL,
	[Last DDR] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthClientInstalledVersionDetails_staging](
	[Netbios] [nvarchar](256) NULL,
	[Domain] [nvarchar](256) NULL,
	[User] [nvarchar](256) NULL,
	[Client Version] [nvarchar](256) NULL,
	[Creation Date] [datetime] NULL,
	[Last DDR] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthClientsinventorystatisticslast30days](
	[TotalRecords] [int] NULL,
	[Clients] [int] NULL,
	[ClientsPct] [numeric](27, 13) NULL,
	[NoClients] [int] NULL,
	[NoClientsPct] [numeric](27, 13) NULL,
	[Obsolete] [int] NULL,
	[ObsoletePct] [numeric](27, 13) NULL,
	[ValidClients] [int] NULL,
	[ValidClientsPct] [numeric](27, 13) NULL,
	[ActiveClientsCurrent] [int] NULL,
	[ActiveClientsCurrentPct] [numeric](27, 13) NULL,
	[InactiveClientsCurrent] [int] NULL,
	[InactiveClientsCurrentPct] [numeric](27, 13) NULL,
	[ActiveClientsLast30Days] [int] NULL,
	[ActiveClientsLast30DaysPct] [numeric](27, 13) NULL,
	[HwSuccessLast30Days] [int] NULL,
	[HwSuccessLast30DaysPct] [numeric](27, 13) NULL,
	[HwNotSuccessLast30Days] [int] NULL,
	[HwNotSuccessLast30DaysPct] [numeric](27, 13) NULL,
	[SwSuccessLast30Days] [int] NULL,
	[SwSuccessLast30DaysPct] [numeric](27, 13) NULL,
	[SwNotSuccessLast30Days] [int] NULL,
	[SwNotSuccessLast30DaysPct] [numeric](27, 13) NULL,
	[HWInvMissing] [int] NULL,
	[HWInvMissingPct] [numeric](27, 13) NULL,
	[SWInvMissing] [int] NULL,
	[SWInvMissingPct] [numeric](27, 13) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthClientsinventorystatisticslast30days_staging](
	[TotalRecords] [int] NULL,
	[Clients] [int] NULL,
	[ClientsPct] [numeric](27, 13) NULL,
	[NoClients] [int] NULL,
	[NoClientsPct] [numeric](27, 13) NULL,
	[Obsolete] [int] NULL,
	[ObsoletePct] [numeric](27, 13) NULL,
	[ValidClients] [int] NULL,
	[ValidClientsPct] [numeric](27, 13) NULL,
	[ActiveClientsCurrent] [int] NULL,
	[ActiveClientsCurrentPct] [numeric](27, 13) NULL,
	[InactiveClientsCurrent] [int] NULL,
	[InactiveClientsCurrentPct] [numeric](27, 13) NULL,
	[ActiveClientsLast30Days] [int] NULL,
	[ActiveClientsLast30DaysPct] [numeric](27, 13) NULL,
	[HwSuccessLast30Days] [int] NULL,
	[HwSuccessLast30DaysPct] [numeric](27, 13) NULL,
	[HwNotSuccessLast30Days] [int] NULL,
	[HwNotSuccessLast30DaysPct] [numeric](27, 13) NULL,
	[SwSuccessLast30Days] [int] NULL,
	[SwSuccessLast30DaysPct] [numeric](27, 13) NULL,
	[SwNotSuccessLast30Days] [int] NULL,
	[SwNotSuccessLast30DaysPct] [numeric](27, 13) NULL,
	[HWInvMissing] [int] NULL,
	[HWInvMissingPct] [numeric](27, 13) NULL,
	[SWInvMissing] [int] NULL,
	[SWInvMissingPct] [numeric](27, 13) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthCountAssignedClientsBySite](
	[ConfigMgr Site] [nvarchar](446) NOT NULL,
	[Total Clients Assigned] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthCountAssignedClientsBySite_staging](
	[ConfigMgr Site] [nvarchar](446) NOT NULL,
	[Total Clients Assigned] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthCountClientsInstalledVersion](
	[VersionNumber] [nvarchar](256) NULL,
	[Description] [nvarchar](256) NULL,
	[Total] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthCountClientsInstalledVersion_staging](
	[VersionNumber] [nvarchar](256) NULL,
	[Description] [nvarchar](256) NULL,
	[Total] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthCountClientsInstalledVersionPerSite](
	[Description] [nvarchar](256) NULL,
	[VersionNumber] [nvarchar](256) NULL,
	[Site Code] [nvarchar](446) NOT NULL,
	[Total] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthCountClientsInstalledVersionPerSite_staging](
	[Description] [nvarchar](256) NULL,
	[VersionNumber] [nvarchar](256) NULL,
	[Site Code] [nvarchar](446) NOT NULL,
	[Total] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthEvaluationCount](
	[Total] [int] NULL,
	[Health] [varchar](16) NULL,
	[LastEvaluationHealthy] [int] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthEvaluationCount_staging](
	[Total] [int] NULL,
	[Health] [varchar](16) NULL,
	[LastEvaluationHealthy] [int] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthSummary](
	[Status] [varchar](8) NULL,
	[NClients] [int] NULL,
	[PCT] [decimal](5, 4) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthSummary_staging](
	[Status] [varchar](8) NULL,
	[NClients] [int] NULL,
	[PCT] [decimal](5, 4) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthWUAVersionAllClients](
	[ComputerName] [nvarchar](256) NULL,
	[WUA Agent Version] [nvarchar](255) NULL,
	[Operating System] [nvarchar](255) NULL,
	[Service Pack] [nvarchar](255) NULL,
	[Total] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ClientHealthWUAVersionAllClients_staging](
	[ComputerName] [nvarchar](256) NULL,
	[WUA Agent Version] [nvarchar](255) NULL,
	[Operating System] [nvarchar](255) NULL,
	[Service Pack] [nvarchar](255) NULL,
	[Total] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[collection](
	[collectionid] [nvarchar](8) NOT NULL,
	[collection name] [nvarchar](255) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[collection_staging](
	[collectionid] [nvarchar](8) NOT NULL,
	[collection name] [nvarchar](255) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ComplianceSettingComplianceByComputers](
	[MachineName] [nvarchar](256) NULL,
	[Domain] [nvarchar](256) NULL,
	[ADSite] [nvarchar](256) NULL,
	[ErrorCode] [nvarchar](max) NULL,
	[BaselineName] [nvarchar](512) NULL,
	[BaselineContentVersion] [int] NULL,
	[ComplianceState] [nvarchar](512) NULL,
	[MaxNoncomplianceCriticality] [int] NULL,
	[LastComplianceMessageTime] [datetime] NULL,
	[Baseline_UniqueID] [nvarchar](512) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ComplianceSettingComplianceByComputers_staging](
	[MachineName] [nvarchar](256) NULL,
	[Domain] [nvarchar](256) NULL,
	[ADSite] [nvarchar](256) NULL,
	[ErrorCode] [nvarchar](max) NULL,
	[BaselineName] [nvarchar](512) NULL,
	[BaselineContentVersion] [int] NULL,
	[ComplianceState] [nvarchar](512) NULL,
	[MaxNoncomplianceCriticality] [int] NULL,
	[LastComplianceMessageTime] [datetime] NULL,
	[Baseline_UniqueID] [nvarchar](512) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ComplianceSettingComplianceCIForAllBaseline](
	[BaselineContentVersion] [int] NULL,
	[ParentBaselineDisplayName] [nvarchar](512) NULL,
	[ParentBaselineVersion] [int] NULL,
	[IsBaseline] [int] NOT NULL,
	[SubBaselineDisplayName] [nvarchar](4000) NULL,
	[BL_CI_ID] [int] NULL,
	[CI_ID] [int] NULL,
	[SubBaselineName] [nvarchar](512) NULL,
	[FinalOrder] [nvarchar](1057) NULL,
	[SubBaselineContentVersion] [int] NULL,
	[BaselinePolicy] [int] NULL,
	[ConfigurationItemType] [int] NULL,
	[ConfigurationItemName] [nvarchar](512) NULL,
	[CIContentVersion] [int] NULL,
	[CountCompliant] [int] NULL,
	[CountNoncompliant] [int] NULL,
	[FailureCount] [int] NULL,
	[CountEnforced] [int] NULL,
	[CountNotApplicable] [int] NULL,
	[CountNotDetected] [int] NULL,
	[CountUnknown] [int] NULL,
	[CountReported] [int] NULL,
	[CountTargeted] [int] NULL,
	[MaxNoncomplianceCriticality] [int] NULL,
	[CompliancePercentage] [numeric](5, 2) NULL,
	[Categories] [nvarchar](512) NULL,
	[SubBaseline_UniqueID] [nvarchar](512) NULL,
	[CI_UniqueID] [nvarchar](512) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ComplianceSettingComplianceCIForAllBaseline_staging](
	[BaselineContentVersion] [int] NULL,
	[ParentBaselineDisplayName] [nvarchar](512) NULL,
	[ParentBaselineVersion] [int] NULL,
	[IsBaseline] [int] NOT NULL,
	[SubBaselineDisplayName] [nvarchar](4000) NULL,
	[BL_CI_ID] [int] NULL,
	[CI_ID] [int] NULL,
	[SubBaselineName] [nvarchar](512) NULL,
	[FinalOrder] [nvarchar](1057) NULL,
	[SubBaselineContentVersion] [int] NULL,
	[BaselinePolicy] [int] NULL,
	[ConfigurationItemType] [int] NULL,
	[ConfigurationItemName] [nvarchar](512) NULL,
	[CIContentVersion] [int] NULL,
	[CountCompliant] [int] NULL,
	[CountNoncompliant] [int] NULL,
	[FailureCount] [int] NULL,
	[CountEnforced] [int] NULL,
	[CountNotApplicable] [int] NULL,
	[CountNotDetected] [int] NULL,
	[CountUnknown] [int] NULL,
	[CountReported] [int] NULL,
	[CountTargeted] [int] NULL,
	[MaxNoncomplianceCriticality] [int] NULL,
	[CompliancePercentage] [numeric](5, 2) NULL,
	[Categories] [nvarchar](512) NULL,
	[SubBaseline_UniqueID] [nvarchar](512) NULL,
	[CI_UniqueID] [nvarchar](512) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ComponentStatus](
	[NbCompStatus] [int] NULL,
	[Status] [varchar](8) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ComponentStatus_staging](
	[NbCompStatus] [int] NULL,
	[Status] [varchar](8) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computer](
	[machineid] [int] NOT NULL,
	[sitecode] [nvarchar](3) NULL,
	[name] [nvarchar](256) NULL,
	[operating system] [nvarchar](256) NULL,
	[client type] [tinyint] NULL,
	[manufacturer] [nvarchar](255) NULL,
	[model] [nvarchar](255) NULL,
	[platform] [nvarchar](255) NULL,
	[physical memory] [bigint] NULL,
	[deleted date] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computer_staging](
	[machineid] [int] NOT NULL,
	[sitecode] [nvarchar](3) NULL,
	[name] [nvarchar](256) NULL,
	[operating system] [nvarchar](256) NULL,
	[client type] [tinyint] NULL,
	[manufacturer] [nvarchar](255) NULL,
	[model] [nvarchar](255) NULL,
	[platform] [nvarchar](255) NULL,
	[physical memory] [bigint] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computercollection](
	[collectionid] [nvarchar](8) NOT NULL,
	[resourceid] [int] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computercollection_staging](
	[collectionid] [nvarchar](8) NOT NULL,
	[resourceid] [int] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computermalware](
	[threatid] [bigint] NULL,
	[machineid] [int] NOT NULL,
	[detection date] [datetime] NULL,
	[observer product name] [nvarchar](32) NOT NULL,
	[observer product version] [nvarchar](255) NULL,
	[observer detection] [nvarchar](8) NULL,
	[remediation type] [nvarchar](11) NULL,
	[remediation result] [nvarchar](5) NOT NULL,
	[remediation error code] [int] NULL,
	[remediation pending action] [nvarchar](16) NOT NULL,
	[is active malware] [nvarchar](5) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computermalware_staging](
	[threatid] [bigint] NULL,
	[machineid] [int] NOT NULL,
	[detection date] [datetime] NULL,
	[observer product name] [nvarchar](32) NOT NULL,
	[observer product version] [nvarchar](255) NULL,
	[observer detection] [nvarchar](8) NULL,
	[remediation type] [nvarchar](11) NULL,
	[remediation result] [nvarchar](5) NOT NULL,
	[remediation error code] [int] NULL,
	[remediation pending action] [nvarchar](16) NOT NULL,
	[is active malware] [nvarchar](5) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computerprogram](
	[machineid] [int] NOT NULL,
	[program name] [nvarchar](255) NOT NULL,
	[publisher] [nvarchar](255) NULL,
	[version] [nvarchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computerprogram_staging](
	[machineid] [int] NOT NULL,
	[program name] [nvarchar](255) NOT NULL,
	[publisher] [nvarchar](255) NULL,
	[version] [nvarchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computerupdate](
	[machineid] [int] NOT NULL,
	[ci_id] [int] NOT NULL,
	[laststatuschangetime] [datetime] NULL,
	[laststatuschecktime] [datetime] NULL,
	[status] [tinyint] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[computerupdate_staging](
	[machineid] [int] NOT NULL,
	[ci_id] [int] NOT NULL,
	[laststatuschangetime] [datetime] NULL,
	[laststatuschecktime] [datetime] NULL,
	[status] [tinyint] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ConfigMgrServerHealthBackupStatus](
	[SiteCode] [nvarchar](3) NOT NULL,
	[Backup Task] [varchar](8) NULL,
	[Time] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ConfigMgrServerHealthBackupStatus_staging](
	[SiteCode] [nvarchar](3) NOT NULL,
	[Backup Task] [varchar](8) NULL,
	[Time] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ConfigMgrServerHealthComponentStatusDetails](
	[Status] [varchar](8) NULL,
	[Component Name] [nvarchar](295) NOT NULL,
	[Site System] [nvarchar](255) NOT NULL,
	[Component Type] [nvarchar](64) NULL,
	[Site Code] [nvarchar](3) NOT NULL,
	[Availability State] [varchar](7) NULL,
	[State] [varchar](13) NULL,
	[Type] [varchar](13) NULL,
	[Infos Counter] [int] NULL,
	[Warnings Counter] [int] NULL,
	[Errors Counter] [int] NULL,
	[Last Contacted] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ConfigMgrServerHealthComponentStatusDetails_staging](
	[Status] [varchar](8) NULL,
	[Component Name] [nvarchar](295) NOT NULL,
	[Site System] [nvarchar](255) NOT NULL,
	[Component Type] [nvarchar](64) NULL,
	[Site Code] [nvarchar](3) NOT NULL,
	[Availability State] [varchar](7) NULL,
	[State] [varchar](13) NULL,
	[Type] [varchar](13) NULL,
	[Infos Counter] [int] NULL,
	[Warnings Counter] [int] NULL,
	[Errors Counter] [int] NULL,
	[Last Contacted] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ConfigMgrServerHealthCountComponentStatusMessagesBySeverity](
	[TotalMessages] [int] NULL,
	[Component] [nvarchar](128) NOT NULL,
	[Severity] [varchar](13) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ConfigMgrServerHealthCountComponentStatusMessagesBySeverity_staging](
	[TotalMessages] [int] NULL,
	[Component] [nvarchar](128) NOT NULL,
	[Severity] [varchar](13) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[configuration](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[configuration_group] [varchar](150) NOT NULL,
	[configuration_subgroup] [varchar](150) NOT NULL,
	[name] [varchar](150) NOT NULL,
	[value] [varchar](max) NULL,
	[visible] [bit] NOT NULL DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[date](
	[date_key] [int] NOT NULL,
	[full_date] [date] NOT NULL,
	[day_of_week] [tinyint] NOT NULL,
	[day_num_in_month] [tinyint] NOT NULL,
	[day_name] [char](9) NOT NULL,
	[day_abbrev] [char](3) NOT NULL,
	[weekday_flag] [char](1) NOT NULL,
	[week_num_in_year] [tinyint] NOT NULL,
	[week_begin_date] [date] NOT NULL,
	[week_begin_date_key] [int] NOT NULL,
	[month] [tinyint] NOT NULL,
	[month_name] [char](9) NOT NULL,
	[month_abbrev] [char](3) NOT NULL,
	[quarter] [tinyint] NOT NULL,
	[year] [smallint] NOT NULL,
	[yearmo] [int] NOT NULL,
	[fiscal_month] [tinyint] NOT NULL,
	[fiscal_quarter] [tinyint] NOT NULL,
	[fiscal_year] [smallint] NOT NULL,
	[last_day_in_month_flag] [char](1) NOT NULL,
	[same_day_year_ago_date] [date] NOT NULL,
	[same_day_year_ago_key] [int] NOT NULL,
	[day_num_in_year]  AS (datepart(dayofyear,[full_date])),
	[quarter_name]  AS (concat('Q',[quarter])),
	[fiscal_quarter_name]  AS (concat('Q',[fiscal_quarter])),
	[fiscalquartercompletename]  AS (concat('FY',substring(CONVERT([varchar],[fiscal_year]),(3),(2)),' Q',[fiscal_quarter])),
	[fiscalyearcompletename]  AS (concat('FY',substring(CONVERT([varchar],[fiscal_year]),(3),(2)))),
	[fiscalmonthcompletename]  AS (concat([month_abbrev],' ',substring(CONVERT([varchar],[fiscal_year]),(3),(2))))
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[DistributionPointsCompliancebyDPStatus](
	[DistributionPoint] [nvarchar](128) NOT NULL,
	[Failed] [int] NOT NULL,
	[InProgress] [int] NOT NULL,
	[Success] [int] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[DistributionPointsCompliancebyDPStatus_staging](
	[DistributionPoint] [nvarchar](128) NOT NULL,
	[Failed] [int] NOT NULL,
	[InProgress] [int] NOT NULL,
	[Success] [int] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[DistributionPointsCompliancebyPackagesStatus](
	[ServerName] [nvarchar](256) NULL,
	[SiteCode] [nvarchar](3) NOT NULL,
	[PackageID] [nvarchar](8) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[InstallStatus] [nvarchar](255) NOT NULL,
	[SummaryDate] [datetime] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[DistributionPointsCompliancebyPackagesStatus_staging](
	[ServerName] [nvarchar](256) NULL,
	[SiteCode] [nvarchar](3) NOT NULL,
	[PackageID] [nvarchar](8) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[InstallStatus] [nvarchar](255) NOT NULL,
	[SummaryDate] [datetime] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[DistributionPointsConfigurationStatus](
	[ServerName] [nvarchar](255) NULL,
	[DP Description] [nvarchar](256) NULL,
	[SiteCode] [nvarchar](3) NULL,
	[Branch DP] [varchar](1) NOT NULL,
	[BITS enabled] [varchar](1) NOT NULL,
	[AllowFallback] [varchar](1) NOT NULL,
	[PullDP] [varchar](1) NOT NULL,
	[PXE] [varchar](1) NOT NULL,
	[MultiCast] [varchar](1) NOT NULL,
	[TransferRate] [varchar](1) NOT NULL,
	[PrestagingAllowed] [varchar](1) NOT NULL,
	[ContentValidation] [varchar](1) NOT NULL,
	[DPGroupCount] [int] NOT NULL,
	[State] [varchar](11) NOT NULL,
	[MessageCount] [int] NULL,
	[LastStatusTime] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[DistributionPointsConfigurationStatus_staging](
	[ServerName] [nvarchar](255) NULL,
	[DP Description] [nvarchar](256) NULL,
	[SiteCode] [nvarchar](3) NULL,
	[Branch DP] [varchar](1) NOT NULL,
	[BITS enabled] [varchar](1) NOT NULL,
	[AllowFallback] [varchar](1) NOT NULL,
	[PullDP] [varchar](1) NOT NULL,
	[PXE] [varchar](1) NOT NULL,
	[MultiCast] [varchar](1) NOT NULL,
	[TransferRate] [varchar](1) NOT NULL,
	[PrestagingAllowed] [varchar](1) NOT NULL,
	[ContentValidation] [varchar](1) NOT NULL,
	[DPGroupCount] [int] NOT NULL,
	[State] [varchar](11) NOT NULL,
	[MessageCount] [int] NULL,
	[LastStatusTime] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[DistributionPointsStatus](
	[Failed] [int] NOT NULL,
	[In Progress] [int] NOT NULL,
	[Success] [int] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[DistributionPointsStatus_staging](
	[Failed] [int] NOT NULL,
	[In Progress] [int] NOT NULL,
	[Success] [int] NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[malware](
	[threatid] [bigint] NOT NULL,
	[malware name] [nvarchar](128) NOT NULL,
	[malware severity] [nvarchar](128) NOT NULL,
	[malware category] [nvarchar](128) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[malware_staging](
	[threatid] [bigint] NOT NULL,
	[malware name] [nvarchar](128) NOT NULL,
	[malware severity] [nvarchar](128) NOT NULL,
	[malware category] [nvarchar](128) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[operatingsystem](
	[osid] [int] IDENTITY(1,1) NOT NULL,
	[operating  system] [nvarchar](256) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[OverallComplianceBaseline](
	[ComplianceState] [tinyint] NOT NULL,
	[ComplianceStateName] [nvarchar](255) NULL,
	[TotPerState] [int] NULL,
	[PTot] [numeric](23, 13) NULL,
	[Tot] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[OverallComplianceBaseline_staging](
	[ComplianceState] [tinyint] NOT NULL,
	[ComplianceStateName] [nvarchar](255) NULL,
	[TotPerState] [int] NULL,
	[PTot] [numeric](23, 13) NULL,
	[Tot] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[program](
	[program name] [nvarchar](255) NOT NULL,
	[publisher] [nvarchar](255) NULL,
	[version] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[program_staging](
	[program name] [nvarchar](255) NOT NULL,
	[publisher] [nvarchar](255) NULL,
	[version] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ReplicationStatus](
	[OverallLinkStatus] [varchar](14) NULL,
	[Site Status Count] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ReplicationStatus_staging](
	[OverallLinkStatus] [varchar](14) NULL,
	[Site Status Count] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ReplicationStatusDetails](
	[ParentSiteCode] [varchar](16) NULL,
	[ChildSiteCode] [varchar](16) NULL,
	[OverallLinkStatus] [varchar](16) NULL,
	[GlobalParentToChildLinkStatus] [varchar](16) NULL,
	[GlobalChildToParentLinkStatus] [varchar](16) NULL,
	[SiteChildToParentLinkStatus] [varchar](16) NULL,
	[LastSendTimeParentToChild] [datetime] NULL,
	[LastSendTimeChildToParent] [datetime] NULL,
	[LastSiteSyncTime] [datetime] NULL,
	[ServerRole] [varchar](16) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ReplicationStatusDetails_staging](
	[ParentSiteCode] [varchar](16) NULL,
	[ChildSiteCode] [varchar](16) NULL,
	[OverallLinkStatus] [varchar](16) NULL,
	[GlobalParentToChildLinkStatus] [varchar](16) NULL,
	[GlobalChildToParentLinkStatus] [varchar](16) NULL,
	[SiteChildToParentLinkStatus] [varchar](16) NULL,
	[LastSendTimeParentToChild] [datetime] NULL,
	[LastSendTimeChildToParent] [datetime] NULL,
	[LastSiteSyncTime] [datetime] NULL,
	[ServerRole] [varchar](16) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ReplicationStatusReplicationGroup](
	[SiteRequesting] [nvarchar](3) NOT NULL,
	[SiteFulfilling] [nvarchar](3) NOT NULL,
	[ReplicationPattern] [nvarchar](20) NOT NULL,
	[ReplGroupsCompleted] [int] NULL,
	[ReplGroupsPending] [int] NULL,
	[ReplGroupsFailed] [int] NULL,
	[PercentComplete] [float] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[ReplicationStatusReplicationGroup_staging](
	[SiteRequesting] [nvarchar](3) NOT NULL,
	[SiteFulfilling] [nvarchar](3) NOT NULL,
	[ReplicationPattern] [nvarchar](20) NOT NULL,
	[ReplGroupsCompleted] [int] NULL,
	[ReplGroupsPending] [int] NULL,
	[ReplGroupsFailed] [int] NULL,
	[PercentComplete] [float] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[scanhistory](
	[machineid] [int] NOT NULL,
	[date_key] [int] NOT NULL,
	[sitecode] [nvarchar](3) NULL,
	[client type] [smallint] NULL,
	[enabled] [int] NULL,
	[client version] [nvarchar](255) NULL,
	[real time protection enabled] [bit] NULL,
	[on access protection enabled] [bit] NULL,
	[input/output protection enabled] [bit] NULL,
	[behavior monitor enabled] [bit] NULL,
	[antivirus enabled] [bit] NULL,
	[antispyware enabled] [bit] NULL,
	[nis enabled] [bit] NULL,
	[quick scan age (days)] [int] NULL,
	[full scan age (days)] [int] NULL,
	[signature age (days)] [int] NULL,
	[engine version] [nvarchar](255) NULL,
	[antivirus signature version] [nvarchar](255) NULL,
	[missing important update count] [int] NULL,
	[missing critical update count] [int] NULL,
	[client active status] [bit] NOT NULL,
	[health evaluation result] [smallint] NULL,
	[health evaluation] [datetime] NULL,
	[last online] [datetime] NULL,
	[health status message] [datetime] NULL,
	[client state] [smallint] NULL,
	[Last DDR] [datetime] NULL,
	[Last HW] [datetime] NULL,
	[Last SW] [datetime] NULL,
	[Last Status Message] [datetime] NULL,
	[Last Policy Request] [datetime] NULL,
	[Last Scan Time] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[scanhistory_staging](
	[machineid] [int] NOT NULL,
	[date_key] [int] NOT NULL,
	[sitecode] [nvarchar](3) NULL,
	[client type] [smallint] NULL,
	[enabled] [int] NULL,
	[client version] [nvarchar](255) NULL,
	[real time protection enabled] [bit] NULL,
	[on access protection enabled] [bit] NULL,
	[input/output protection enabled] [bit] NULL,
	[behavior monitor enabled] [bit] NULL,
	[antivirus enabled] [bit] NULL,
	[antispyware enabled] [bit] NULL,
	[nis enabled] [bit] NULL,
	[quick scan age (days)] [int] NULL,
	[full scan age (days)] [int] NULL,
	[signature age (days)] [int] NULL,
	[engine version] [nvarchar](255) NULL,
	[antivirus signature version] [nvarchar](255) NULL,
	[missing important update count] [int] NULL,
	[missing critical update count] [int] NULL,
	[client active status] [bit] NOT NULL,
	[health evaluation result] [smallint] NULL,
	[health evaluation] [datetime] NULL,
	[last online] [datetime] NULL,
	[health status message] [datetime] NULL,
	[client state] [smallint] NULL,
	[last ddr] [datetime] NULL,
	[last hw] [datetime] NULL,
	[last sw] [datetime] NULL,
	[last status message] [datetime] NULL,
	[last policy request] [datetime] NULL,
	[last scan time] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[site](
	[sitecode] [nvarchar](3) NOT NULL,
	[site name] [nvarchar](200) NULL,
	[version] [nvarchar](32) NULL,
	[server name] [nvarchar](256) NULL,
	[availability] [varchar](9) NOT NULL,
	[location] [nvarchar](256) NULL,
	[overalllinkstatus] [nvarchar](12) NULL,
	[client successfully communicating with mp] [int] NULL,
	[client failing to communicate with mp] [int] NULL,
	[health check count] [int] NULL,
	[ok health check count] [int] NULL,
	[av definition compliance count] [int] NULL,
	[scep count] [int] NULL,
	[av reach count] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[site_staging](
	[sitecode] [nvarchar](3) NOT NULL,
	[site name] [nvarchar](200) NULL,
	[version] [nvarchar](32) NULL,
	[server name] [nvarchar](256) NULL,
	[availability] [nvarchar](20) NOT NULL,
	[location] [nvarchar](256) NULL,
	[overalllinkstatus] [nvarchar](12) NULL,
	[client successfully communicating with mp] [int] NULL,
	[client failing to communicate with mp] [int] NULL,
	[health check count] [int] NULL,
	[ok health check count] [int] NULL,
	[av definition compliance count] [int] NULL,
	[scep count] [int] NULL,
	[av reach count] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[SoftwareDistribution](
	[success] [int] NULL,
	[inprogress] [int] NULL,
	[unknown] [int] NULL,
	[error] [int] NULL,
	[other] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[SoftwareDistribution_staging](
	[success] [int] NULL,
	[inprogress] [int] NULL,
	[unknown] [int] NULL,
	[error] [int] NULL,
	[other] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[SoftwareDistributionOverallApplicationDeployment](
	[CollectionID] [nvarchar](8) NULL,
	[CollectionName] [nvarchar](255) NULL,
	[OfferID] [nvarchar](8) NOT NULL,
	[SoftwareName] [nvarchar](359) NULL,
	[Application] [nvarchar](359) NULL,
	[NumberSuccess] [int] NULL,
	[NumberInProgress] [int] NULL,
	[NumberUnknown] [int] NULL,
	[NumberErrors] [int] NULL,
	[NumberOther] [int] NULL,
	[NumberTotal] [int] NULL,
	[packageID] [nvarchar](8) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[SoftwareDistributionOverallApplicationDeployment_staging](
	[CollectionID] [nvarchar](8) NULL,
	[CollectionName] [nvarchar](255) NULL,
	[OfferID] [nvarchar](8) NOT NULL,
	[SoftwareName] [nvarchar](359) NULL,
	[Application] [nvarchar](359) NULL,
	[NumberSuccess] [int] NULL,
	[NumberInProgress] [int] NULL,
	[NumberUnknown] [int] NULL,
	[NumberErrors] [int] NULL,
	[NumberOther] [int] NULL,
	[NumberTotal] [int] NULL,
	[packageID] [nvarchar](8) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[SoftwareDistributionOverallPackageDeployment](
	[CollectionID] [nvarchar](8) NULL,
	[CollectionName] [nvarchar](255) NULL,
	[OfferID] [nvarchar](8) NOT NULL,
	[SoftwareName] [nvarchar](359) NULL,
	[ProgramName] [nvarchar](100) NULL,
	[NumberSuccess] [int] NULL,
	[NumberInProgress] [int] NULL,
	[NumberUnknown] [int] NULL,
	[NumberErrors] [int] NULL,
	[NumberOther] [int] NULL,
	[NumberTotal] [int] NULL,
	[packageid] [nvarchar](8) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[SoftwareDistributionOverallPackageDeployment_staging](
	[CollectionID] [nvarchar](8) NULL,
	[CollectionName] [nvarchar](255) NULL,
	[OfferID] [nvarchar](8) NOT NULL,
	[SoftwareName] [nvarchar](359) NULL,
	[ProgramName] [nvarchar](100) NULL,
	[NumberSuccess] [int] NULL,
	[NumberInProgress] [int] NULL,
	[NumberUnknown] [int] NULL,
	[NumberErrors] [int] NULL,
	[NumberOther] [int] NULL,
	[NumberTotal] [int] NULL,
	[packageid] [nvarchar](8) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[SoftwareDistributionOverallPckAPPDPdistribution](
	[DPServer] [nvarchar](255) NULL,
	[PackageID] [nvarchar](8) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[SiteCode] [nvarchar](3) NULL,
	[InstallStatus] [nvarchar](255) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[SoftwareDistributionOverallPckAPPDPdistribution_staging](
	[DPServer] [nvarchar](255) NULL,
	[PackageID] [nvarchar](8) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[SiteCode] [nvarchar](3) NULL,
	[InstallStatus] [nvarchar](255) NOT NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[TaskSequenceDeployment](
	[TaskSequenceName] [nvarchar](256) NULL,
	[Success] [float] NULL,
	[Running] [float] NULL,
	[Failed] [float] NULL,
	[Unknown] [float] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[TaskSequenceDeployment_staging](
	[TaskSequenceName] [nvarchar](256) NULL,
	[Success] [float] NULL,
	[Running] [float] NULL,
	[Failed] [float] NULL,
	[Unknown] [float] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[TasksequenceDPContentStatusReferencedPackagesTaskSequence](
	[SiteCode] [nvarchar](3) NULL,
	[ServerName] [nvarchar](255) NULL,
	[PackageID] [nvarchar](8) NULL,
	[PackageName] [nvarchar](256) NULL,
	[Version] [nvarchar](64) NULL,
	[Status] [varchar](12) NULL,
	[SummaryDate] [datetime] NULL,
	[TaskSequenceID] [nvarchar](16) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[TasksequenceDPContentStatusReferencedPackagesTaskSequence_staging](
	[SiteCode] [nvarchar](3) NULL,
	[ServerName] [nvarchar](255) NULL,
	[PackageID] [nvarchar](8) NULL,
	[PackageName] [nvarchar](256) NULL,
	[Version] [nvarchar](64) NULL,
	[Status] [varchar](12) NULL,
	[SummaryDate] [datetime] NULL,
	[TaskSequenceID] [nvarchar](16) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[TasksequenceOverallTaskSequenceByComputerDeployment](
	[Netbios_Name0] [nvarchar](256) NULL,
	[name] [nvarchar](256) NULL,
	[ResourceID] [int] NOT NULL,
	[TaskSequenceID] [nvarchar](8) NULL,
	[AdvertisementID] [nvarchar](8) NOT NULL,
	[Date] [datetime] NULL,
	[State] [varchar](10) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[TasksequenceOverallTaskSequenceByComputerDeployment_staging](
	[Netbios_Name0] [nvarchar](256) NULL,
	[name] [nvarchar](256) NULL,
	[ResourceID] [int] NOT NULL,
	[TaskSequenceID] [nvarchar](8) NULL,
	[AdvertisementID] [nvarchar](8) NOT NULL,
	[Date] [datetime] NULL,
	[State] [varchar](10) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[TasksequenceOverallTaskSequencebyTaskSequenceDeployment](
	[TaskSequenceID] [nvarchar](8) NULL,
	[TaskSequenceName] [nvarchar](256) NULL,
	[Date] [varchar](30) NULL,
	[Total] [int] NULL,
	[Running] [int] NULL,
	[Successful] [int] NULL,
	[Failed] [int] NULL,
	[TSID] [nvarchar](8) NULL,
	[FullyDistributed] [int] NULL,
	[PartiallyDistributed] [int] NULL,
	[NotAssignedPackage] [int] NULL,
	[TotalPkg] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[TasksequenceOverallTaskSequencebyTaskSequenceDeployment_staging](
	[TaskSequenceID] [nvarchar](8) NULL,
	[TaskSequenceName] [nvarchar](256) NULL,
	[Date] [varchar](30) NULL,
	[Total] [int] NULL,
	[Running] [int] NULL,
	[Successful] [int] NULL,
	[Failed] [int] NULL,
	[TSID] [nvarchar](8) NULL,
	[FullyDistributed] [int] NULL,
	[PartiallyDistributed] [int] NULL,
	[NotAssignedPackage] [int] NULL,
	[TotalPkg] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[update](
	[ci_id] [int] NOT NULL,
	[articleid] [nvarchar](64) NULL,
	[bulletinid] [nvarchar](64) NULL,
	[title] [nvarchar](513) NULL,
	[severity] [int] NULL,
	[severityname] [nvarchar](64) NULL,
	[infoURL] [nvarchar](512) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[update_staging](
	[ci_id] [int] NOT NULL,
	[articleid] [nvarchar](64) NULL,
	[bulletinid] [nvarchar](64) NULL,
	[title] [nvarchar](513) NULL,
	[severity] [int] NULL,
	[severity name] [nvarchar](64) NULL,
	[infourl] [nvarchar](512) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[user](
	[username] [nvarchar](256) NULL,
	[full name] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[user_staging](
	[username] [nvarchar](256) NULL,
	[full name] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[usercomputer](
	[machineid] [int] NOT NULL,
	[username] [nvarchar](256) NULL,
	[full name] [nvarchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [pbist_sccm].[usercomputer_staging](
	[machineid] [int] NOT NULL,
	[username] [nvarchar](256) NULL,
	[full name] [nvarchar](255) NULL
) ON [PRIMARY]

GO

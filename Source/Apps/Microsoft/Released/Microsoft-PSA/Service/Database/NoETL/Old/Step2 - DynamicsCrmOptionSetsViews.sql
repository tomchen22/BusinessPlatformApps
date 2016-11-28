CREATE VIEW [dbo].[accountcategorycode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'accountcategorycode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[accountclassificationcode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'accountclassificationcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[accountratingcode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'accountratingcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[account_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'account'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[address1_addresstypecode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'address1_addresstypecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[address1_freighttermscode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'address1_freighttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[address1_shippingmethodcode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'address1_shippingmethodcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[address2_addresstypecode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'address2_addresstypecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[address2_freighttermscode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'address2_freighttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[address2_shippingmethodcode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'address2_shippingmethodcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[bookableresourcebooking_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'bookableresourcebooking'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookableresourcebooking_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'bookableresourcebooking'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookableresourcecategoryassn_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'bookableresourcecategoryassn'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookableresourcecategoryassn_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'bookableresourcecategoryassn'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookableresourcecategory_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'bookableresourcecategory'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookableresourcecategory_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'bookableresourcecategory'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookableresource_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'bookableresource'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookableresource_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'bookableresource'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookingstatus_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'bookingstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookingstatus_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'bookingstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[bookingtype_os_bookableresourcebooking]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'bookingtype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'bookableresourcebooking'

GO

CREATE VIEW [dbo].[budgetstatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'budgetstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[businesstypecode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'businesstypecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[customersizecode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'customersizecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[customertypecode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'customertypecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[freighttermscode_os_quote]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'freighttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'quote'

GO

CREATE VIEW [dbo].[freighttermscode_os_salesorder]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'freighttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'salesorder'

GO

CREATE VIEW [dbo].[industrycode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'industrycode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[initialcommunication_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'initialcommunication'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_actual_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_actual'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_actual_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_actual'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_adjustmentstatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_adjustmentstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_allocationmethod_os_msdyn_projectteam]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_allocationmethod'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'msdyn_projectteam'

GO

CREATE VIEW [dbo].[msdyn_allocationmethod_os_msdyn_resourcerequirement]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_allocationmethod'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'msdyn_resourcerequirement'

GO

CREATE VIEW [dbo].[msdyn_amountmethod_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_amountmethod'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_billingmethod_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_billingmethod'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_billingstatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_billingstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_billingtype_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_billingtype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_bulkgenerationstatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_bulkgenerationstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_committype_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_committype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_competitive_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_competitive'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_costperformence_os_msdyn_project]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_costperformence'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'msdyn_project'

GO

CREATE VIEW [dbo].[msdyn_customertype_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_customertype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_entrystatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_entrystatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_estimatedbudget_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_estimatedbudget'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_estimatedschedule_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_estimatedschedule'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_estimateline_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_estimateline'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_estimateline_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_estimateline'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_expensecategory_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_expensecategory'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_expensecategory_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_expensecategory'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_expensestatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_expensestatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_expensetype_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_expensetype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_expense_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_expense'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_expense_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_expense'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_feasible_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_feasible'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_membershipstatus_os_msdyn_projectteam]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_membershipstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'msdyn_projectteam'

GO

CREATE VIEW [dbo].[msdyn_orderlineresourcecategory_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_orderlineresourcecategory'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_orderlineresourcecategory_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_orderlineresourcecategory'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_ordertype_os_opportunity]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_ordertype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'opportunity'

GO

CREATE VIEW [dbo].[msdyn_ordertype_os_quote]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_ordertype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'quote'

GO

CREATE VIEW [dbo].[msdyn_ordertype_os_salesorder]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_ordertype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'salesorder'

GO

CREATE VIEW [dbo].[msdyn_organizationalunit_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_organizationalunit'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_organizationalunit_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_organizationalunit'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_overallprojectstatus_os_msdyn_project]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_overallprojectstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'msdyn_project'

GO

CREATE VIEW [dbo].[msdyn_profitability_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_profitability'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_projectteam_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_projectteam'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_projectteam_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_projectteam'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_project_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_project'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_project_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_project'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_psastate_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_psastate'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_psastatusreason_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_psastatusreason'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_receiptrequired_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_receiptrequired'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_relateditemtype_os_msdyn_timeentry]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_relateditemtype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'msdyn_timeentry'

GO

CREATE VIEW [dbo].[msdyn_resourcerequest_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_resourcerequest'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_resourcerequest_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_resourcerequest'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_resourcerequirementdetail_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_resourcerequirementdetail'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_resourcerequirementdetail_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_resourcerequirementdetail'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_resourcerequirement_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_resourcerequirement'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_resourcerequirement_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_resourcerequirement'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_scheduleperformance_os_msdyn_project]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_scheduleperformance'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'msdyn_project'

GO

CREATE VIEW [dbo].[msdyn_targetentrystatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_targetentrystatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_targetexpensestatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_targetexpensestatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_timeentry_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_timeentry'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_timeentry_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_timeentry'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_timeoffcalendar_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'msdyn_timeoffcalendar'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_timeoffcalendar_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'msdyn_timeoffcalendar'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_transactionclassification_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_transactionclassification'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_transactiontypecode_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_transactiontypecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_type_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_type'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[msdyn_type_os_msdyn_resourcerequirement]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'msdyn_type'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'msdyn_resourcerequirement'

GO

CREATE VIEW [dbo].[msdyn_vendortype_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'msdyn_vendortype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[need_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'need'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[opportunityclose_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'opportunityclose'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[opportunityclose_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'opportunityclose'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[opportunityratingcode_os_opportunity]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'opportunityratingcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'opportunity'

GO

CREATE VIEW [dbo].[opportunity_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'opportunity'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[opportunity_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'opportunity'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[ownershipcode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'ownershipcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[paymenttermscode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'paymenttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[paymenttermscode_os_quote]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'paymenttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'quote'

GO

CREATE VIEW [dbo].[paymenttermscode_os_salesorder]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'paymenttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'salesorder'

GO

CREATE VIEW [dbo].[preferredappointmentdaycode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'preferredappointmentdaycode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[preferredappointmenttimecode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'preferredappointmenttimecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[preferredcontactmethodcode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'preferredcontactmethodcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[pricingerrorcode_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'pricingerrorcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[prioritycode_os_opportunity]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'prioritycode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'opportunity'

GO

CREATE VIEW [dbo].[prioritycode_os_salesorder]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'prioritycode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'salesorder'

GO

CREATE VIEW [dbo].[producttypecode_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'producttypecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[propertyconfigurationstatus_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'propertyconfigurationstatus'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[purchaseprocess_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'purchaseprocess'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[purchasetimeframe_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'purchasetimeframe'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[quoteclose_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'quoteclose'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[quoteclose_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'quoteclose'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[quotestatecode_os_quotedetail]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'quotestatecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'quotedetail'

GO

CREATE VIEW [dbo].[quote_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'quote'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[quote_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'quote'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[resourcetype_os_bookableresource]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'resourcetype'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'bookableresource'

GO

CREATE VIEW [dbo].[salesorderstatecode_os_salesorderdetail]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'salesorderstatecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'salesorderdetail'

GO

CREATE VIEW [dbo].[salesorder_state]
AS
select 
	[State] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StateMetadata]
where [EntityName] = 'salesorder'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[salesorder_status]
AS
select 
	[Status] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[StatusMetadata]
where [EntityName] = 'salesorder'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[salesstagecode_os_opportunity]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'salesstagecode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'opportunity'

GO

CREATE VIEW [dbo].[salesstage_gos]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[GlobalOptionSetMetadata] 
where [OptionsetName] = 'salesstage'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033

GO

CREATE VIEW [dbo].[shippingmethodcode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'shippingmethodcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[shippingmethodcode_os_quote]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'shippingmethodcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'quote'

GO

CREATE VIEW [dbo].[shippingmethodcode_os_salesorder]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'shippingmethodcode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'salesorder'

GO

CREATE VIEW [dbo].[shipto_freighttermscode_os_quote]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'shipto_freighttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'quote'

GO

CREATE VIEW [dbo].[shipto_freighttermscode_os_quotedetail]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'shipto_freighttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'quotedetail'

GO

CREATE VIEW [dbo].[shipto_freighttermscode_os_salesorder]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'shipto_freighttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'salesorder'

GO

CREATE VIEW [dbo].[shipto_freighttermscode_os_salesorderdetail]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'shipto_freighttermscode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'salesorderdetail'

GO

CREATE VIEW [dbo].[status_os_bookingstatus]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'status'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'bookingstatus'

GO

CREATE VIEW [dbo].[territorycode_os_account]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'territorycode'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'account'

GO

CREATE VIEW [dbo].[timeline_os_opportunity]
AS
select 
	[Option] as [Value], 
	[LocalizedLabel] as [Label] 
from [dbo].[OptionSetMetadata] 
where [OptionsetName] = 'timeline'
and [isUserLocalizedLabel] = 1
and [LocalizedLabelLanguageCode] = 1033
and [EntityName] = 'opportunity'

GO


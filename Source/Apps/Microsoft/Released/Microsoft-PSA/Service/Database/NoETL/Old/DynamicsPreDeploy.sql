
--- DROP PSA VIEWS---

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ZResourceCapacityView' AND TABLE_TYPE='View')
    DROP View [psa].[ZResourceCapacityView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='TransactionCategoryView' AND TABLE_TYPE='View')
    DROP View [psa].[TransactionCategoryView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='TimeEntryView' AND TABLE_TYPE='View')
    DROP View [psa].[TimeEntryView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ResourceView' AND TABLE_TYPE='View')
    DROP View [psa].[ResourceView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ResourceRequirementView' AND TABLE_TYPE='View')
    DROP View [psa].[ResourceRequirementView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ResourceRequirementDetailView' AND TABLE_TYPE='View')
    DROP View [psa].[ResourceRequirementDetailView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ResourceRequestView' AND TABLE_TYPE='View')
    DROP View [psa].[ResourceRequestView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ResourceBookingView' AND TABLE_TYPE='View')
    DROP View [psa].[ResourceBookingView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='QuoteView' AND TABLE_TYPE='View')
    DROP View [psa].[QuoteView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='QuoteLineView' AND TABLE_TYPE='View')
    DROP View [psa].[QuoteLineView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ProjectView' AND TABLE_TYPE='View')
    DROP View [psa].[ProjectView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ProjectContractView' AND TABLE_TYPE='View')
    DROP View [psa].[ProjectContractView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='OrganizationalUnitView' AND TABLE_TYPE='View')
    DROP View [psa].[OrganizationalUnitView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='OpportunityView' AND TABLE_TYPE='View')
    DROP View [psa].[OpportunityView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='NamedResourceWorkCapacityView' AND TABLE_TYPE='View')
    DROP View [psa].[NamedResourceWorkCapacityView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='MeasuresView' AND TABLE_TYPE='View')
    DROP View [psa].[MeasuresView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='DefaultResourceCategoryView' AND TABLE_TYPE='View')
    DROP View [psa].[DefaultResourceCategoryView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='DateView' AND TABLE_TYPE='View')
    DROP View [psa].[DateView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='DateCapacityView' AND TABLE_TYPE='View')
    DROP View [psa].[DateCapacityView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='CustomerView' AND TABLE_TYPE='View')
    DROP View [psa].[CustomerView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ContractView' AND TABLE_TYPE='View')
    DROP View [psa].[ContractView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='ContractLineView' AND TABLE_TYPE='View')
    DROP View [psa].[ContractLineView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='BusinessTransactionView' AND TABLE_TYPE='View')
    DROP View [psa].[BusinessTransactionView]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='BookingStatusView' AND TABLE_TYPE='View')
    DROP View [psa].[BookingStatusView]

GO


--- DROP PSA TABLES---

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='WeekDayCapacity' AND TABLE_TYPE='BASE TABLE')
    DROP Table [psa].[WeekDayCapacity]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='psa' AND TABLE_NAME='Date' AND TABLE_TYPE='BASE TABLE')
    DROP Table [psa].[Date]

GO


--- DROP DBO TABLES---

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='timeline_os_opportunity' AND TABLE_TYPE='View')
    DROP View [dbo].[timeline_os_opportunity]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='territorycode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[territorycode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='status_os_bookingstatus' AND TABLE_TYPE='View')
    DROP View [dbo].[status_os_bookingstatus]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='shipto_freighttermscode_os_salesorderdetail' AND TABLE_TYPE='View')
    DROP View [dbo].[shipto_freighttermscode_os_salesorderdetail]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='shipto_freighttermscode_os_salesorder' AND TABLE_TYPE='View')
    DROP View [dbo].[shipto_freighttermscode_os_salesorder]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='shipto_freighttermscode_os_quotedetail' AND TABLE_TYPE='View')
    DROP View [dbo].[shipto_freighttermscode_os_quotedetail]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='shipto_freighttermscode_os_quote' AND TABLE_TYPE='View')
    DROP View [dbo].[shipto_freighttermscode_os_quote]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='shippingmethodcode_os_salesorder' AND TABLE_TYPE='View')
    DROP View [dbo].[shippingmethodcode_os_salesorder]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='shippingmethodcode_os_quote' AND TABLE_TYPE='View')
    DROP View [dbo].[shippingmethodcode_os_quote]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='shippingmethodcode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[shippingmethodcode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='salesstage_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[salesstage_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='salesstagecode_os_opportunity' AND TABLE_TYPE='View')
    DROP View [dbo].[salesstagecode_os_opportunity]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='salesorder_status' AND TABLE_TYPE='View')
    DROP View [dbo].[salesorder_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='salesorder_state' AND TABLE_TYPE='View')
    DROP View [dbo].[salesorder_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='salesorderstatecode_os_salesorderdetail' AND TABLE_TYPE='View')
    DROP View [dbo].[salesorderstatecode_os_salesorderdetail]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='resourcetype_os_bookableresource' AND TABLE_TYPE='View')
    DROP View [dbo].[resourcetype_os_bookableresource]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='quote_status' AND TABLE_TYPE='View')
    DROP View [dbo].[quote_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='quote_state' AND TABLE_TYPE='View')
    DROP View [dbo].[quote_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='quotestatecode_os_quotedetail' AND TABLE_TYPE='View')
    DROP View [dbo].[quotestatecode_os_quotedetail]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='quoteclose_status' AND TABLE_TYPE='View')
    DROP View [dbo].[quoteclose_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='quoteclose_state' AND TABLE_TYPE='View')
    DROP View [dbo].[quoteclose_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='purchasetimeframe_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[purchasetimeframe_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='purchaseprocess_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[purchaseprocess_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='propertyconfigurationstatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[propertyconfigurationstatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='producttypecode_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[producttypecode_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='prioritycode_os_salesorder' AND TABLE_TYPE='View')
    DROP View [dbo].[prioritycode_os_salesorder]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='prioritycode_os_opportunity' AND TABLE_TYPE='View')
    DROP View [dbo].[prioritycode_os_opportunity]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='pricingerrorcode_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[pricingerrorcode_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='preferredcontactmethodcode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[preferredcontactmethodcode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='preferredappointmenttimecode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[preferredappointmenttimecode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='preferredappointmentdaycode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[preferredappointmentdaycode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='paymenttermscode_os_salesorder' AND TABLE_TYPE='View')
    DROP View [dbo].[paymenttermscode_os_salesorder]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='paymenttermscode_os_quote' AND TABLE_TYPE='View')
    DROP View [dbo].[paymenttermscode_os_quote]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='paymenttermscode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[paymenttermscode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='ownershipcode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[ownershipcode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='opportunity_status' AND TABLE_TYPE='View')
    DROP View [dbo].[opportunity_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='opportunity_state' AND TABLE_TYPE='View')
    DROP View [dbo].[opportunity_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='opportunityratingcode_os_opportunity' AND TABLE_TYPE='View')
    DROP View [dbo].[opportunityratingcode_os_opportunity]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='opportunityclose_status' AND TABLE_TYPE='View')
    DROP View [dbo].[opportunityclose_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='opportunityclose_state' AND TABLE_TYPE='View')
    DROP View [dbo].[opportunityclose_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='need_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[need_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_vendortype_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_vendortype_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_type_os_msdyn_resourcerequirement' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_type_os_msdyn_resourcerequirement]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_type_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_type_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_transactiontypecode_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_transactiontypecode_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_transactionclassification_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_transactionclassification_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_timeoffcalendar_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_timeoffcalendar_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_timeoffcalendar_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_timeoffcalendar_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_timeentry_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_timeentry_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_timeentry_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_timeentry_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_targetexpensestatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_targetexpensestatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_targetentrystatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_targetentrystatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_scheduleperformance_os_msdyn_project' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_scheduleperformance_os_msdyn_project]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequirement_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_resourcerequirement_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequirement_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_resourcerequirement_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequirementdetail_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_resourcerequirementdetail_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequirementdetail_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_resourcerequirementdetail_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequest_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_resourcerequest_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequest_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_resourcerequest_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_relateditemtype_os_msdyn_timeentry' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_relateditemtype_os_msdyn_timeentry]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_receiptrequired_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_receiptrequired_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_psastatusreason_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_psastatusreason_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_psastate_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_psastate_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_project_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_project_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_project_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_project_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_projectteam_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_projectteam_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_projectteam_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_projectteam_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_profitability_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_profitability_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_overallprojectstatus_os_msdyn_project' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_overallprojectstatus_os_msdyn_project]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_organizationalunit_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_organizationalunit_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_organizationalunit_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_organizationalunit_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_ordertype_os_salesorder' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_ordertype_os_salesorder]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_ordertype_os_quote' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_ordertype_os_quote]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_ordertype_os_opportunity' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_ordertype_os_opportunity]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_orderlineresourcecategory_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_orderlineresourcecategory_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_orderlineresourcecategory_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_orderlineresourcecategory_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_membershipstatus_os_msdyn_projectteam' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_membershipstatus_os_msdyn_projectteam]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_feasible_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_feasible_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_expense_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_expense_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_expense_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_expense_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_expensetype_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_expensetype_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_expensestatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_expensestatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_expensecategory_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_expensecategory_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_expensecategory_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_expensecategory_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_estimateline_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_estimateline_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_estimateline_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_estimateline_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_estimatedschedule_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_estimatedschedule_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_estimatedbudget_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_estimatedbudget_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_entrystatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_entrystatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_customertype_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_customertype_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_costperformence_os_msdyn_project' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_costperformence_os_msdyn_project]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_competitive_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_competitive_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_committype_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_committype_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_bulkgenerationstatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_bulkgenerationstatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_billingtype_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_billingtype_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_billingstatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_billingstatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_billingmethod_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_billingmethod_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_amountmethod_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_amountmethod_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_allocationmethod_os_msdyn_resourcerequirement' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_allocationmethod_os_msdyn_resourcerequirement]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_allocationmethod_os_msdyn_projectteam' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_allocationmethod_os_msdyn_projectteam]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_adjustmentstatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_adjustmentstatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_actual_status' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_actual_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_actual_state' AND TABLE_TYPE='View')
    DROP View [dbo].[msdyn_actual_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='initialcommunication_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[initialcommunication_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='industrycode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[industrycode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='freighttermscode_os_salesorder' AND TABLE_TYPE='View')
    DROP View [dbo].[freighttermscode_os_salesorder]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='freighttermscode_os_quote' AND TABLE_TYPE='View')
    DROP View [dbo].[freighttermscode_os_quote]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='customertypecode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[customertypecode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='customersizecode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[customersizecode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='businesstypecode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[businesstypecode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='budgetstatus_gos' AND TABLE_TYPE='View')
    DROP View [dbo].[budgetstatus_gos]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookingtype_os_bookableresourcebooking' AND TABLE_TYPE='View')
    DROP View [dbo].[bookingtype_os_bookableresourcebooking]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookingstatus_status' AND TABLE_TYPE='View')
    DROP View [dbo].[bookingstatus_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookingstatus_state' AND TABLE_TYPE='View')
    DROP View [dbo].[bookingstatus_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresource_status' AND TABLE_TYPE='View')
    DROP View [dbo].[bookableresource_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresource_state' AND TABLE_TYPE='View')
    DROP View [dbo].[bookableresource_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcecategory_status' AND TABLE_TYPE='View')
    DROP View [dbo].[bookableresourcecategory_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcecategory_state' AND TABLE_TYPE='View')
    DROP View [dbo].[bookableresourcecategory_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcecategoryassn_status' AND TABLE_TYPE='View')
    DROP View [dbo].[bookableresourcecategoryassn_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcecategoryassn_state' AND TABLE_TYPE='View')
    DROP View [dbo].[bookableresourcecategoryassn_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcebooking_status' AND TABLE_TYPE='View')
    DROP View [dbo].[bookableresourcebooking_status]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcebooking_state' AND TABLE_TYPE='View')
    DROP View [dbo].[bookableresourcebooking_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='address2_shippingmethodcode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[address2_shippingmethodcode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='address2_freighttermscode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[address2_freighttermscode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='address2_addresstypecode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[address2_addresstypecode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='address1_shippingmethodcode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[address1_shippingmethodcode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='address1_freighttermscode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[address1_freighttermscode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='address1_addresstypecode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[address1_addresstypecode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='account_state' AND TABLE_TYPE='View')
    DROP View [dbo].[account_state]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='accountratingcode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[accountratingcode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='accountclassificationcode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[accountclassificationcode_os_account]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='accountcategorycode_os_account' AND TABLE_TYPE='View')
    DROP View [dbo].[accountcategorycode_os_account]

GO


--- DROP DBO TABLES---

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='systemuser' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[systemuser]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='StatusMetadata' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[StatusMetadata]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='StateMetadata' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[StateMetadata]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='salesorderdetail' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[salesorderdetail]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='salesorder' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[salesorder]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='quotedetail' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[quotedetail]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='quote' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[quote]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='OptionSetMetadata' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[OptionSetMetadata]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='opportunity' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[opportunity]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_transactioncategory' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_transactioncategory]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_timeentry' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_timeentry]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequirementdetail' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_resourcerequirementdetail]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequirement' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_resourcerequirement]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_resourcerequest' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_resourcerequest]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_project' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_project]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_organizationalunit' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_organizationalunit]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_orderlineresourcecategory' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_orderlineresourcecategory]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_estimateline' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_estimateline]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='msdyn_actual' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[msdyn_actual]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='GlobalOptionSetMetadata' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[GlobalOptionSetMetadata]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookingstatus' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[bookingstatus]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcecategoryassn' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[bookableresourcecategoryassn]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcecategory' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[bookableresourcecategory]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresourcebooking' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[bookableresourcebooking]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='bookableresource' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[bookableresource]

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' AND TABLE_NAME='account' AND TABLE_TYPE='BASE TABLE')
    DROP Table [dbo].[account]

GO

--- DROP PSA SCHEMA ---
IF EXISTS (SELECT * FROM sys.schemas WHERE name='psa')
BEGIN
    DROP SCHEMA psa;
END;

GO


CREATE VIEW [psa].[BookingStatusView]
AS
SELECT   
	bookingstatusid					as [Booking Status Id],
	status							as [Booking Status Code],
	bookingstatus.Label				as [Booking Status Name],
	CommitType.Label				as [Commit Type],
	msdyn_committype				as [Commit Type Code]

FROM dbo.bookingstatus bs
	left outer join dbo.status_os_bookingstatus		bookingstatus	on status			= bookingstatus.Value
	left outer join dbo.msdyn_committype_gos		CommitType		on CommitType.Value = msdyn_committype
WHERE 
 not (((statecode != 0) and (DATEDIFF(YEAR, GETDATE(), ModifiedOn) < -1)))



GO

CREATE VIEW [psa].[BusinessTransactionView]
AS
SELECT
	0 											as [Is Estimate],       
	CONVERT(date, msdyn_DocumentDate)			as [Document Date],
	BillingType.Label			 				as [Billing Type],
	BillingStatus.Label				 			as [Billing Status],
	msdyn_BillingType 							as [Billing Type Code],
	msdyn_BillingStatus 						as [Billing Status Code],
	msdyn_TransactionCategory 					as [Transaction Category Id],
	msdyn_TransactionTypeCode 					as [Transaction Type Code], 
	msdyn_TransactionClassification 			as [Transaction Class Code], 
	TransactionTypeCode.Label			 		as [Transaction Type], 
	TransactionClass.Label					    as [Transaction Class], 
	msdyn_AccountCustomer 						as [Customer Id],
	msdyn_Quantity 								as [Quantity],
	msdyn_BookableResource 						as [Resource Id],
	msdyn_Project 								as [Project Id],
	msdyn_SalesContractLine 					as [Contract Line Id], 
	msdyn_SalesContract 						as [Contract Id], 
	msdyn_amount_Base 							as [Amount], 
	msdyn_ResourceCategory 						as [Resource Category Id]

FROM	dbo.msdyn_actual
	left outer join dbo.msdyn_transactionclassification_gos TransactionClass		on TransactionClass.Value		= msdyn_TransactionClassification
	left outer join dbo.msdyn_transactiontypecode_gos		TransactionTypeCode		on TransactionTypeCode.Value	= msdyn_transactiontypecode
	left outer join dbo.msdyn_billingtype_gos				BillingType				on BillingType.Value			= msdyn_billingtype
	left outer join dbo.msdyn_billingstatus_gos				BillingStatus			on BillingStatus.Value			= msdyn_billingStatus
WHERE   
		(DATEDIFF(YEAR, GETDATE(), msdyn_DocumentDate) >= -1)
		and (DATEDIFF(DAY, GETDATE(), msdyn_DocumentDate) <= 366)

UNION ALL

SELECT
	1 											as [Is Estimate],       
	CONVERT(date, msdyn_DocumentDate)			as [Document Date],
	BillingType.Label				   			as [Billing Type],
	null 										as [Billing Status],
	msdyn_BillingType 							as [Billing Type Code],
	null 										as [Billing Status Code],
	msdyn_TransactionCategory 					as [Transaction Category Id],
	msdyn_TransactionTypeCode 					as [Transaction Type Code], 
	msdyn_TransactionClassification 			as [Transaction Class Code], 
	TransactionTypeCode.Label 					as [Transaction Type], 
	TransactionClass.Label						as [Transaction Class], 
	msdyn_AccountCustomer 						as [Customer Id],
	msdyn_Quantity 								as [Quantity],
	msdyn_BookableResource 						as [Resource Id],
	msdyn_Project 								as [Project Id],
	null 										as [Contract Line Id], 
	null 										as [Contract Id], 
	msdyn_amount_Base 							as [Amount], 
	msdyn_ResourceCategory 						as [Resource Category Id]

FROM    dbo.msdyn_estimateline
	left outer join dbo.msdyn_transactionclassification_gos TransactionClass		on TransactionClass.Value		= msdyn_TransactionClassification
	left outer join dbo.msdyn_transactiontypecode_gos		TransactionTypeCode		on TransactionTypeCode.Value	= msdyn_transactiontypecode
	left outer join dbo.msdyn_billingtype_gos				BillingType				on BillingType.Value			= msdyn_billingtype
WHERE   
		(DATEDIFF(YEAR, GETDATE(), msdyn_DocumentDate) >= -1)
		and (DATEDIFF(DAY, GETDATE(), msdyn_DocumentDate) <= 366)

GO

CREATE VIEW [psa].[ContractLineView]
AS
SELECT        
	salesorderid					as [Contract Id],
	salesorderdetailid				as [Contract Line Id],
	productdescription				as [Contract Line Description],	
	BillingMethod.Label				as [Billing Method],
	msdyn_project					as [Project Id]

FROM    dbo.salesorderdetail
	left outer join dbo.msdyn_billingmethod_gos BillingMethod on BillingMethod.Value = msdyn_billingmethod
WHERE	
   EXISTS(
	SELECT salesorderid FROM dbo.salesorder
	WHERE not (((msdyn_PSAState = 192350003) and (DATEDIFF(YEAR, GETDATE(), ModifiedOn) < -1)))
	)
/*Pickup lines for all not closed contracts and the ones that were closed last year*/

GO

CREATE VIEW [psa].[ContractView]
AS
SELECT        
	salesorderid				as [Contract Id], 
	name						as [Contract Name], 
	msdyn_psastate				as [Contract State Code], 
	PSA_State.Label				as [Contract State], 
	msdyn_psastatusreason		as [Contract Status Code], 
	PSA_StatusReason.Label		as [Contract Status], 	
	customerid					as [Contract Customer Id],		
	totalamount_base			as [Contract Total Amount]

FROM	dbo.salesorder
	left outer join dbo.msdyn_psastate_gos			PSA_State			on PSA_State.Value			= msdyn_psastate
	left outer join dbo.msdyn_psastatusreason_gos	PSA_StatusReason	on PSA_StatusReason.Value	= msdyn_psastatusreason
WHERE   
not (((msdyn_PSAState = 192350003) and (DATEDIFF(YEAR, GETDATE(), ModifiedOn) < -1)))
/*Pickup all not closed contracts and the ones that were closed last year*/
		




GO

CREATE VIEW [psa].[CustomerView]
AS
SELECT        
	accountid							as [Customer Id], 
	name								as [Customer Name], 
	sic									as [SIC], 
	address1_postalcode					as [Postal Code], 
	address1_telephone1					as [Phone], 
	address1_stateorprovince			as [State/Province],
	address1_country					as [Country], 
	address1_city						as [City], 
	emailaddress1						as [E-Mail], 
	customertypecode.Label				as [Customer Type],
	industrycode						as [Industry Code],
	IndustryCode.Label					as [Industry]

FROM    dbo.account
	left outer join dbo.customertypecode_os_account CustomerTypeCode on CustomerTypeCode.Value = customertypecode
	left outer join dbo.industrycode_os_account		IndustryCode	 on IndustryCode.Value	   = industrycode
WHERE   
 not (((statecode != 0) and (DATEDIFF(YEAR, GETDATE(), ModifiedOn) < -1)))
/*Active customers and customers that became inactive during last year*/


GO

CREATE VIEW [psa].[DateCapacityView]
AS
SELECT
	dt.full_date				as [Capacity Date], 
	dc.capacityMinutes			as [Capacity Minutes],
	dc.capacityMinutes/60.0		as [Capacity Hours]

FROM psa.Date dt
JOIN psa.WeekDayCapacity dc
ON dt.day_of_week = dc.day_of_week
WHERE
 (DATEDIFF(YEAR, GETDATE(), full_date) >= -1)
 and
 (DATEDIFF(DAY, GETDATE(), full_date) <= 366)

GO

CREATE VIEW [psa].[DateView]
AS
SELECT
	[full_date]				as [Date],
	[year]					as [Year],
   
	[quarter]			    as [Quarter],
	[quarter_start_date]    as [Quarter Start Date],
	[quarter_end_date]      as [Quarter End Date],
	[quarter_name]			as [Quarter Name],
	[quarter_abbrevYear]    as [Quarter With Year],
   
	[month]					as [Month],
	[month_start_date]		as [Month Start Date],
	[month_end_date]		as [Month End Date],
	[month_name]			as [Month Name],
	[month_abbrev]			as [Month Abbreviation],
	[month_abbrevYear]		as [Month With Year],
     
	[day_of_year]			as [Day of Year],
	[day_of_month]			as [Day of Month],
	[day_of_week]			as [Day of Week],   
	[day_name]				as [Day Name],
	[day_abbrev]			as [Day Abbreviation],
   
	[weeek_of_year]			as [Week of Year],
	[week_start_date]		as [Week Start Date],
	[week_end_date]			as [Week End Date],
	[week_time_frame]		as [Week Time Frame],

	CASE (DATEDIFF(YEAR, GETDATE(), full_date))
		WHEN -1 THEN 'Previous Year'
		WHEN 0 THEN 'Current Year'
		WHEN 1 THEN 'Next Year'
		ELSE NULL
	END AS [Year Slice],

	CASE (DATEDIFF(MONTH, GETDATE(), full_date))
		WHEN -1 THEN 'Previous Month'
		WHEN 0 THEN 'Current Month'
		WHEN 1 THEN 'Next Month'
		WHEN -12 THEN 'Same Month Previous Year'
		ELSE NULL
	END AS [Month Slice],

	CASE (DATEDIFF(QUARTER, GETDATE(), full_date))
		WHEN -1 THEN 'Previous Quarter'
		WHEN 0 THEN 'Current Quarter'
		WHEN 1 THEN 'Next Quarter'
		WHEN -4 THEN 'Same Quarter Previous Year'
		ELSE NULL
	END AS [Quarter Slice],

	CASE (DATEDIFF(WEEK, GETDATE(), full_date))
		WHEN -1 THEN 'Previous Week'
		WHEN 0 THEN 'Current Week'
		WHEN 1 THEN 'Next Week'
		ELSE NULL
	END AS [Week Slice],

	DATEDIFF(DAY, GETDATE(), full_date)		as [Relative Day Number],
	DATEDIFF(WEEK, GETDATE(), full_date)	as [Relative Week Number],
	DATEDIFF(MONTH, GETDATE(), full_date)	as [Relative Month Number],
	DATEDIFF(QUARTER, GETDATE(), full_date) as [Relative Quarter Number]

FROM 
	[psa].[Date]

WHERE
 (DATEDIFF(YEAR, GETDATE(), full_date) >= -1)
 and
 (DATEDIFF(DAY, GETDATE(), full_date) <= 366)


GO

CREATE VIEW [psa].[DefaultResourceCategoryView]
AS
SELECT       
	bookableresourcecategoryid				as [Resource Category Id],
	name									as [Resource Category Name],
	msdyn_targetutilization * 0.01			as [Resource Category Target Utilization],
	ent_state.Label							as [Resource Category State],
	statecode								as [Resource Category State Code],
	BillingType.Label						as [Resource Category Chargeability]
	 
FROM    dbo.bookableresourcecategory
	left outer join dbo.bookableresource_state	ent_state	on ent_state.Value		= statecode
	left outer join dbo.msdyn_billingtype_gos	BillingType on BillingType.Value	= msdyn_billingtype
WHERE  
not (((statecode != 0) and (DATEDIFF(YEAR, GETDATE(), ModifiedOn) < -1)))



GO

CREATE VIEW [psa].[MeasuresView]
AS
  SELECT TOP 0 1 AS MeasureValues

GO

CREATE VIEW [psa].[NamedResourceWorkCapacityView]
AS
SELECT 
	br.bookableresourceId as [Resource Id],
	dc.* 
FROM dbo.BookableResource br 
CROSS JOIN psa.DateCapacityView dc
WHERE
NOT (((br.statecode != 0) and (DATEDIFF(YEAR, GETDATE(), br.ModifiedOn) < -1)))

GO

CREATE VIEW [psa].[OpportunityView]
AS
SELECT        
	OpportunityId						as [Opportunity Id],
	Name								as [Opportunity Name],
	Description							as [Opportunity Description], 
	msdyn_OrderType						as [Opportunity Type Code], 
	OrderType.Label						as [Opportunity Type], 
	SalesStage							as [Sales Stage Code], 
	SalesStage.Label					as [Sales Stage], 
	CONVERT(date, ActualCloseDate)		as [Opportunity Actual Close Date], 
	ActualValue_Base					as [Opportunity Actual Revenue], 
	StepName							as [Step Name], 
	StatusCode							as [Opportunity Status Code], 
	ent_status.Label					as [Opportunity Status], 
	OpportunityRatingCode				as [Opportunity Rating Code], 
	OpportunityRating.Label				as [Opportunity Rating], 
	CloseProbability * 0.01				as [Opportunity Close Probability], 
	EstimatedValue_Base					as [Opportunity Estimated Revenue], 
	CONVERT(date, opportunity.CreatedOn)as [Opportunity Created On Date], 
	CONVERT(date, EstimatedCloseDate)	as [Opportunity Estimated Close Date], 
	CustomerId							as [Customer Id], 
	CustomerNeed						as [Customer Need], 
	CONVERT(date, FinalDecisionDate)	as [Opportunity Final Decision Date], 
	PurchaseTimeframe					as [Opportunity Purchase Time Frame Code], 
	PurchaseTimeframe.Label				as [Opportunity Purchase Time Frame], 
	TotalAmount_Base					as [Opportunity Total Amount], 
	StateCode							as [Opportunity State Code], 
	ent_state.Label						as [Opportunity State], 
	CustomerPainPoints					as [Customer Pain Points],
	msdyn_accountmanagerid				as [Opportunity Account Manager Id],
	SystemUser.fullname					as [Opportunity Account Manager],
	TimeLine							as [Opportunity Timeline Code],
	Timeline.Label						as [Opportunity Timeline]

FROM            dbo.opportunity	opportunity
	left outer join dbo.opportunity_status						ent_status			on ent_status.Value			= statuscode
	left outer join dbo.opportunity_state						ent_state			on ent_state.Value			= statecode
	left outer join dbo.timeline_os_opportunity					Timeline			on Timeline.Value			= timeline
	left outer join dbo.purchasetimeframe_gos					PurchaseTimeframe	on PurchaseTimeframe.Value	= purchasetimeframe
	left outer join dbo.opportunityratingcode_os_opportunity	OpportunityRating	on OpportunityRating.Value	= opportunityratingcode
	left outer join dbo.salesstage_gos							SalesStage			on SalesStage.Value			= salesstage
	left outer join dbo.msdyn_ordertype_os_opportunity			OrderType			on OrderType.Value			= msdyn_ordertype
	left outer join dbo.systemuser								SystemUser			on msdyn_accountmanagerid	= systemuserid
WHERE       
(ActualCloseDate IS NULL OR DATEDIFF(YEAR, GETDATE(), ActualCloseDate) >= -1)
 


GO

CREATE VIEW [psa].[OrganizationalUnitView]
AS
SELECT   
	msdyn_organizationalunitid			as [Organizational Unit Id],
	msdyn_name							as [Organizational Unit Name],
	msdyn_description					as [Organizational Unit Description],
	StateCode.Label						as [Organizational Unit State],
	statecode							as [Organizational Unit State Code]

FROM    dbo.msdyn_organizationalunit
	left outer join msdyn_organizationalunit_state StateCode on StateCode.Value = statecode
WHERE
NOT (((statecode != 0) and (DATEDIFF(YEAR, GETDATE(), ModifiedOn) < -1)))



GO

CREATE VIEW [psa].[ProjectContractView]
AS
SELECT
	cv.[Contract Id], 
	msdyn_project as [Project Id] 

FROM 
	psa.ContractView cv join
	dbo.SalesOrderDetail od on od.salesorderid = cv.[Contract Id]

WHERE msdyn_project is not null

GROUP BY 
	cv.[Contract Id], 
	msdyn_project

GO

CREATE VIEW [psa].[ProjectView]
AS
SELECT        
	msdyn_projectid							as [Project Id], 
	msdyn_customer							as [Project Customer Id], 
	msdyn_subject							as [Project Name], 
	msdyn_description						as [Project Description], 
	msdyn_projectmanager					as [Project Manager User Id],
	SystemUser.fullname						as [Project Manager Name],
	CONVERT(date, msdyn_actualstart)		as [Project Actual Start], 
	CONVERT(date, msdyn_actualend)			as [Project Actual End], 
	CONVERT(date, msdyn_scheduledstart)		as [Project Scheduled Start], 
	CONVERT(date, msdyn_scheduledend)		as [Project Scheduled End], 
	CostPerformance.Label					as [Project Cost Performance],
	msdyn_costperformence					as [Project Cost Performance Code],
	SchedulePerformance.Label				as [Project Schedule Performance],
	msdyn_scheduleperformance				as [Project Schedule Performance Code],
	msdyn_StageName							as [Project Stage Name],
	msdyn_contractorganizationalunitid		as [Project Contracting Unit Id]

FROM    dbo.msdyn_project
	left outer join msdyn_costperformence_os_msdyn_project		CostPerformance		on CostPerformance.Value		= msdyn_costperformence
	left outer join msdyn_scheduleperformance_os_msdyn_project	SchedulePerformance	on SchedulePerformance.Value	= msdyn_scheduleperformance
	left outer join dbo.systemuser								SystemUser			on msdyn_projectmanager			= systemuserid
WHERE   (msdyn_istemplate = 0)
AND (msdyn_actualend IS NULL OR DATEDIFF(YEAR, GETDATE(), msdyn_actualend) >= -1)

GO

CREATE VIEW [psa].[QuoteLineView]
AS
SELECT
	quoteId							as [Quote Id],
	producttypecode					as [Quote Product Type Code],
	ProductTypeCode.Label			as [Quote Product Type],
	extendedamount_base				as [Quote Line Extended Amount],
	baseamount_base					as [Quote Line Base Amount],
	manualdiscountamount_base		as [Quote Line Manual Discount Amount],
	volumediscountamount_base		as [Quote Line Volume Discount Amount]

FROM dbo.QuoteDetail
	left outer join producttypecode_gos ProductTypeCode on ProductTypeCode.Value = producttypecode
WHERE
not (((quotestatecode != 0) and (DATEDIFF(YEAR, GETDATE(), ModifiedOn) < -1)))

GO

CREATE VIEW [psa].[QuoteView]
AS
SELECT
	quoteid											as [Quote Id],
	Description										as [Quote Description],
	QuoteNumber										as [Quote Number], 	 
	Name											as [Quote Name],
	msdyn_ordertype									as [Quote Type Code],
	OrderType.Label									as [Quote Type],
	CustomerId										as [Customer Id],
	EstimatedBudget.Label							as [Quote Budget Estimation],
	msdyn_estimatedbudget							as [Quote Budget Estimation Code],
	EstimatedSchedule.Label							as [Quote Schedule Estimation],
	msdyn_estimatedschedule							as [Quote Schedule Estimation Code],
	Feasible.Label									as [Quote Feasibility],
	msdyn_feasible									as [Quote Feasibility Code],
	Profitability.Label								as [Quote Profitability],
	msdyn_profitability								as [Quote Profitability Code],
	Competitive.Label								as [Quote Competitivness], 
	msdyn_competitive								as [Quote Competitivness Code], 
	msdyn_GrossMargin * 0.01						as [Quote Gross Margin (%)], 
	msdyn_adjustedgrossmargin * 0.01				as [Quote Adjusted Gross Margin (%)], 
    msdyn_customerbudgetrollup_base					as [Quote Customer Budget], 
	TotalAmount_Base								as [Quote Total Amount],
	msdyn_totalchargeablecostrollup_Base			as [Quote Total Chargeable Cost],
	msdyn_totalnonchargeablecostrollup_Base			as [Quote Total Non-Chargeable Cost],
	msdyn_accountmanagerid							as [Quote Account Manager User Id], 
	SystemUser.fullname								as [Quote Account Manager], 
	CONVERT(date, quote.CreatedOn)					as [Quote Created On Date], 
	CONVERT(date, EffectiveTo)						as [Quote Effective To Date],
	CONVERT(date, msdyn_estimatedcompletionrollup)	as [Quote Estimated Completion Date], 
	CONVERT(date, EffectiveFrom)					as [Quote Effective From Date],
	CONVERT(date, 
				case 
					when ClosedOn is null then /*if the user didn't enter quote close date then we assume it is the date when quote state was changed to Won or Closed*/
						case  
							when statecode in (2,3) then quote.ModifiedOn
							else null
						end
					else ClosedOn
				end
		)											as [Quote Closed On Date], 
	CONVERT(date, RequestDeliveryBy)				as [Quote Requested Delivery Date],
	OpportunityId									as [Opportunity Id],
	statecode										as [Quote State Code],
	StateCode.Label									as [Quote State],
	discountamount_base								as [Quote Discount Amount],
	discountpercentage * 0.01						as [Quote Discount (%)],
	totaldiscountamount_base						as [Quote Total Discount Amount],
	totallineitemdiscountamount_base				as [Quote Total Line Item Discount Amount],
	totallineitemamount_base						as [Quote Total Line Item Amount]	
			
FROM    dbo.quote	quote
	left outer join dbo.quote_state					StateCode				on StateCode.Value			= statecode
	left outer join dbo.msdyn_competitive_gos		Competitive				on Competitive.Value		= msdyn_competitive
	left outer join dbo.msdyn_profitability_gos		Profitability			on Profitability.Value		= msdyn_profitability
	left outer join dbo.msdyn_feasible_gos			Feasible				on Feasible.Value			= msdyn_feasible
	left outer join dbo.msdyn_estimatedschedule_gos EstimatedSchedule		on EstimatedSchedule.Value	= msdyn_estimatedschedule
	left outer join dbo.msdyn_estimatedbudget_gos	EstimatedBudget			on EstimatedBudget.Value	= msdyn_estimatedbudget
	left outer join dbo.msdyn_ordertype_os_quote	OrderType				on OrderType.Value			= msdyn_ordertype
	left outer join dbo.systemuser					SystemUser				on msdyn_accountmanagerid	= systemuserid
WHERE
 not (((statecode != 0 or statecode != 1) and (DATEDIFF(YEAR, GETDATE(), quote.ModifiedOn) < -1)))

GO

CREATE VIEW [psa].[ResourceBookingView]
AS
SELECT
	bk.bookingstatus					as [Booking Status Id],
	bk.bookingtype						as [Booking Type Code],
	BookingType.Label					as [Booking Type],
	bk.duration							as [Booking Duration Minutes],
	bk.duration/60.0					as [Booking Duration Hours],
	CONVERT(date, bk.starttime)			as [Booking Date],       
	bk.msdyn_projectid					as [Booked Project Id],
	bk.msdyn_resourcecategoryid			as [Booked Resource Category Id],
	bk.resource							as [Booked Resource Id],
	rcs.msdyn_billingtype				as [Booking Billing Type Code],
	BillingType.Label					as [Booking Billing Type]
FROM	dbo.bookableresourcebooking bk
LEFT OUTER JOIN dbo.salesorderdetail cl ON 
	cl.msdyn_project = bk.msdyn_projectid
	and (cl.msdyn_includetime = 1)						/*Have to filter by lines that include Time transactions, as only 1 Contract Line for Time transactions is allowed per Project*/
	and (cl.msdyn_project IS NOT NULL)
LEFT OUTER JOIN dbo.msdyn_orderlineresourcecategory rcs ON 
	cl.salesorderdetailid = rcs.msdyn_contractline 
	and bk.msdyn_resourcecategoryid = rcs.msdyn_resourcecategory
	and rcs.msdyn_transactionclassification = 192350000 /*Time*/
	and rcs.statecode = 0 /*Active*/
	and (rcs.msdyn_contractline IS NOT NULL)
LEFT OUTER JOIN dbo.bookingtype_os_bookableresourcebooking	BookingType on BookingType.Value = bk.bookingtype
LEFT OUTER JOIN dbo.msdyn_billingtype_gos					BillingType on BillingType.Value = rcs.msdyn_billingtype
WHERE	
 (DATEDIFF(YEAR, GETDATE(), bk.endtime) >= -1)	
AND (DATEDIFF(DAY, GETDATE(), bk.starttime) <= 366)



GO

CREATE VIEW [psa].[ResourceRequestView]
AS
SELECT
	msdyn_name						as [Request Name],
	msdyn_resourcerequirementid		as [Resource Requirement Id],
	msdyn_requestedby				as [Requested By User Id],
	requestusr.fullname				as [Requested By Name],
	msdyn_claimedby					as [Request Claimed By User Id],
	claimusr.fullname				as [Request Claimed By Name],
	CONVERT(date, request.CreatedOn)as [Request Created On Date],
	statecode						as [Request State Code],
	StateCode.Label					as [Request State],
	statuscode						as [Request Status Code],
	StatusCode.Label				as [Request Status]

FROM dbo.msdyn_resourcerequest request
	left outer join dbo.msdyn_resourcerequest_state		StateCode	on StateCode.Value		= statecode
	left outer join dbo.msdyn_resourcerequest_status	StatusCode	on StatusCode.Value		= statuscode
	left outer join dbo.systemuser						requestusr	on msdyn_requestedby	= requestusr.systemuserid
	left outer join dbo.systemuser						claimusr	on msdyn_claimedby		= claimusr.systemuserid
WHERE
 (DATEDIFF(YEAR, GETDATE(), request.CreatedOn) >= -1)
AND (DATEDIFF(DAY, GETDATE(), request.CreatedOn) <= 366)

GO

CREATE VIEW [psa].[ResourceRequirementDetailView]
AS
SELECT
	msdyn_resourcerequirementid	as [Resource Requirement Id],
	CONVERT(date, msdyn_from)	as [Required Date],
	msdyn_hours					as [Required Hours]

FROM dbo.msdyn_resourcerequirementdetail
WHERE 
 (DATEDIFF(YEAR, GETDATE(), msdyn_from) >= -1)
AND (DATEDIFF(DAY, GETDATE(), msdyn_from) <= 366)

GO

CREATE VIEW [psa].[ResourceRequirementView]
AS
SELECT
	msdyn_resourcerequirementId		as [Resource Requirement Id],
	msdyn_projectid					as [Required Project Id],  
	msdyn_quantity					as [Required Resource Count], 
	msdyn_roleid					as [Required Resource Category Id], 
	msdyn_hours						as [Required Hours (Total)], 
	CONVERT(date, msdyn_fromdate)	as [Required Start Date], 
	CONVERT(date, msdyn_todate)		as [Required End Date], 
	msdyn_costprice_Base			as [Required Cost Price],	
	msdyn_country					as [Required Country], 
	msdyn_stateorprovince			as [Required State/Province],
	msdyn_city						as [Required City], 
	msdyn_requeststatus				as [Requirement Request Status], 
	msdyn_type						as [Requirement Type Code], 
	ReqType.Label					as [Requirement Type],
	statecode						as [Requirement State Code],
	StateCode.Label					as [Requirement State] 	 

FROM dbo.msdyn_resourcerequirement
	left outer join dbo.msdyn_type_os_msdyn_resourcerequirement	ReqType		on ReqType.Value	= msdyn_type
	left outer join dbo.msdyn_resourcerequirement_state			StateCode	on StateCode.Value	= statecode
WHERE
 (DATEDIFF(YEAR, GETDATE(), msdyn_todate) >= -1)
AND (DATEDIFF(DAY, GETDATE(), msdyn_fromdate) <= 366)

GO

CREATE VIEW [psa].[ResourceView]
AS
SELECT       
	br.bookableresourceid						as [Resource Id], 
	CASE 
	   WHEN br.msdyn_TargetUtilization IS NULL THEN rc.[Resource Category Target Utilization]  
	   ELSE br.msdyn_TargetUtilization * 0.01
	END											as [Resource Target Utilization], 
	br.name										as [Resource Name],
	ResourceType.Label							as [Resource Type],
	br.resourcetype								as [Resource Type Code],
	br.msdyn_organizationalunit					as [Resource Organizational Unit Id],
	StateCode.Label								as [Resource State],
	br.statecode								as [Resource State Code],
	rc.[Resource Category Id]					as [Default ResourceCategory Id],
	rc.[Resource Category Name]					as [Default Resource Category Name]

FROM            dbo.bookableresource br
	LEFT OUTER JOIN dbo.bookableresourcecategoryassn brca ON br.bookableresourceid = brca.resource
	LEFT OUTER JOIN [psa].[DefaultResourceCategoryView] rc on rc.[Resource Category Id] = brca.resourcecategory

	left outer join dbo.resourcetype_os_bookableresource	ResourceType	on ResourceType.Value	= br.resourcetype
	left outer join dbo.bookableresource_state				StateCode		on StateCode.Value		= br.statecode
WHERE 
  (brca.statecode = 0)
  AND (brca.msdyn_isdefault = 1)
  and not (((br.statecode != 0) and (DATEDIFF(YEAR, GETDATE(), br.ModifiedOn) < -1)))



GO

CREATE VIEW [psa].[TimeEntryView]
AS
SELECT
	msdyn_timeentryid					as [TimeEntry Id],
	CONVERT(date, msdyn_date)			as [Time Entry Date],
	msdyn_bookableresource				as [Resource Id],
	msdyn_description					as [Time Entry Description],
	msdyn_duration						as [Time Entry Minutes],
	msdyn_duration /60.0				as [Time Entry Hours],
	msdyn_entrystatus					as [Time Entry Status Code],
	EntryStatus.Label					as [Time Entry Status],
	msdyn_manager						as [Time Entry Approver User Id],
	SystemUser.fullname					as [Time Entry Approver],
	msdyn_project						as [Project Id],
	msdyn_resourcecategory				as [Time Entry Resource Category Id],
	EntryType.Label						as [Time Entry Type],
	msdyn_type							as [Time Entry Type Code]

FROM    dbo.msdyn_timeentry
	left outer join dbo.msdyn_type_gos			EntryType	on EntryType.Value		= msdyn_type
	left outer join dbo.msdyn_entrystatus_gos	EntryStatus on EntryStatus.Value	= msdyn_entrystatus
	left outer join dbo.systemuser				SystemUser  on msdyn_manager		= systemuserid
WHERE
(DATEDIFF(YEAR, GETDATE(), msdyn_date) >= -1)		
and (DATEDIFF(DAY, GETDATE(), msdyn_date) <= 366)



GO

CREATE VIEW [psa].[TransactionCategoryView]
AS
SELECT       
	msdyn_transactioncategoryId			as [TransactionCategory Id],
	msdyn_name							as [Transaction Category Name] 

FROM         dbo.msdyn_transactioncategory
WHERE        
not (((statecode != 0) and (DATEDIFF(YEAR, GETDATE(), ModifiedOn) < -1)))


GO

/*
	This view provides estimated maximum possible free capacity per resource per day
	according to weekday capacity setup and resource's approved absence.
*/
CREATE VIEW [psa].[ZResourceCapacityView]
AS
SELECT 
	[Resource Id],
	[Time Entry Date]		as [Resource Capacity Date],
	-[Time Entry Minutes]	as [Resource Capacity Minutes],
	-[TIme Entry Hours]		as [Resource Capacity Hours]

FROM psa.TimeEntryView
WHERE [Time Entry Type Code] <> 192350000 /*Work*/
AND [Time Entry Status Code] = 192350002  /*Approved*/

UNION ALL

SELECT 
	[Resource Id],
	[Capacity Date]			as [Resource Capacity Date],
	[Capacity Minutes]		as [Resource Capacity Minutes],
	[Capacity Hours]		as [Resource Capacity Hours]

FROM psa.NamedResourceWorkCapacityView 

GO


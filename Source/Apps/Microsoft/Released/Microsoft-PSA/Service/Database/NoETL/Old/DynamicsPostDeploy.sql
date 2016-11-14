/* POPULATE DATE TABLE*/
BEGIN TRANSACTION

DECLARE @startyear INT = DATEPART(year, GETDATE()) - 1
DECLARE @endyear INT = DATEPART(year, GETDATE()) + 10
DECLARE @date DATE = DATEFROMPARTS(@startyear, 1, 1)

DECLARE @endDate DATE = DATEFROMPARTS(@endyear, 1, 1) 
DECLARE @week_start_date DATE  
DECLARE @week_end_date DATE 
DECLARE @month_start_date DATE  
DECLARE @month_end_date DATE  
DECLARE @quarter_start_date DATE  
DECLARE @quarter_end_date DATE  

DECLARE @year INT
DECLARE @quarter INT
DECLARE @month INT
DECLARE @week INT

WHILE @date < @endDate
BEGIN
	SET @year = DATEPART(year, @date)  	 
	SET @quarter = DATEPART(quarter, @date)  	
	SET @month = DATEPART(month, @date)
	SET @week = DATEPART(week, @date)  	

	SET @week_start_date = DATEADD(DAY, 1 - DATEPART(weekday, @date) ,@date)
	SET @week_end_date = DATEADD(DAY, 6, @week_start_date)
	SET @month_start_date = DATEFROMPARTS(@year, @month, 1) 
	SET @month_end_date = DATEADD(day, -1, DATEADD(month, 1, @month_start_date)) 
	SET @quarter_start_date = DATEFROMPARTS(@year, (@quarter-1)*3 + 1, 1) 
	SET @quarter_end_date = DATEADD(day, -1, DATEADD(month, 3, @quarter_start_date))

   INSERT psa.Date( 
		[full_date],            
		[year],	                  
		[quarter],[quarter_start_date],[quarter_end_date],[quarter_name],[quarter_abbrevYear],		
		[month],[month_start_date],[month_end_date],[month_name],[month_abbrev],[month_abbrevYear],				    
		[day_of_year],[day_of_month],[day_of_week],[day_name],[day_abbrev],
		[weeek_of_year],[week_start_date],[week_end_date],[week_time_frame]
	)VALUES(
		@date, 
		@year, 
		@quarter, @quarter_start_date, @quarter_end_date, CONCAT('Q', @quarter), CONCAT('Q', @quarter, ' ', @year), 
		@month, @month_start_date, @month_end_date, DATENAME(Month, @date), SUBSTRING(DATENAME(Month, @date), 0, 4), CONCAT(SUBSTRING(DATENAME(Month, @date), 0, 4), ' ', @year),
		DATEPART(dayofyear, @date), DATEPART(day, @date), DATEPART(weekday, @date), DATENAME(weekday, @date), SUBSTRING(DATENAME(weekday, @date), 0 ,4),
		@week, @week_start_date, @week_end_date, CONCAT(CONCAT(@week_start_date, ' - '), @week_end_date)
	)

    SET @date = DateAdd(Day, 1, @date);
END;

COMMIT TRANSACTION

GO;

/*POPULATE CAPACITY TABLE

 Assumes start of the week is Sunday:
	SET DATEFIRST 7
*/
BEGIN TRANSACTION

INSERT INTO psa.WeekDayCapacity(day_of_week, capacityMinutes) VALUES (1,   0)  -- SUNDAY
INSERT INTO psa.WeekDayCapacity(day_of_week, capacityMinutes) VALUES (2, 480)  -- MONDAY
INSERT INTO psa.WeekDayCapacity(day_of_week, capacityMinutes) VALUES (3, 480)  -- TUESDAY
INSERT INTO psa.WeekDayCapacity(day_of_week, capacityMinutes) VALUES (4, 480)  -- WEDNESDAY
INSERT INTO psa.WeekDayCapacity(day_of_week, capacityMinutes) VALUES (5, 480)  -- THURSDAY
INSERT INTO psa.WeekDayCapacity(day_of_week, capacityMinutes) VALUES (6, 480)  -- FRIDAY
INSERT INTO psa.WeekDayCapacity(day_of_week, capacityMinutes) VALUES (7,   0)  -- SATURDAY

COMMIT TRANSACTION

GO

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


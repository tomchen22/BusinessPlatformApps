CREATE SCHEMA psa AUTHORIZATION dbo;

GO

CREATE TABLE [psa].[Date]
(
	[full_date]             DATE NOT NULL,
	[year]                  SMALLINT NOT NULL, 

	[quarter]               TINYINT NOT NULL, 
	[quarter_start_date]    DATE NOT NULL,
	[quarter_end_date]		DATE NOT NULL,	
	[quarter_name]			CHAR(2) NOT NULL, 
	[quarter_abbrevYear]	CHAR(7) NOT NULL,
	
	[month]					TINYINT NOT NULL,
	[month_start_date]		DATE NOT NULL,
	[month_end_date]		DATE NOT NULL,
	[month_name]			VARCHAR(9) NOT NULL,
	[month_abbrev]			CHAR(3) NOT NULL,
	[month_abbrevYear]		CHAR(8) NOT NULL,
	    
	[day_of_year]		    SMALLINT NOT NULL, 
	[day_of_month]          TINYINT NOT NULL, 
	[day_of_week]           TINYINT NOT NULL, 

	[day_name]              VARCHAR(9) NOT NULL, 
	[day_abbrev]            CHAR(3) NOT NULL, 

    [weeek_of_year]		    SMALLINT NOT NULL,
	[week_start_date]	    DATE NOT NULL,	
	[week_end_date]		    DATE NOT NULL,
	[week_time_frame]       VARCHAR(23),

	CONSTRAINT PK_Dim_Date PRIMARY KEY CLUSTERED (full_date) 
)

GO

/*
	At the moment there is no way to extract resource capacity from CRM, so we have to do some approximation.
	This table defines the expected maximum schedulable capacity of a resource per week day.
*/
CREATE TABLE [psa].[WeekDayCapacity]
(
	[day_of_week]           TINYINT NOT NULL, 
	[capacityMinutes]       int NOT NULL , 

	CONSTRAINT PK_Dim_DayOfWeek PRIMARY KEY CLUSTERED (day_of_week) 
)

GO


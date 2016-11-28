IF object_id(N'Documents', 'U') IS NOT NULL
	DROP TABLE Documents
IF object_id(N'DocumentPublishedTimes', 'U') IS NOT NULL
	DROP TABLE DocumentPublishedTimes
IF object_id(N'DocumentIngestedTimes', 'U') IS NOT NULL
	DROP TABLE DocumentIngestedTimes
IF object_id(N'DocumentKeyPhrases', 'U') IS NOT NULL
	DROP TABLE DocumentKeyPhrases
IF object_id(N'DocumentSentimentScores', 'U') IS NOT NULL
	DROP TABLE DocumentSentimentScores
IF object_id(N'DocumentTopics', 'U') IS NOT NULL
	DROP TABLE DocumentTopics
IF object_id(N'DocumentTopicImages', 'U') IS NOT NULL
	DROP TABLE DocumentTopicImages
IF object_id(N'Entities', 'U') IS NOT NULL
	DROP TABLE Entities
IF object_id(N'DocumentCompressedEntities', 'U') IS NOT NULL
	DROP TABLE DocumentCompressedEntities
GO

CREATE TABLE dbo.Documents
	(
	id char(64) NOT NULL,
	text text NULL,
	textLength int NULL,
	cleanedText text NULL,
	cleanedTextLength int NULL,
	title text NULL,
	sourceUrl VARCHAR(2000) NULL,
	sourceDomain VARCHAR(1000) NULL,
	category text NULL,
	imageUrl text NULL,
	imageWidth int NULL,
	imageHeight int NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Documents ADD CONSTRAINT
	PK_Documents PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

CREATE TABLE dbo.DocumentPublishedTimes
	(
	id char(64) NOT NULL,
	"timestamp" datetime NOT NULL,
	monthPrecision datetime NOT NULL,
	weekPrecision datetime NOT NULL,
	dayPrecision datetime NOT NULL,
	hourPrecision datetime NOT NULL,
	minutePrecision datetime NOT NULL
	) 
GO
ALTER TABLE dbo.DocumentPublishedTimes ADD CONSTRAINT
	PK_DocumentPublishedTimes PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE TABLE dbo.DocumentIngestedTimes
	(
	id char(64) NOT NULL,
	"timestamp" datetime NOT NULL,
	monthPrecision datetime NOT NULL,
	weekPrecision datetime NOT NULL,
	dayPrecision datetime NOT NULL,
	hourPrecision datetime NOT NULL,
	minutePrecision datetime NOT NULL
	)
GO
ALTER TABLE dbo.DocumentIngestedTimes ADD CONSTRAINT
	PK_DocumentIngestedTimes PRIMARY KEY CLUSTERED
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE TABLE dbo.DocumentSentimentScores
	(
	id char(64) NOT NULL,
	score float NOT NULL
	) 
GO
ALTER TABLE dbo.DocumentSentimentScores ADD CONSTRAINT
	PK_DocumentSentimentScores PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE TABLE dbo.DocumentKeyPhrases
	(
	documentId char(64) NOT NULL,
	phrase varchar(2000) NOT NULL
	) 
GO
--ALTER TABLE dbo.DocumentKeyPhrases ADD CONSTRAINT
--	PK_DocumentKeyPhrases PRIMARY KEY CLUSTERED 
--	(
--	documentId, phrase
--	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--GO

CREATE TABLE dbo.DocumentTopics
	(
	documentId char(64) NOT NULL,
	topicId char(36) NOT NULL,
	batchId varchar(40) NULL,
	documentDistance float NOT NULL,
	topicScore int NOT NULL,
	topicKeyPhrase varchar(2000) NOT NULL
	) 
GO
ALTER TABLE dbo.DocumentTopics ADD CONSTRAINT
	PK_DocumentTopics PRIMARY KEY CLUSTERED 
	(
	documentId, topicId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE TABLE dbo.DocumentTopicImages
	(
	topicId char(36) NOT NULL,
	imageUrl1 text null,
	imageUrl2 text null,
	imageUrl3 text null,
	imageUrl4 text null
	) 
GO
ALTER TABLE dbo.DocumentTopicImages ADD CONSTRAINT
	PK_DocumentTopicImages PRIMARY KEY CLUSTERED 
	(
	topicId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE TABLE dbo.Entities
	(
	id bigint NOT NULL IDENTITY (1, 1),
	documentId char(64) NOT NULL,
	entityType varchar(30) NOT NULL,
	entityValue varchar(5000) NULL,
	offset int NOT NULL,
	offsetDocumentPercentage float NOT NULL,
	length int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Entities ADD CONSTRAINT
	PK_Entities PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

CREATE TABLE dbo.DocumentCompressedEntities
	(
	documentId char(64) NOT NULL,
	compressedEntitiesJson text NULL
	)
GO
ALTER TABLE dbo.DocumentCompressedEntities ADD CONSTRAINT
	PK_DocumentCompressedEntities PRIMARY KEY CLUSTERED
	(
	documentId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX documentIdIndex ON dbo.Entities
	(
	documentId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF object_id(N'FullDocument', 'V') IS NOT NULL
	DROP VIEW FullDocument
GO

CREATE VIEW FullDocument AS
SELECT Documents.*, DocumentSentimentScores.score
	, DocumentPublishedTimes.timestamp PublishedTimestamp, DocumentPublishedTimes.monthPrecision PublishedMonthPrecision, DocumentPublishedTimes.weekPrecision PublishedWeekPrecision, DocumentPublishedTimes.dayPrecision PublishedDayPrecision, DocumentPublishedTimes.hourPrecision PublishedHourPrecision, DocumentPublishedTimes.minutePrecision PublishedMinutePrecision
	, DocumentIngestedTimes.timestamp IngestedTimestamp, DocumentIngestedTimes.monthPrecision IngestedMonthPrecision, DocumentIngestedTimes.weekPrecision IngestedWeekPrecision, DocumentIngestedTimes.dayPrecision IngestedDayPrecision, DocumentIngestedTimes.hourPrecision IngestedHourPrecision, DocumentIngestedTimes.minutePrecision IngestedMinutePrecision
FROM Documents
LEFT JOIN DocumentPublishedTimes ON Documents.id = DocumentPublishedTimes.id
LEFT JOIN DocumentIngestedTimes ON Documents.id = DocumentIngestedTimes.id
LEFT JOIN DocumentSentimentScores ON Documents.id=DocumentSentimentScores.id

GO

IF object_id(N'FullDocumentTopics', 'V') IS NOT NULL
	DROP VIEW FullDocumentTopics
GO

CREATE VIEW FullDocumentTopics AS
SELECT DocumentTopics.*, DocumentTopicImages.imageUrl1, DocumentTopicImages.imageUrl2, DocumentTopicImages.imageUrl3, DocumentTopicImages.imageUrl4, 
((1-DocumentTopics.documentDistance)*100) AS Weight
FROM DocumentTopics
LEFT JOIN DocumentTopicImages ON DocumentTopics.topicId = DocumentTopicImages.topicId
GO

IF object_id(N'FullEntities', 'V') IS NOT NULL
	DROP VIEW FullEntities
GO
CREATE VIEW FullEntities AS
SELECT *, entityType + entityValue entityID, 
	CASE
		WHEN entityType = 'TIL' THEN 'fa fa-certificate'
		WHEN entityType = 'PER' THEN 'fa fa-male'
		WHEN entityType = 'ORG' THEN 'fa fa-sitemap'
		WHEN entityType = 'LOC' THEN 'fa fa-globe'
		ELSE null
		END entityClass, 
	CASE
		WHEN entityType = 'TIL' THEN '#FFFFFF'
		WHEN entityType = 'PER' THEN '#1BBB6A'
		WHEN entityType = 'ORG' THEN '#FF001F'
		WHEN entityType = 'LOC' THEN '#FF8000'
		ELSE null
	END entityColor
 from Entities
GO

-- Rank entities by distinct document count and entity type
IF object_id(N'EntityRankings', 'V') IS NOT NULL
	DROP VIEW EntityRankings
GO
CREATE VIEW EntityRankings AS
WITH DocCounts AS 
(
	SELECT count(distinct documentId) documentCount, entityType, entityValue
	FROM Entities
	GROUP BY entityType, entityValue
)
SELECT ROW_NUMBER() OVER (PARTITION BY entityType ORDER BY documentCount DESC) entityValueRank,  entityType + entityValue entityID, entityType, entityValue, documentCount 
FROM DocCounts

GO

IF OBJECT_ID(N'dbo.WriteKeyPhrases',N'P') IS NULL -- Doesn’t exist
    EXEC('CREATE PROC dbo.WriteKeyPhrases AS SET NOCOUNT ON;') -- Create empty stub.
GO
-- =============================================
-- Author:		Microsoft
-- Description:	Takes a JSON array of key phrases and writes them to the DocumentKeyPhrases table
-- =============================================
ALTER PROCEDURE WriteKeyPhrases 
	-- Add the parameters for the stored procedure here
	@docid VARCHAR(64), 
	@keyPhraseJson VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO DocumenTKeyPhrases (documentId, phrase)
	SELECT @docid AS documentId, value AS phrase
	FROM OPENJSON(@keyPhraseJson)
END
GO

IF OBJECT_ID(N'dbo.CleanBatchTables',N'P') IS NULL -- Doesn’t exist
    EXEC('CREATE PROC dbo.CleanBatchTables AS SET NOCOUNT ON;') -- Create empty stub.
GO
-- =============================================
-- Author:		Microsoft
-- Description:	Truncates all batch process tables so batch processes can be run
-- =============================================
ALTER PROCEDURE CleanBatchTables 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- These tables are populated by AzureML batch processes.  
	truncate table Entities;
	truncate table DocumentCompressedEntities;
	truncate table DocumentTopics;
	truncate table DocumentTopicImages;
END;
GO
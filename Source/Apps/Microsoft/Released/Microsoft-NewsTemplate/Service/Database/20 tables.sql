SET ANSI_NULLS              ON;
SET ANSI_PADDING            ON;
SET ANSI_WARNINGS           ON;
SET ANSI_NULL_DFLT_ON       ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET QUOTED_IDENTIFIER       ON;
go


CREATE TABLE bpst_news.[configuration]
(
  id                     INT IDENTITY(1, 1) NOT NULL,
  configuration_group    VARCHAR(150) NOT NULL,
  configuration_subgroup VARCHAR(150) NOT NULL,
  name                   VARCHAR(150) NOT NULL,
  [value]                VARCHAR(max) NULL,
  visible                BIT NOT NULL DEFAULT 0
);


CREATE TABLE bpst_news.documents
(
    id				  NCHAR(64) NOT NULL,
    [text]			  VARCHAR(max),
    textLength        INT,
    cleanedText       VARCHAR(max),
    cleanedTextLength INT,
    title			  VARCHAR(2000),
	sourceUrl		  VARCHAR(2000),
	sourceDomain	  VARCHAR(1000),
	category		  VARCHAR(150),
	imageUrl		  text,
	imageWidth		  INT,
	imageHeight		  INT
)	
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

ALTER TABLE bpst_news.documents ADD CONSTRAINT pk_documents PRIMARY KEY CLUSTERED (id) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

CREATE TABLE bpst_news.documentpublishedtimes
(
	id				CHAR(64) NOT NULL,
	[timestamp]		DATETIME NOT NULL,
	monthPrecision  DATETIME NOT NULL,
	weekPrecision	DATETIME NOT NULL,
	dayPrecision	DATETIME NOT NULL,
	hourPrecision	DATETIME NOT NULL,
	minutePrecision DATETIME NOT NULL
	);

ALTER TABLE bpst_news.documentpublishedtimes ADD CONSTRAINT pk_documentpublishedtimes PRIMARY KEY CLUSTERED (id) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];


CREATE TABLE bpst_news.documentingestedtimes
(
	id				CHAR(64) NOT NULL,
	[timestamp]		DATETIME NOT NULL,
	monthPrecision  DATETIME NOT NULL,
	weekPrecision	DATETIME NOT NULL,
	dayPrecision	DATETIME NOT NULL,
	hourPrecision	DATETIME NOT NULL,
	minutePrecision DATETIME NOT NULL
);
ALTER TABLE bpst_news.documentingestedtimes ADD CONSTRAINT pk_documentingestedtimes PRIMARY KEY CLUSTERED (id) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

CREATE TABLE bpst_news.documentsentimentscores
	(
	id				CHAR(64) NOT NULL,
	score			FLOAT NOT NULL
	);

ALTER TABLE bpst_news.documentsentimentscores ADD CONSTRAINT pk_documentsentimentscores PRIMARY KEY CLUSTERED (id) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];


CREATE TABLE bpst_news.documentkeyphrases
(
	documentid	CHAR(64) NOT NULL,
	phrase		VARCHAR(2000) NOT NULL
);


CREATE TABLE bpst_news.documenttopics
(
	documentId		 CHAR(64) NOT NULL,
	topicId			 CHAR(36) NOT NULL,
	batchId			 VARCHAR(40) NULL,
	documentDistance FLOAT NOT NULL,
	topicScore		 INT NOT NULL,
	topicKeyPhrase   VARCHAR(2000) NOT NULL
);

ALTER TABLE bpst_news.documenttopics ADD CONSTRAINT pk_documenttopics PRIMARY KEY CLUSTERED (documentId, topicId) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

CREATE TABLE bpst_news.documenttopicimages
(
	topicId		CHAR(36) NOT NULL,
	imageUrl1	VARCHAR(2000),
	imageUrl2	VARCHAR(2000),
	imageUrl3	VARCHAR(2000),
	imageUrl4	VARCHAR(2000)
);

ALTER TABLE bpst_news.documenttopicimages ADD CONSTRAINT pk_documenttopicimages PRIMARY KEY CLUSTERED (topicId) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

CREATE TABLE bpst_news.entities
	(
	id							BIGINT NOT NULL IDENTITY (1, 1),
	documentId					CHAR(64) NOT NULL,
	entityType					VARCHAR(30) NOT NULL,
	entityValue					VARCHAR(5000) NULL,
	offset						INT NOT NULL,
	offsetDocumentPercentage	FLOAT NOT NULL,
	length						INT NOT NULL
	) ON [PRIMARY]

ALTER TABLE bpst_news.entities ADD CONSTRAINT pk_entities PRIMARY KEY CLUSTERED (id) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

CREATE TABLE bpst_news.documentcompressedentities
	(
	documentId				CHAR(64) NOT NULL,
	compressedEntitiesJson	VARCHAR(max)
	);

ALTER TABLE bpst_news.documentcompressedentities ADD CONSTRAINT pk_documentcompressedentities PRIMARY KEY CLUSTERED (documentId) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

CREATE NONCLUSTERED INDEX documentIdIndex ON bpst_news.entities (documentId) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

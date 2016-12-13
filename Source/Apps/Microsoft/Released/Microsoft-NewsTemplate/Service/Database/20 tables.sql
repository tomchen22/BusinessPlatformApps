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
  configuration_group    NVARCHAR(150) NOT NULL,
  configuration_subgroup NVARCHAR(150) NOT NULL,
  name                   NVARCHAR(150) NOT NULL,
  [value]                NVARCHAR(max) NULL,
  visible                BIT NOT NULL DEFAULT 0
);


CREATE TABLE bpst_news.documents
(
    id				  NCHAR(64) NOT NULL,
    [text]			  NVARCHAR(max),
    textLength        INT,
    cleanedText       NVARCHAR(max),
    cleanedTextLength INT,
    title			  NVARCHAR(2000),
    sourceUrl		  NVARCHAR(2000),
    sourceDomain	  NVARCHAR(1000),
    category		  NVARCHAR(150),
    imageUrl		  text,
    imageWidth		  INT,
    imageHeight		  INT
)	
ON [PRIMARY]

ALTER TABLE bpst_news.documents ADD CONSTRAINT pk_documents PRIMARY KEY CLUSTERED (id);

CREATE TABLE bpst_news.documentpublishedtimes
(
    id				NCHAR(64) NOT NULL,
    [timestamp]		DATETIME NOT NULL,
    monthPrecision  DATETIME NOT NULL,
    weekPrecision	DATETIME NOT NULL,
    dayPrecision	DATETIME NOT NULL,
    hourPrecision	DATETIME NOT NULL,
    minutePrecision DATETIME NOT NULL
    );

ALTER TABLE bpst_news.documentpublishedtimes ADD CONSTRAINT pk_documentpublishedtimes PRIMARY KEY CLUSTERED (id);


CREATE TABLE bpst_news.documentingestedtimes
(
    id				NCHAR(64) NOT NULL,
    [timestamp]		DATETIME NOT NULL,
    monthPrecision  DATETIME NOT NULL,
    weekPrecision	DATETIME NOT NULL,
    dayPrecision	DATETIME NOT NULL,
    hourPrecision	DATETIME NOT NULL,
    minutePrecision DATETIME NOT NULL
);
ALTER TABLE bpst_news.documentingestedtimes ADD CONSTRAINT pk_documentingestedtimes PRIMARY KEY CLUSTERED (id);

CREATE TABLE bpst_news.documentsentimentscores
    (
    id				NCHAR(64) NOT NULL,
    score			FLOAT NOT NULL
    );

ALTER TABLE bpst_news.documentsentimentscores ADD CONSTRAINT pk_documentsentimentscores PRIMARY KEY CLUSTERED (id);


CREATE TABLE bpst_news.documentkeyphrases
(
    documentid	NCHAR(64) NOT NULL,
    phrase		NVARCHAR(2000) NOT NULL
);


CREATE TABLE bpst_news.documenttopics
(
    documentId		 NCHAR(64) NOT NULL,
    topicId			 NCHAR(36) NOT NULL,
    batchId			 NVARCHAR(40) NULL,
    documentDistance FLOAT NOT NULL,
    topicScore		 INT NOT NULL,
    topicKeyPhrase   NVARCHAR(2000) NOT NULL
);

ALTER TABLE bpst_news.documenttopics ADD CONSTRAINT pk_documenttopics PRIMARY KEY CLUSTERED (documentId, topicId);

CREATE TABLE bpst_news.documenttopicimages
(
    topicId		NCHAR(36) NOT NULL,
    imageUrl1	NVARCHAR(MAX),
    imageUrl2	NVARCHAR(MAX),
    imageUrl3	NVARCHAR(MAX),
    imageUrl4	NVARCHAR(MAX)
);

ALTER TABLE bpst_news.documenttopicimages ADD CONSTRAINT pk_documenttopicimages PRIMARY KEY CLUSTERED (topicId);

CREATE TABLE bpst_news.entities
    (
    id							BIGINT NOT NULL IDENTITY (1, 1),
    documentId					NCHAR(64) NOT NULL,
    entityType					NVARCHAR(30) NOT NULL,
    entityValue					NVARCHAR(MAX) NULL,
    offset						INT NOT NULL,
    offsetDocumentPercentage	FLOAT NOT NULL,
    [length]					INT NOT NULL
    ) ON [PRIMARY]

ALTER TABLE bpst_news.entities ADD CONSTRAINT pk_entities PRIMARY KEY CLUSTERED (id);

CREATE TABLE bpst_news.documentcompressedentities
    (
    documentId				NCHAR(64) NOT NULL,
    compressedEntitiesJson	NVARCHAR(max)
    );

ALTER TABLE bpst_news.documentcompressedentities ADD CONSTRAINT pk_documentcompressedentities PRIMARY KEY CLUSTERED (documentId);

CREATE NONCLUSTERED INDEX documentIdIndex ON bpst_news.entities (documentId);

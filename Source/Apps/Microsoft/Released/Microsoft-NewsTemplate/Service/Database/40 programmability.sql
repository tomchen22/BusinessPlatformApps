SET ANSI_NULLS              ON;
SET ANSI_PADDING            ON;
SET ANSI_WARNINGS           ON;
SET ANSI_NULL_DFLT_ON       ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET QUOTED_IDENTIFIER       ON;
go

CREATE PROCEDURE bpst_news.sp_get_replication_counts AS
BEGIN
    SET NOCOUNT ON;

    SELECT UPPER(LEFT(ta.name, 1)) + LOWER(SUBSTRING(ta.name, 2, 100)) AS EntityName, SUM(pa.[rows]) AS [Count]
    FROM sys.tables ta INNER JOIN sys.partitions pa ON pa.[OBJECT_ID] = ta.[OBJECT_ID]
                        INNER JOIN sys.schemas sc ON ta.[schema_id] = sc.[schema_id]
    WHERE
        sc.name='bpst_news' AND ta.is_ms_shipped = 0 AND pa.index_id IN (0,1) AND
        ta.name IN ('documents', 'documentpublishedtimes', 'documentingestedtimes', 'documentkeyphrases','documentsentimentscores', 'documenttopics', 'documenttopicimages', 'entities', 'documentcompressedentities')
    GROUP BY ta.name
END;
go


CREATE PROCEDURE bpst_news.sp_get_prior_content AS
BEGIN
    SET NOCOUNT ON;

    SELECT Count(*) AS ExistingObjectCount
    FROM   information_schema.tables
    WHERE  ( table_schema = 'bpst_news' AND
             table_name IN ('configuration', 'date', 'documents', 'documentpublishedtimes', 'documentingestedtimes', 'documentkeyphrases', 'documentsentimentscores', 'documenttopics', 'documenttopicimages', 'entities', 'documentcompressedentities')
           );
END;
go

-- Description:	Takes a JSON array of key phrases and writes them to the DocumentKeyPhrases table

CREATE PROCEDURE bpst_news.sp_write_key_phrases

	-- Add the parameters for the stored procedure here
	@docid NVARCHAR(64), 
	@keyPhraseJson NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO documentkeyphrases (documentId, phrase)
	SELECT @docid AS documentId, value AS phrase
	FROM OPENJSON(@keyPhraseJson)
END;
go

-- Description:	Truncates all batch process tables so batch processes can be run

CREATE PROCEDURE  bpst_news.sp_clean_batch_tables 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- These tables are populated by AzureML batch processes.  
	truncate table entities;
	truncate table documentcompressedentities;
	truncate table documenttopics;
	truncate table documenttopicimages;
END;
GO


USE [testruns]
GO

/****** Object:  StoredProcedure [dbo].[WriteKeyPhrases]    Script Date: 11/18/2016 3:51:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Microsoft
-- Description:	Takes a JSON array of key phrases and writes them to the DocumentKeyPhrases table
-- =============================================
CREATE PROCEDURE [dbo].[WriteKeyPhrases] 
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



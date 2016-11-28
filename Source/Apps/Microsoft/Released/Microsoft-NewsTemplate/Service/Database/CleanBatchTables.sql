USE [PokemonGoBrazilSouth]
GO

/****** Object:  StoredProcedure [dbo].[CleanBatchTables]    Script Date: 11/18/2016 3:49:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Microsoft
-- Description:	Truncates all batch process tables so batch processes can be run
-- =============================================
CREATE PROCEDURE [dbo].[CleanBatchTables] 
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



USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_dba_unusedTables]    Script Date: 02/11/2012 12:43:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[sp_dba_unusedTables]
as
begin
set nocount on
;WITH LastActivity (ObjectID, LastAction) AS
  (
  SELECT object_id AS TableName,
last_user_seek as LastAction
FROM sys.dm_db_index_usage_stats u
   WHERE database_id = db_id(db_name())
   UNION 
  SELECT object_id AS TableName,
last_user_scan as LastAction
FROM sys.dm_db_index_usage_stats u
   WHERE database_id = db_id(db_name())
   UNION
  SELECT object_id AS TableName,
last_user_lookup as LastAction
FROM sys.dm_db_index_usage_stats u
   WHERE database_id = db_id(db_name())
  )
  SELECT OBJECT_NAME(so.object_id) AS TableName,
MAX(la.LastAction) as LastSelect
    FROM sys.objects so
    LEFT
    JOIN LastActivity la
      ON so.object_id = la.ObjectID
   WHERE so.type = 'U'
     AND so.object_id > 100
GROUP BY OBJECT_NAME(so.object_id)
ORDER BY OBJECT_NAME(so.object_id)
end

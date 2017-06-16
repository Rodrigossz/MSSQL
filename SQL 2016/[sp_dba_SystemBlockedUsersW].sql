USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_dba_SystemBlockedUsersW]    Script Date: 02/11/2012 12:45:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_dba_SystemBlockedUsersW]
AS
BEGIN 
	Select	t1.spid ,t1.status, loginame=rtrim(t1.loginame), hostname=LEFT(rtrim(t1.hostname),20), program_name=rtrim(t1.program_name), t1.blocked,t1.dbid,
			dbname = rtrim((case when t1.dbid = 0 then null when t1.dbid <> 0 then db_name(t1.dbid) end)),rtrim(t1.nt_username)nt_username,
			rtrim(t1.cmd)cmd, 
		    datediff(minute,t1.last_batch,GETDATE()) waittime_dk,
			substring(sql.text, stmt_start/2,CASE WHEN stmt_end<1 THEN 8000 ELSE (stmt_end-stmt_start)/2 END) AS RunningSqlText, 
			sql.text as FullSqlText, 
			t1.cpu, substring( convert(varchar,t1.last_batch,111) ,6  ,5 ) + ' '
			+ substring( convert(varchar,t1.last_batch,113) ,13 ,8 )
		   as 'last_batch_time',
		   t1.waittime waittime,
		   t1.lastwaittype
	From master.dbo.sysprocesses (NOLOCK) t1
	cross apply sys.dm_exec_sql_text(t1.sql_handle) AS sql  
	Where t1.blocked <> 0 OR t1.spid in (Select t2.blocked From master.dbo.sysprocesses (NOLOCK) t2)
	Order By t1.dbid DESC,t1.spid
END 

-- Mark the SP as a system object
--
EXEC sys.sp_MS_marksystemobject sp_dba_SystemBlockedUsersW;

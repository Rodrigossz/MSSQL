----------------------------------------------------
-- CONFIGURACOES
----------------------------------------------------

exec sp_configure 'show',1;
reconfigure;
exec sp_configure 'max server memory (MB)',1536
reconfigure;
exec sp_configure 'priority boost',1;
reconfigure;
exec sp_configure 'xp_cmdshell',1;
reconfigure;
exec sp_configure 'fill factor',90;
reconfigure;
exec sp_configure 'Agent XPs',1;
reconfigure;
exec sp_configure 'Database Mail XPs',1;
reconfigure;

----------------------------------------------------
-- MODEL e TEMPDB e @@VERSION
----------------------------------------------------

ALTER DATABASE model SET 
RECOVERY SIMPLE, 
AUTO_UPDATE_STATISTICS ON, AUTO_UPDATE_STATISTICS_ASYNC ON, 
AUTO_SHRINK OFF;

ALTER DATABASE Model MODIFY FILE 
(NAME = modeldev, SIZE = 5MB,FILEGROWTH =10%);

ALTER DATABASE Model MODIFY FILE 
(NAME = modellog, SIZE = 5MB,FILEGROWTH =10%);


grant exec on sp_dba_string to public
grant exec on sp_dba_proc to public
grant exec on sp_dba_job to public
grant exec on sp_dba_proc2 to public
grant exec on sp_dba_help to public
grant exec on sp_helpindex2 to public


if @@SERVERNAME not like '%PROD%' -- VAI DAR ERRO NOS SYSTEM DATABASES
exec sp_msforeachdb 'alter database ? set AUTO_SHRINK ON'

-- DBA STUFF
create database DbaDb on
( NAME = DbaDbDev1 , FILENAME = 'd:\DBA\SQLFiles\DBA_PP_GXC1.mdf', size = 50,FILEGROWTH =10% ),
( NAME = DbaDbDev2 , FILENAME = 'e:\DBA\SQLFiles\DBA_PP_GXC2.ndf', size = 50,FILEGROWTH =10% ) LOG ON
( NAME = DbaDbLog1 , FILENAME = 'f:\DBA\SQLFiles\DBA_PP_GXC1.ldf', size = 50,FILEGROWTH =10% )
go

alter login sa enable;
alter login sa with password = 'Ech<99oL',DEFAULT_DATABASE = dbaDb;
create login dba with password = 'Ech<99oL', DEFAULT_DATABASE = dbaDb;
EXECUTE sp_addsrvrolemember @loginame = N'dba', @rolename = N'sysadmin';

ALTER AUTHORIZATION ON DATABASE::ClienteDb TO sa;
ALTER AUTHORIZATION ON DATABASE::FidelidadeDb TO sa;
ALTER AUTHORIZATION ON DATABASE::CommonDb TO sa;
ALTER AUTHORIZATION ON DATABASE::TicketDb TO sa;
ALTER AUTHORIZATION ON DATABASE::DbaDb TO sa;


--exec xp_cmdshell 'mkdir i:\Dba'
--exec xp_cmdshell 'mkdir i:\Dba\Dados'
--exec xp_cmdshell 'mkdir J:\Dba'
--exec xp_cmdshell 'mkdir J:\Dba\Dados'
--exec xp_cmdshell 'mkdir K:\Dba'
--exec xp_cmdshell 'mkdir K:\Dba\Dados'
--exec xp_cmdshell 'mkdir K:\Dba\Backup'
exec xp_cmdshell 'mkdir c:\Dba\Backup\DBPPODS001' -- OLHA O NOME! ACERTAR!


-- tempdb
ALTER DATABASE tempdb MODIFY FILE ( NAME = tempdev , FILENAME = 'd:\DBA\SQLFiles\tempdb_PP_GXC1.mdf', size = 100,FILEGROWTH =10% )
ALTER DATABASE tempdb add FILE ( NAME = tempdev2 , FILENAME = 'e:\DBA\SQLFiles\tempdb_PP_GXC2.ndf', size = 100,FILEGROWTH =10% )
ALTER DATABASE tempdb MODIFY FILE ( NAME = templog , FILENAME = 'f:\DBA\SQLFiles\tempdb_PP_GXC1.ldf', size = 100,FILEGROWTH =10% )


EXEC sp_ms_marksystemobject 'SP_GETOBJECTS'  

select @@VERSION
select 'A VERSAO TEM Q SER: Microsoft SQL Server 2008 R2 (RTM) - 10.50.1746.0 (X64)'

/*
----------------------------------------------------
-- LOGINS E ROLES E DIRET�RIOS
----------------------------------------------------
if @@SERVERNAME like '%DEV%'
begin
create login [GRUPOXANGO\GP_DEV] from windows
create login [GRUPOXANGO\IIS_DEV] from windows
end

if @@SERVERNAME like '%INT%'
begin
create login [GRUPOXANGO\GP_INT] from windows
create login [GRUPOXANGO\IIS_INT] from windows
end

-- CLIENTE!!!
use ClienteDb;

-- SEMPRE TEM
create role GxcDbRole;
grant execute to GxcDbRole;


if @@SERVERNAME like '%DEV%'
begin
if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\IIS_DEV')
create user [GRUPOXANGO\IIS_DEV] from login [GRUPOXANGO\IIS_DEV];
else
ALTER USER [GRUPOXANGO\IIS_DEV] WITH LOGIN = [GRUPOXANGO\IIS_DEV];

if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\GP_DEV')
create user [GRUPOXANGO\GP_DEV] from login [GRUPOXANGO\GP_DEV];
else
ALTER USER [GRUPOXANGO\GP_DEV] WITH LOGIN = [GRUPOXANGO\GP_DEV];

-- SEMPRE TEM,MAS O NOME MUDA
exec sp_addrolemember 'GxcDbRole','GRUPOXANGO\IIS_DEV';

-- S� em DEV
create role GxcDbRoleDev;
grant select to GxcDbRoleDev;
grant execute to GxcDbRoleDev;
grant VIEW DEFINITION  to GxcDbRoleDev;
exec sp_addrolemember 'GxcDbRoleDev','GRUPOXANGO\GP_DEV';
end -- DEV

if @@SERVERNAME like '%INT%'
begin
if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\IIS_INT')
create user [GRUPOXANGO\IIS_INT] from login [GRUPOXANGO\IIS_INT];
else
ALTER USER [GRUPOXANGO\IIS_INT] WITH LOGIN = [GRUPOXANGO\IIS_INT];

if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\GP_INT')
create user [GRUPOXANGO\GP_INT] from login [GRUPOXANGO\GP_INT];
else
ALTER USER [GRUPOXANGO\GP_INT] WITH LOGIN = [GRUPOXANGO\GP_INT];

-- SEMPRE TEM,MAS O NOME MUDA
exec sp_addrolemember 'GxcDbRole','GRUPOXANGO\IIS_INT';
end -- INT


-- Fidelidade!!!
use FidelidadeDb;

-- SEMPRE TEM
create role GxcDbRole;
grant execute to GxcDbRole;


if @@SERVERNAME like '%DEV%'
begin
if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\IIS_DEV')
create user [GRUPOXANGO\IIS_DEV] from login [GRUPOXANGO\IIS_DEV];
else
ALTER USER [GRUPOXANGO\IIS_DEV] WITH LOGIN = [GRUPOXANGO\IIS_DEV];

if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\GP_DEV')
create user [GRUPOXANGO\GP_DEV] from login [GRUPOXANGO\GP_DEV];
else
ALTER USER [GRUPOXANGO\GP_DEV] WITH LOGIN = [GRUPOXANGO\GP_DEV];

-- SEMPRE TEM,MAS O NOME MUDA
exec sp_addrolemember 'GxcDbRole','GRUPOXANGO\IIS_DEV';

-- S� em DEV
create role GxcDbRoleDev;
grant select to GxcDbRoleDev;
grant execute to GxcDbRoleDev;
grant VIEW DEFINITION  to GxcDbRoleDev;
exec sp_addrolemember 'GxcDbRoleDev','GRUPOXANGO\GP_DEV';
end -- DEV

if @@SERVERNAME like '%INT%'
begin
if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\IIS_INT')
create user [GRUPOXANGO\IIS_INT] from login [GRUPOXANGO\IIS_INT];
else
ALTER USER [GRUPOXANGO\IIS_INT] WITH LOGIN = [GRUPOXANGO\IIS_INT];

if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\GP_INT')
create user [GRUPOXANGO\GP_INT] from login [GRUPOXANGO\GP_INT];
else
ALTER USER [GRUPOXANGO\GP_INT] WITH LOGIN = [GRUPOXANGO\GP_INT];

-- SEMPRE TEM,MAS O NOME MUDA
exec sp_addrolemember 'GxcDbRole','GRUPOXANGO\IIS_INT';
end -- INT


-- Common!!!
use CommonDb;

-- SEMPRE TEM
create role GxcDbRole;
grant execute to GxcDbRole;


if @@SERVERNAME like '%DEV%'
begin
if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\IIS_DEV')
create user [GRUPOXANGO\IIS_DEV] from login [GRUPOXANGO\IIS_DEV];
else
ALTER USER [GRUPOXANGO\IIS_DEV] WITH LOGIN = [GRUPOXANGO\IIS_DEV];

if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\GP_DEV')
create user [GRUPOXANGO\GP_DEV] from login [GRUPOXANGO\GP_DEV];
else
ALTER USER [GRUPOXANGO\GP_DEV] WITH LOGIN = [GRUPOXANGO\GP_DEV];

-- SEMPRE TEM,MAS O NOME MUDA
exec sp_addrolemember 'GxcDbRole','GRUPOXANGO\IIS_DEV';

-- S� em DEV
create role GxcDbRoleDev;
grant select to GxcDbRoleDev;
grant execute to GxcDbRoleDev;
grant VIEW DEFINITION  to GxcDbRoleDev;
exec sp_addrolemember 'GxcDbRoleDev','GRUPOXANGO\GP_DEV';
end -- DEV

if @@SERVERNAME like '%INT%'
begin
if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\IIS_INT')
create user [GRUPOXANGO\IIS_INT] from login [GRUPOXANGO\IIS_INT];
else
ALTER USER [GRUPOXANGO\IIS_INT] WITH LOGIN = [GRUPOXANGO\IIS_INT];

if not exists (select 1 from sys.database_principals where name =  'GRUPOXANGO\GP_INT')
create user [GRUPOXANGO\GP_INT] from login [GRUPOXANGO\GP_INT];
else
ALTER USER [GRUPOXANGO\GP_INT] WITH LOGIN = [GRUPOXANGO\GP_INT];

-- SEMPRE TEM,MAS O NOME MUDA
exec sp_addrolemember 'GxcDbRole','GRUPOXANGO\IIS_INT';
end -- INT

*/


----------------------------------------------------
-- BKP KEY
----------------------------------------------------
use ClienteDb;

if @@SERVERNAME like '%GXC%'
BACKUP SERVICE MASTER KEY TO FILE ='K:\Dba\Backup\DBDEVGXC001\service_master_key' ENCRYPTION BY PASSWORD ='GX@ng02010';


----------------------------------------------------
-- VIEWS e TABELAS de DBA
----------------------------------------------------
use master;
if exists (select 1 from sys.views where name = 'Waits')
drop view Waits
go
use master;
if exists (select 1 from sys.views where name = 'Waits2')
drop view Waits2
go

CREATE view [dbo].[Waits] AS SELECT  
wait_type, wait_time_ms / 1000. AS wait_time_s,100. * wait_time_ms / SUM(wait_time_ms) OVER() AS pct, 
ROW_NUMBER() OVER(ORDER BY wait_time_ms DESC) AS ranking ,waiting_tasks_count,max_wait_time_ms/1000 as max_wait_time_s
 FROM sys.dm_os_wait_stats
--where wait_time_ms   > 0
go

CREATE view Waits2 AS
SELECT 
wait_type,wait_time_ms / 1000.0 AS WaitS,(wait_time_ms - signal_wait_time_ms) / 1000.0 AS ResourceS,
signal_wait_time_ms / 1000.0 AS SignalS,waiting_tasks_count AS WaitCount,
100.0 * wait_time_ms / SUM (wait_time_ms) OVER() AS Percentage,
ROW_NUMBER() OVER(ORDER BY wait_time_ms DESC) AS RowNum
FROM sys.dm_os_wait_stats
WHERE wait_time_ms > 0 and wait_type NOT IN (
'CLR_SEMAPHORE', 'LAZYWRITER_SLEEP', 'RESOURCE_QUEUE', 'SLEEP_TASK',
'SLEEP_SYSTEMTASK', 'SQLTRACE_BUFFER_FLUSH', 'WAITFOR', 'LOGMGR_QUEUE',
'CHECKPOINT_QUEUE', 'REQUEST_FOR_DEADLOCK_SEARCH', 'XE_TIMER_EVENT', 'BROKER_TO_FLUSH',
'BROKER_TASK_STOP', 'CLR_MANUAL_EVENT', 'CLR_AUTO_EVENT', 'DISPATCHER_QUEUE_SEMAPHORE',
'FT_IFTS_SCHEDULER_IDLE_WAIT', 'XE_DISPATCHER_WAIT', 'XE_DISPATCHER_JOIN', 'BROKER_EVENTHANDLER',
'TRACEWRITE', 'FT_IFTSHC_MUTEX', 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP',
'BROKER_RECEIVE_WAITFOR', 'ONDEMAND_TASK_QUEUE', 'DBMIRROR_EVENTS_QUEUE',
'DBMIRRORING_CMD', 'BROKER_TRANSMITTER', 'SQLTRACE_WAIT_ENTRIES',
'SLEEP_BPOOL_FLUSH', 'SQLTRACE_LOCK');
go

if exists (select 1 from sys.tables where name = 'dbaWaitTypes')
drop table dbaWaitTypes
go

CREATE TABLE [dbo].[dbaWaitTypes] (
    [waitType] VARCHAR (50)  primary key,
    [waitDesc] VARCHAR (400) NOT NULL);



insert dbawaittypes select 'ABR','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'ASSEMBLY_LOAD','Ocorre durante o acesso exclusivo ao carregamento do assembly.'
insert dbawaittypes select 'ASYNC_DISKPOOL_LOCK','Ocorre quando h� uma tentativa de sincronizar threads paralelos que est�o executando tarefas, como cria��o ou inicializa��o de um arquivo.'
insert dbawaittypes select 'ASYNC_IO_COMPLETION','Ocorre quando uma tarefa estiver esperando a conclus�o de E/Ss.'
insert dbawaittypes select 'ASYNC_NETWORK_IO','Ocorre em grava��es de rede quando a tarefa � bloqueada por tras da rede. Verifique se o cliente esta processando dados do servidor.'
insert dbawaittypes select 'AUDIT_GROUPCACHE_LOCK','Ocorre quando h� uma espera em um bloqueio que controla o acesso a um cache especial. O cache cont�m informa��es sobre as auditorias que est�o sendo usadas para auditar cada grupo de a��es de auditoria.'
insert dbawaittypes select 'AUDIT_LOGINCACHE_LOCK','Ocorre quando h� uma espera em um bloqueio que controla o acesso a um cache especial. O cache cont�m informa��es sobre as auditorias que est�o sendo usadas para auditar grupos de a��es de auditoria de logon.'
insert dbawaittypes select 'AUDIT_ON_DEMAND_TARGET_LOCK','Ocorre quando h� uma espera em um bloqueio que � usado para garantir a inicializa��o �nica dos destinos do Evento Estendido relacionados � auditoria.'
insert dbawaittypes select 'AUDIT_XE_SESSION_MGR','Ocorre quando h� uma espera em um bloqueio que � usado para sincronizar o in�cio e a interrup��o de sess�es de Eventos Estendidos relacionadas � auditoria.'
insert dbawaittypes select 'BACKUP','Ocorre quando uma tarefa � bloqueada como parte do processamento do backup.'
insert dbawaittypes select 'BACKUP_OPERATOR','Ocorre quando uma tarefa esta aguardando uma montagem de fita. Para exibir o status da fita, consulte sys.dm_io_backup_tapes. Se uma opera��o de montagem n�o estiver pendente, esse tipo de espera podera indicar um problema de h�rdware'
insert dbawaittypes select 'BACKUPBUFFER','Ocorre quando uma tarefa de backup estiver aguardando dados ou um buffer para armazenar dados nele. Esse tipo n�o � comum, exceto quando uma tarefa estiver aguardando uma montagem de fita.'
insert dbawaittypes select 'BACKUPIO','Ocorre quando uma tarefa de backup estiver aguardando dados ou um buffer para armazenar dados nele. Esse tipo n�o � comum, exceto quando uma tarefa estiver aguardando uma montagem de fita.'
insert dbawaittypes select 'BACKUPTHREAD','Ocorre quando uma tarefa estiver esperando a conclus�o da tarefa de backup. Os tempos de espera podem ser longos, de alguns minutos at� varias horas. Se a tarefa sendo aguardada estiver em um processo de E/S, esse tipo n�o indicara um pro'
insert dbawaittypes select 'BAD_PAGE_PROCESS','Ocorre quando o registrador de pagina suspeita em segundo plano estiver tentando evitar a execu��o mais que cada cinco segundos. Paginas suspeitas em excesso causam a execu��o freq�ente do registrador.'
insert dbawaittypes select 'BROKER_CONNECTION_RECEIVE_TASK','Ocorre ao aguardar o acesso para receber uma mensagem em um ponto de extremidade de conex�o. O acesso de recep��o para o ponto de extremidade � serializado.'
insert dbawaittypes select 'BROKER_ENDPOINT_STATE_MUTEX','Ocorre quando houver conten��o para acessar o estado de um ponto de extremidade de conex�o Service Broker. O acesso ao estado das altera��es � serializado.'
insert dbawaittypes select 'BROKER_EVENTh�NDLER','Ocorre quando uma tarefa estiver aguardando o manipulador de eventos principal do Service Broker. Isso deve ocorrer muito brevemente.'
insert dbawaittypes select 'BROKER_INIT','Ocorre ao inicializar Service Broker em cada banco de dados ativo. Isso deve ocorrer raramente.'
insert dbawaittypes select 'BROKER_MASTERSTART','Ocorre quando uma tarefa estiver aguardando o manipulador de eventos principal do Service Broker para iniciar. Isso deve ocorrer muito brevemente.'
insert dbawaittypes select 'BROKER_RECEIVE_WAITFOR','Ocorre quando RECEIVE WAITFOR estiver aguardando. Isso sera comum se nenhuma mensagem estiver pronta para ser recebida.'
insert dbawaittypes select 'BROKER_REGISTERALLENDPOINTS','Ocorre durante a inicializa��o de um ponto de extremidade de conex�o do Service Broker. Isso deve ocorrer muito brevemente.'
insert dbawaittypes select 'BROKER_SERVICE','Ocorre quando a lista de destino do Service Broker que esta associada a um servi�o de destino � atualizada ou priorizada novamente.'
insert dbawaittypes select 'BROKER_SHUTDOWN','Ocorre quando h� um desligamento planejado do Service Broker. Isso deve ocorrer muito brevemente, se ocorrer.'
insert dbawaittypes select 'BROKER_TASK_STOP','Ocorre quando o manipulador de tarefa da fila do Service Broker tenta desligar a tarefa. A verifica��o do estado � serializada e deve estar em um estado de execu��o antecipadamente.'
insert dbawaittypes select 'BROKER_TO_FLUSH','Ocorre quando o liberador lento do Service Broker libera os objetos de transmiss�o na mem�ria para uma tabela de trabalho.'
insert dbawaittypes select 'BROKER_TRANSMITTER','Ocorre quando o transmissor Service Broker esta aguardando o trabalho.'
insert dbawaittypes select 'BUILTIN_h�SHKEY_MUTEX','Pode ocorrer depois de inicializa��o de inst�ncia, enquanto as estruturas de dados internos estiverem sendo inicializadas. N�o ocorrera antes que as estruturas de dados tiverem inicializado.'
insert dbawaittypes select 'CHECK_PRINT_RECORD','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'CHECKPOINT_QUEUE','Ocorre enquanto a tarefa de ponto de verifica��o aguarda a pr�xima solicita��o de ponto de verifica��o.'
insert dbawaittypes select 'CHKPT','Ocorre na inicializa��o de servidor para informar ao thread de ponto de verifica��o que ele pode iniciar.'
insert dbawaittypes select 'CLEAR_DB','Ocorre durante opera��es que alteram o estado de um banco de dados, como abrir ou fech�r um banco de dados.'
insert dbawaittypes select 'CLR_AUTO_EVENT','Ocorre quando uma tarefa executa o CLR (Common Language Runtime) e aguarda o in�cio de um determinado evento automatico. Esperas longas s�o comuns e n�o indicam um problema.'
insert dbawaittypes select 'CLR_CRST','Ocorre quando uma tarefa esta executando o CLR e aguarda a apresenta��o de uma se��o cr�tica da tarefa que esta, atualmente, sendo usada por outra tarefa.'
insert dbawaittypes select 'CLR_JOIN','Ocorre quando uma tarefa executa o CLR e aguarda o t�rmino de outra tarefa. Esse estado de espera quando h� uma jun��o entre tarefas.'
insert dbawaittypes select 'CLR_MANUAL_EVENT','Ocorre quando uma tarefa esta executando o CLR atualmente e esta aguardando um evento manual espec�fico a ser iniciado.'
insert dbawaittypes select 'CLR_MEMORY_SPY','Ocorre durante uma espera na aquisi��o de bloqueio para uma estrutura de dados que � usada para registrar todas as aloca��es de mem�ria virtual provenientes do CLR. A estrutura de dados sera bloqueada para manter sua integridade se houver'
insert dbawaittypes select 'CLR_MONITOR','Ocorre quando uma tarefa esta executando o CLR atualmente e aguardando para obter um bloqueio no monitor.'
insert dbawaittypes select 'CLR_RWLOCK_READER','Ocorre quando uma tarefa executa o CLR e aguarda um bloqueio de leitor.'
insert dbawaittypes select 'CLR_RWLOCK_WRITER','Ocorre quando uma tarefa executa o CLR e aguarda um bloqueio de gravador.'
insert dbawaittypes select 'CLR_SEMAPHORE','Ocorre quando uma tarefa executa o CLR e aguarda um semaforo.'
insert dbawaittypes select 'CLR_TASK_START','Ocorre enquanto aguarda a inicializa��o de uma tarefa de CLR ser conclu�da.'
insert dbawaittypes select 'CLRHOST_STATE_ACCESS','Ocorre quando h� uma espera para adquirir acesso exclusivo �s estruturas de dados de hospedagem de CLR. Esse tipo de espera ocorre ao configurar ou subdividir o tempo de execu��o do CLR.'
insert dbawaittypes select 'CMEMTHREAD','Ocorre quando uma tarefa esta aguardando um objeto de mem�ria protegido por thread. O tempo de espera pode aumentar quando h� conten��o provocada por varias tarefas tentando alocar mem�ria do mesmo objeto de mem�ria.'
insert dbawaittypes select 'CXPACKET','Ocorre ao tentar sincronizar o iterador de troca do processador de consulta. A redu��o do grau de paralelismo podera ser considerada se a conten��o nesse tipo de espera se tornar um problema.'
insert dbawaittypes select 'CXROWSET_SYNC','Ocorre durante um exame de intervalo paralelo.'
insert dbawaittypes select 'DAC_INIT','Ocorre enquanto a conex�o de administrador dedicada estiver inicializando.'
insert dbawaittypes select 'DBMIRROR_DBM_EVENT','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'DBMIRROR_DBM_MUTEX','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'DBMIRROR_EVENTS_QUEUE','Ocorre quando o espelh�mento de banco de dados aguarda o processamento de eventos.'
insert dbawaittypes select 'DBMIRROR_SEND','Ocorre quando uma tarefa aguarda que os registros acumulados de comunica��es na camada de rede a serem apagados possam enviar mensagens. Indica que a camada de comunica��es esta come�ando a ser sobrecarregada e a afetar a taxa de transfer�ncia de dados p espelh�mento de BD.'
insert dbawaittypes select 'DBMIRROR_WORKER_QUEUE','Indica que a tarefa de trabalh�dor de espelh�mento de banco de dados esta aguardando mais trabalho.'
insert dbawaittypes select 'DBMIRRORING_CMD','Ocorre quando uma tarefa aguarda a libera��o dos registros para o disco. Estima-se que esse estado de espera seja mantido por longos per�odos de tempo.'
insert dbawaittypes select 'DEADLOCK_ENUM_MUTEX','Ocorre quando o monitor de deadlock e sys.dm_os_waiting_tasks tentam verificar se o SQL Server n�o esta executando varias pesquisas de deadlock ao mesmo tempo.'
insert dbawaittypes select 'DEADLOCK_TASK_SEARCH','Um grande tempo de espera nesse recurso indica que o servidor esta realizando consultas na parte superior de sys.dm_os_waiting_tasks e que essas consultas est�o impedindo o monitor de deadlock de pesquisar deadlocks. Esse tipo de espera s� � usado a de deadlock. Consultas na parte superior de sys.dm_os_waiting_tasks usam DEADLOCK_ENUM_MUTEX.'
insert dbawaittypes select 'DEBUG','Ocorre durante depura��o de Transact-SQL e CLR para sincroniza��o interna.'
insert dbawaittypes select 'DISABLE_VERSIONING','Ocorre quando SQL Server pesquisa a vers�o do gerenciador de transa��es para verificar se o carimbo de data e hora da vers�o ativa mais recente � posterior ao carimbo de data e hora quando o estado come�ou a mudar.'
insert dbawaittypes select 'DISKIO_SUSPEND','Ocorre quando uma tarefa estiver esperando para acessar um arquivo quando um backup externo esta ativo.'
insert dbawaittypes select 'DISPATCHER_QUEUE_SEMAPHORE','Ocorre quando um thread do pool de dispatcher esta aguardando mais trabalho para processamento. Estima-se que o tempo para esse tipo de espera aumente quando o dispatcher estiver ocioso.'
insert dbawaittypes select 'DLL_LOADING_MUTEX','Ocorre uma vez ao aguardar a DLL do analisador XML ser carregada.'
insert dbawaittypes select 'DROPTEMP','Ocorre entre tentativas para descartar um objeto temporario caso a tentativa anterior tenh� falh�do. A dura��o da espera cresce bastante em cada tentativa de descarte com falh�.'
insert dbawaittypes select 'DTC','Ocorre quando uma tarefa estiver esperando um evento usado para gerenciar a transi��o de estado. Esse estado controla quando a recupera��o das transa��es de Microsoft Distributed Transaction Coordinator (MS DTC'
insert dbawaittypes select 'DTC_ABORT_REQUEST','Ocorre em uma sess�o de trabalh�dor de MS DTC quando a sess�o estiver aguardando para obter a propriedade de uma transa��o de MS DTC.'
insert dbawaittypes select 'DTC_RESOLVE','Ocorre quando uma tarefa de recupera��o esta aguardando o banco de dados mestre em uma transa��o de banco de dados cruzado de forma que a tarefa possa consultar o resultado da transa��o.'
insert dbawaittypes select 'DTC_STATE','Ocorre quando uma tarefa esta esperando um evento que protege as altera��es no objeto de estado global de MS DTC. Esse estado deve ser mantido para intervalos de tempo muito curtos.'
insert dbawaittypes select 'DTC_TMDOWN_REQUEST','Ocorre em uma sess�o de trabalh�dor de MS DTC quando SQL Server recebe notifica��o que o servi�o de MS DTC n�o esta dispon�vel. Primeiro, o trabalh�dor aguardara o processo de recupera��o de da transa��o distribu�da em que o trabalh�dor esta trabalh�ndo. Isso pode continuar at� a conex�o com o servi�o de MS DTC ser restabelecida.'
insert dbawaittypes select 'DTC_WAITFOR_OUTCOME','Ocorre quando as tarefas de recupera��o aguardam o MS DTC ficar ativo para ativar a resolu��o de transa��es preparadas.'
insert dbawaittypes select 'DUMP_LOG_COORDINATOR','Ocorre quando uma tarefa principal esta esperando uma subtarefa gerar dados. Em geral, esse estado n�o ocorre. Uma espera longa indica um bloqueio inesperado. A subtarefa deve ser investigada.'
insert dbawaittypes select 'DUMPTRIGGER','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'EC','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'EE_PMOLOCK','Ocorre durante a sincroniza��o de certos tipos de aloca��es de mem�ria durante execu��o de instru��o.'
insert dbawaittypes select 'EE_SPECPROC_MAP_INIT','Ocorre durante sincroniza��o da cria��o de tabela de h�sh de procedimento interno. Essa espera s� pode acontecer durante o acesso inicial da tabela de h�sh depois que a inst�ncia SQL Server � iniciada.'
insert dbawaittypes select 'ENABLE_VERSIONING','Ocorre quando SQL Server aguarda a finaliza��o de todas as transa��es de atualiza��o neste banco de dados, antes de declarar o banco de dados pronto para o estado permitido de isolamento de instant�neo. Esse estado � usado quando SQL Server ativa o isolamento de instant�neo usando a instru��o ALTER DATABASE.'
insert dbawaittypes select 'ERROR_REPORTING_MANAGER','Ocorre durante a sincroniza��o de varias inicializa��es de log de erros simult�neas.'
insert dbawaittypes select 'EXCh�NGE','Ocorre durante a sincroniza��o no iterador de troca de processador de consulta durante consultas paralelas.'
insert dbawaittypes select 'EXECSYNC','Ocorre durante consultas paralelas durante a sincroniza��o em processador de consulta em areas n�o relacionadas ao iterador de troca. Exemplos dessas areas s�o bitmaps, LOBs'
insert dbawaittypes select 'EXECUTION_PIPE_EVENT_INTERNAL','Ocorre durante a sincroniza��o entre o produtor e partes do consumidor de execu��o em lotes que s�o enviados por meio do contexto da conex�o.'
insert dbawaittypes select 'FAILPOINT','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'FCB_REPLICA_READ','Ocorre quando as leituras de um arquivo esparso de instant�neo (ou um instant�neo temporario criado por DBCC) s�o sincronizadas.'
insert dbawaittypes select 'FCB_REPLICA_WRITE','Ocorre quando o envio ou a remo��o de uma pagina de um arquivo esparso de instant�neo (ou de um instant�neo temporario criado por DBC) � sincronizado.'
insert dbawaittypes select 'FS_FC_RWLOCK','Ocorre quando h� uma espera pelo coletor de lixo do FILESTREAM para proceder de uma das seguintes maneiras: Desabilitar a coleta de lixo (usada por backup e restaura��). Ou  Executar um ciclo do coletor de lixo do FILESTREAM.'
insert dbawaittypes select 'FS_GARBAGE_COLLECTOR_SHUTDOWN','Ocorre quando o coletor de lixo do FILESTREAM esta aguardando que tarefas de limpeza sejam conclu�das.'
insert dbawaittypes select 'FS_HEADER_RWLOCK','Ocorre quando h� uma espera para adquirir acesso ao cabe�alho do FILESTREAM de um cont�iner de dados do FILESTREAM para ler ou atualizar o conte�do no arquivo de cabe�alho do FILESTREAM (Filestream.hdr.'
insert dbawaittypes select 'FS_LOGTRUNC_RWLOCK','Ocorre quando h� uma espera para adquirir acesso ao truncamento de log do FILESTREAM para proceder de uma das seguintes maneiras:'
insert dbawaittypes select 'FSA_FORCE_OWN_XACT','Ocorre quando uma opera��o de E/S de arquivo do FILESTREAM precisa associar-se � transa��o associada, mas a transa��o pertence a outra sess�o no momento.'
insert dbawaittypes select 'FSAGENT','Ocorre quando uma opera��o de E/S de arquivo FILESTREAM esta aguardando um recurso do agente do FILESTREAM que esta sendo usado por outra opera��o de E/S de arquivo.'
insert dbawaittypes select 'FSTR_CONFIG_MUTEX','Ocorre quando h� uma espera para que outra reconfigura��o de recurso do FILESTREAM seja conclu�da.'
insert dbawaittypes select 'FSTR_CONFIG_RWLOCK','Ocorre quando h� uma espera para serializar o acesso aos par�metros de configura��o do FILESTREAM.'
insert dbawaittypes select 'FT_METADATA_MUTEX','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'FT_RESTART_CRAWL','Ocorre quando um rastreamento de texto completo precisa ser reiniciado a partir do �ltimo ponto conhecido bom para recupera��o de uma falh� moment�nea. A espera deixa as tarefas do trabalh�dor em execu��o na po'
insert dbawaittypes select 'FULLTEXT GATHERER','Ocorre durante a sincroniza��o de opera��es de texto completo.'
insert dbawaittypes select 'GUARDIAN','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'HTTP_ENUMERATION','Ocorre na inicializa��o para enumerar os pontos de extremidade de HTTP para iniciar o HTTP.'
insert dbawaittypes select 'HTTP_START','Ocorre quando uma conex�o esta esperando que o HTTP conclua a inicializa��o.'
insert dbawaittypes select 'IMPPROV_IOWAIT','Ocorre quando o SQL Server aguarda que uma E/S de carregamento em massa seja conclu�da.'
insert dbawaittypes select 'INTERNAL_TESTING','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'IO_AUDIT_MUTEX','Ocorre durante a sincroniza��o de buffers de evento de rastreamento.'
insert dbawaittypes select 'IO_COMPLETION','Ocorre enquanto se espera as opera��es de E/S serem conclu�das. Esse tipo de espera geralmente representa E/Ss de pagina sem dados. As esperas de conclus�o de E/S da pagina de dados s�o exibidas como esperas PAGEIOLATCH_'
insert dbawaittypes select 'IO_RETRY','Ocorre quando uma opera��o de E/S, como uma leitura ou uma grava��o no disco, falh� devido a recursos insuficientes, e � tentada novamente.'
insert dbawaittypes select 'IOAFF_RANGE_QUEUE','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'KSOURCE_WAKEUP','Usado pela tarefa de controle de servi�o ao aguardar solicita��es do Gerenciador de Controle de Servi�os. Esperas longas est�o previstas e n�o indicam um problema.'
insert dbawaittypes select 'KTM_ENLISTMENT','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'KTM_RECOVERY_MANAGER','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'KTM_RECOVERY_RESOLUTION','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'LATCH_DT','Ocorre ao esperar uma trava de DT (destruir). Isso n�o inclui travas de buffer ou de marca��o de transa��o. Uma listagem deesperas de LATCH_* esta dispon�vel em sys.dm_os_latch_stats. Observe que sys.dm_os_latch_stats agrupa'
insert dbawaittypes select 'LATCH_EX','Ocorre ao esperar uma trava de EX (exclusivo). Isso n�o inclui travas de buffer ou de marca��o de transa��o. Uma listagem de esperas de LATCH_* esta dispon�vel em sys.dm_os_latch_stats. Observe que sys.dm_os_latch_stat'
insert dbawaittypes select 'LATCH_KP','Ocorre ao esperar uma trava de KP (manuten��). Isso n�o inclui travas de buffer ou de marca��o de transa��o. Uma listagem de esperas de LATCH_* esta dispon�vel em sys.dm_os_latch_stats. Observe que sys.dm_os_latch_stats a'
insert dbawaittypes select 'LATCH_NL','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'LATCH_SH','Ocorre ao esperar uma trava de SH (compartilh�mento). Isso n�o inclui travas de buffer ou de marca��o de transa��o. Uma listagem de esperas de LATCH_* esta dispon�vel em sys.dm_os_latch_stats. Observe que sys.dm_os_latch_stats a'
insert dbawaittypes select 'LATCH_UP','Ocorre ao esperar uma trava de UP (atualiza��o). Isso n�o inclui travas de buffer ou de marca��o de transa��o. Uma listagem de esperas de LATCH_* esta dispon�vel em sys.dm_os_latch_stats. Observe que sys.dm_os_latch_stats agrupa'
insert dbawaittypes select 'LAZYWRITER_SLEEP','Ocorre quando as tarefas lazywriter s�o suspensas. � uma medi��o do tempo gasto por tarefas em segundo plano em espera. N�o considere esse estado quando voc� estiver procurando pausas de usuario.'
insert dbawaittypes select 'LCK_M_BU','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Atualiza��o em Massa (B). Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LCK_M_IS','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Tentativa Compartilh�da (IS). Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LCK_M_IU','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Atualiza��o da Tentativa (IU). Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LCK_M_IX','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Exclusivo da Tentativa (IX). Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LCK_M_RIn_NL','Ocorre quando uma tarefa esta esperando adquirir um bloqueio NULL no valor de ch�ve atual e um bloqueio Inser��o de Intervalo entre a ch�ve atual e a anterior. Um bloqueio NULL na ch�ve � um bloqueio de libera��o instant�neo.'
insert dbawaittypes select 'LCK_M_RIn_S','Ocorre quando uma tarefa esta esperando adquirir um bloqueio compartilh�do no valor de ch�ve atual e um bloqueio Inser��o de Intervalo entre a ch�ve atual e a anterior. Para obter uma matriz de compatibilidade de bloquei'
insert dbawaittypes select 'LCK_M_RIn_U','Uma tarefa que esta esperando para adquirir um bloqueio Atualiza��o no valor de ch�ve atual e um bloqueio Inser��o de Intervalo entre a ch�ve atual e a anterior. Para obter uma matriz de compatibilidade de bloqueio, consu'
insert dbawaittypes select 'LCK_M_RIn_X','Ocorre quando uma tarefa esta esperando adquirir um bloqueio Exclusivo no valor de ch�ve atual e um bloqueio Inser��o de Intervalo entre a ch�ve atual e a anterior. Para obter uma matriz de compatibilidade de bloqueio, co'
insert dbawaittypes select 'LCK_M_RS_S','Ocorre quando uma tarefa esta esperando adquirir um bloqueio Compartilh�do no valor de ch�ve atual e um bloqueio Intervalo Compartilh�do entre a ch�ve atual e a anterior. Para obter uma matriz de compatibilidade de bloq'
insert dbawaittypes select 'LCK_M_RS_U','Ocorre quando uma tarefa esta esperando adquirir um bloqueio Atualiza��o no valor de ch�ve atual e um bloqueio Atualiza��o de Intervalo entre a ch�ve atual e a anterior. Para obter uma matriz de compatibilidade de bloquei'
insert dbawaittypes select 'LCK_M_RX_S','Ocorre quando uma tarefa esta esperando adquirir um bloqueio Compartilh�do no valor de ch�ve atual e um bloqueio Intervalo Exclusivo entre a ch�ve atual e a anterior. Para obter uma matriz de compatibilidade de bloqueio,'
insert dbawaittypes select 'LCK_M_RX_U','Ocorre quando uma tarefa esta esperando adquirir um bloqueio Atualiza��o no valor de ch�ve atual e um bloqueio Intervalo Exclusivo entre a ch�ve atual e a anterior. Para obter uma matriz de compatibilidade de bloqueio, co'
insert dbawaittypes select 'LCK_M_RX_X','Ocorre quando uma tarefa esta esperando adquirir um bloqueio Exclusivo no valor de ch�ve atual e um bloqueio Intervalo Exclusivo entre a ch�ve atual e a anterior. Para obter uma matriz de compatibilidade de bloqueio, cons'
insert dbawaittypes select 'LCK_M_S','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Compartilh�do. Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQ).'
insert dbawaittypes select 'LCK_M_SCH_M','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Modifica��o de Esquema. Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LCK_M_SCH_S','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Compartilh�mento de Esquema. Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQ).'
insert dbawaittypes select 'LCK_M_SIU','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Compartilh�do com Atualiza��o da Tentativa. Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LCK_M_SIX','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Compartilh�do com Exclusivo da Tentativa. Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQ).'
insert dbawaittypes select 'LCK_M_U','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Atualiza��o. Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LCK_M_UIX','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Atualiza��o com Exclusivo da Tentativa. Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LCK_M_X','Ocorre quando uma tarefa esta esperando para adquirir um bloqueio Exclusivo. Para obter uma matriz de compatibilidade de bloqueio, consulte sys.dm_tran_locks (Transact-SQL).'
insert dbawaittypes select 'LOGBUFFER','Ocorre quando uma tarefa esta esperando espa�o no buffer de log para armazenar um registro de log. Consistentemente, valores altos podem indicar que os dispositivos de log n�o podem acompanh�r a quantidade de log que'
insert dbawaittypes select 'LOGGENERATION','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'LOGMGR','Ocorre quando uma tarefa esta aguardando que qualquer E/S de log pendente seja conclu�da antes de desativar o log durante o fech�mento do banco de dados.'
insert dbawaittypes select 'LOGMGR_FLUSH','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'LOGMGR_QUEUE','Ocorre enquanto a tarefa de gravador de log aguarda solicita��es de trabalho.'
insert dbawaittypes select 'LOGMGR_RESERVE_APPEND','Ocorre quando uma tarefa esta esperando para verificar se o truncamento de log libera espa�o para logs, para que a tarefa possa gravar um novo registro de log. Considere aumentar o tamanho do(s) arquivo(s) de log para o banco de d'
insert dbawaittypes select 'LOWFAIL_MEMMGR_QUEUE','Ocorre ao aguardar que a mem�ria esteja dispon�vel para uso.'
insert dbawaittypes select 'MISCELLANEOUS','dentificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'MSQL_DQ','Ocorre quando uma tarefa esta aguardando que uma opera��o de consulta distribu�da seja conclu�da. Isso � usado para detectar deadlocks de aplicativo MARS (Varios Conjuntos de Resultados Ativo) potenciais.'
insert dbawaittypes select 'MSQL_XACT_MGR_MUTEX','Ocorre quando uma tarefa esta aguardando para obter a propriedade do gerenciador de transa��es de sess�o para executar uma opera��o de transa��o em n�vel de sess�o.'
insert dbawaittypes select 'MSQL_XACT_MUTEX','Ocorre durante sincroniza��o de uso de transa��o. Uma solicita��o deve adquirir o mutex antes de usar a transa��o'
insert dbawaittypes select 'MSQL_XP','Ocorre quando uma tarefa esta esperando a conclus�o de um procedimento armazenado estendido. SQL Server usa esse estado de espera para detectar deadlocks de aplicativo MARS potencial.'
insert dbawaittypes select 'MSSEARCH','Ocorre durante ch�madas de pesquisa de texto completo. Essa espera termina quando a opera��o de texto completo � conclu�da. Ela n�o indica conten��o, mas a dura��o de opera��es de texto completo.'
insert dbawaittypes select 'NET_WAITFOR_PACKET','Ocorre quando uma conex�o esta esperando um pacote de rede durante uma leitura de rede.'
insert dbawaittypes select 'OLEDB','Ocorre quando SQL Server ch�ma o provedor SQL Server Native Cliente OLE DB. Esse tipo de espera n�o � usado para sincroniza��o. Em vez disso, ele indica a dura��o de ch�madas ao provedor OLE DB.'
insert dbawaittypes select 'ONDEMAND_TASK_QUEUE','Ocorre enquanto uma tarefa em segundo plano aguarda solicita��es de tarefa de sistema de alta prioridade. Os tempos de espera longos indicam que n�o houve nenhuma solicita��o de alta prioridade a ser processa'
insert dbawaittypes select 'PAGEIOLATCH_DT','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que esta em uma solicita��o de E/S. A solicita��o de trava esta no modo Destrui��o. Esperas longas podem indicar problemas no subsistema d'
insert dbawaittypes select 'PAGEIOLATCH_EX','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que esta em uma solicita��o de E/S. A solicita��o de trava esta em modo Exclusivo. Esperas longas podem indicar problemas no subsistema de'
insert dbawaittypes select 'PAGEIOLATCH_KP','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que esta em uma solicita��o de E/S. A solicita��o de trava esta no modo Manuten��o. Esperas longas podem indicar problemas no subsistema'
insert dbawaittypes select 'PAGEIOLATCH_NL','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'PAGEIOLATCH_SH','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que esta em uma solicita��o de E/S. A solicita��o de trava esta no modo Compartilh�do. Esperas longas podem indicar problemas no subsistem'
insert dbawaittypes select 'PAGEIOLATCH_UP','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que esta em uma solicita��o de E/S. A solicita��o de trava esta no modo Atualiza��o. Esperas longas podem indicar problemas no subsistema'
insert dbawaittypes select 'PAGELATCH_DT','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que n�o esta em uma solicita��o de E/S. A solicita��o de trava esta no modo Destrui��o.'
insert dbawaittypes select 'PAGELATCH_EX','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que n�o esta em uma solicita��o de E/S. A solicita��o de trava esta em modo Exclusivo.'
insert dbawaittypes select 'PAGELATCH_KP','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que n�o esta em uma solicita��o de E/S. A solicita��o de trava esta no modo Manuten��o.'
insert dbawaittypes select 'PAGELATCH_NL','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'PAGELATCH_SH','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que n�o esta em uma solicita��o de E/S. A solicita��o de trava esta no modo Compartilh�do.'
insert dbawaittypes select 'PAGELATCH_UP','Ocorre quando uma tarefa esta esperando em uma trava por um buffer que n�o esta em uma solicita��o de E/S. A solicita��o de trava esta no modo Atualiza��o.'
insert dbawaittypes select 'PARALLEL_BACKUP_QUEUE','Ocorre ao serializar a sa�da produzida por RESTORE HEADERONLY, RESTORE FILELISTONLY ou RESTORE LABELONLY.'
insert dbawaittypes select 'PREEMPTIVE_ABR','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'PREEMPTIVE_AUDIT_ACCESS_EVENTLOG','Ocorre quando o agendador de Sistema operacional (SQLOS) SQL Server alterna para o modo preemptivo para escrever um evento de auditoria para o log de eventos do Windows.'
insert dbawaittypes select 'PREEMPTIVE_AUDIT_ACCESS_SECLOG','Ocorre quando o agendador de Sistema operacional (SQLOS) alterna para o modo preemptivo para escrever um evento de auditoria para o log de seguran�a do Windows.'
insert dbawaittypes select 'PREEMPTIVE_CLOSEBACKUPMEDIA','Ocorre quando o agendador de SQLOS alterna para o modo preventivo para fech�r a m�dia de backup.'
insert dbawaittypes select 'PREEMPTIVE_CLOSEBACKUPTAPE','Ocorre quando o agendador de SQLOS alterna para o modo preemptivo para fech�r um dispositivo de backup de fita.'
insert dbawaittypes select 'PREEMPTIVE_CLOSEBACKUPVDIDEVICE','Ocorre quando o agendador de SQLOS alterna para o modo preemptivo para fech�r um dispositivo de backup virtual.'
insert dbawaittypes select 'PREEMPTIVE_CLUSAPI_CLUSTERRESOURCECONTL','Ocorre quando o agendador de Sistema operacional (SQLOS) alterna para o modo preemptivo para executar opera��es de cluster de failover do Windows.'
insert dbawaittypes select 'PREEMPTIVE_COM_COCREATEINSTANCE','Ocorre quando o agendador de SQLOS alterna para o modo preemptivo para criar um objeto COM.'
insert dbawaittypes select 'PREEMPTIVE_SOSTESTING','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'PREEMPTIVE_STRESSDRIVER','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'PREEMPTIVE_TESTING','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'PREEMPTIVE_XETESTING','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'PRINT_ROLLBACK_PROGRESS','Usado para aguardar enquanto os processos do usuario s�o finalizados em um banco de dados que passou por transi��o usando a clausula de t�rmino ALTER DATABASE.'
insert dbawaittypes select 'QPJOB_KILL','Indica que uma atualiza��o de estat�stica automatica e ass�ncrona foi cancelada por uma ch�mada para KILL enquanto a atualiza��o estava come�ando a ser executada. O thread de t�rmino esta suspenso, esperando que ele inicie a escuta'
insert dbawaittypes select 'QPJOB_WAITFOR_ABORT','Indica que uma atualiza��o ass�ncrona de estat�sticas automatica foi cancelada por uma ch�mada a KILL quando estava sendo executada. A atualiza��o agora esta conclu�da, mas esta suspensa at� que a coordena��o de m'
insert dbawaittypes select 'QRY_MEM_GRANT_INFO_MUTEX','Ocorre quando o gerenciamento de mem�ria de execu��o de consulta tenta controlar o acesso � lista de informa��es de concess�o estaticas.'
insert dbawaittypes select 'QUERY_ERRHDL_SERVICE_DONE','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'QUERY_EXECUTION_INDEX_SORT_EVENT_OPEN','Ocorre em determinados casos quando a cria��o de �ndice offline � executada em paralelo, e os diferentes threads de trabalho que est�o classificando sincronizam o acesso aos arquivos de classifica��o.'
insert dbawaittypes select 'QUERY_NOTIFICATION_MGR_MUTEX','Ocorre durante a sincroniza��o da fila de coleta de lixo do gerenciador de notifica��o de consulta.'
insert dbawaittypes select 'QUERY_NOTIFICATION_SUBSCRIPTION_MUTEX','Ocorre durante a sincroniza��o de estado para transa��es em notifica��es de consulta.'
insert dbawaittypes select 'QUERY_NOTIFICATION_TABLE_MGR_MUTEX','Ocorre durante sincroniza��o interna no gerenciador de notifica��o de consulta.'
insert dbawaittypes select 'QUERY_NOTIFICATION_UNITTEST_MUTEX','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'QUERY_OPTIMIZER_PRINT_MUTEX','Ocorre durante sincroniza��o de produ��o de sa�da de diagn�stico do otimizador de consulta. Esse tipo de espera s� ocorrera se as configura��es de diagn�stico estiverem h�bilitadas sob a dire��o do Suporte ao Produto da Microsoft.'
insert dbawaittypes select 'QUERY_TRACEOUT','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'QUERY_WAIT_ERRHDL_SERVICE','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'RECOVER_Ch�NGEDB','Ocorre durante a sincroniza��o do status do banco de dados em espera passiva.'
insert dbawaittypes select 'REPL_CACHE_ACCESS','Ocorre durante a sincroniza��o em um cache de artigo de replica��o. Durante essas esperas, o leitor de log de replica��o entra em pausa e as instru��es DDL (linguagem de defini��o de dados) em uma tabela publicada, s�o bloqueadas.'
insert dbawaittypes select 'REPL_SCHEMA_ACCESS','Ocorre durante sincroniza��o das informa��es de vers�o do esquema de replica��o. Esse estado ocorre quando as instru��es DDL s�o executadas no objeto replicado e quando o leitor de log gera ou consome esquema com controle de vers�o com base num DDL.'
insert dbawaittypes select 'REPLICA_WRITES','Ocorre enquanto uma tarefa espera a conclus�o de grava��es de pagina em instant�neos de banco de dados ou r�plicas de DBCC.'
insert dbawaittypes select 'REQUEST_DISPENSER_PAUSE','Ocorre quando uma tarefa esta esperando a conclus�o de todas as E/Ss pendentes, de forma que a E/S para um arquivo possa ser congelada para backup de instant�neo.'
insert dbawaittypes select 'REQUEST_FOR_DEADLOCK_SEARCH','Ocorre enquanto o monitor de deadlock espera iniciar a pr�xima pesquisa de deadlock. Essa espera � prevista entre as detec��es de deadlock e, o tempo total maior nesse recurso, n�o significa que existe um problema.'
insert dbawaittypes select 'RESMGR_THROTTLED','Ocorre quando uma nova solicita��o chega e � suprimida com base na configura��o de GROUP_MAX_REQUESTS.'
insert dbawaittypes select 'RESOURCE_QUEUE','Ocorre durante a sincroniza��o de varias filas de recurso internos.'
insert dbawaittypes select 'RESOURCE_SEMAPHORE','Ocorre quando uma solicita��o de mem�ria de consulta n�o pode ser concedida imediatamente devido a outras consultas simult�neas.'
insert dbawaittypes select 'RESOURCE_SEMAPHORE_MUTEX','Ocorre enquanto uma consulta aguarda a sua solicita��o de uma reserva de thread ser atendida. Tamb�m ocorre durante a sincroniza��o de solicita��es de compila��o de consulta e concess�o de mem�r'
insert dbawaittypes select 'RESOURCE_SEMAPHORE_QUERY_COMPILE','Ocorre quando o n�mero de compila��es de consulta simult�neas atinge um limite de estrangulamento. Esperas e tempos de espera longos podem indicar compila��es excessivas, recompila��es ou plano'
insert dbawaittypes select 'RESOURCE_SEMAPHORE_SMALL_QUERY','Ocorre quando uma solicita��o de mem�ria por meio de uma pequena consulta n�o pode ser concedida imediatamente devido a outras consultas simult�neas.'
insert dbawaittypes select 'SEC_DROP_TEMP_KEY','Ocorre depois de uma falh� ao tentar descartar uma ch�ve de seguran�a temporaria antes de uma nova tentativa.'
insert dbawaittypes select 'SECURITY_MUTEX','Ocorre quando h� uma espera por mutexes que controlam o acesso � lista global de provedores criptograficos de EKM (Gerenciamento Extens�vel de Ch�ves) e � lista de escopo de sess�es de EKM.'
insert dbawaittypes select 'SEQUENTIAL_GUID','Ocorre enquanto um novo GUID seq�encial esta sendo obtido.'
insert dbawaittypes select 'SERVER_IDLE_CHECK','Ocorre durante a sincroniza��o do status ocioso da inst�ncia do SQL Server quando um monitor de recursos esta tentando declarar uma inst�ncia do SQL Server como ociosa ou tentando ativa-la.'
insert dbawaittypes select 'SHUTDOWN','Ocorre enquanto uma instru��o de desligamento aguarda o encerramento de conex�es ativas.'
insert dbawaittypes select 'SLEEP_BPOOL_FLUSH','Ocorre quando um ponto de verifica��o esta estrangulando a emiss�o de E/Ss novas para evitar o enchimento do subsistema de disco.'
insert dbawaittypes select 'SLEEP_DBSTARTUP','Ocorre durante a inicializa��o do banco de dados enquanto aguarda a recupera��o de todos os bancos de dados.'
insert dbawaittypes select 'SLEEP_DCOMSTARTUP','Ocorre uma vez no maximo durante inicializa��o de inst�ncia SQL Server enquanto aguarda a conclus�o da inicializa��o de DCOM.'
insert dbawaittypes select 'SLEEP_MSDBSTARTUP','Ocorre quando o SQL Trace aguarda o banco de dados msdb concluir a inicializa��o.'
insert dbawaittypes select 'SLEEP_SYSTEMTASK','Ocorre durante o in�cio de uma tarefa em segundo plano enquanto aguarda tempdb concluir a inicializa��o.'
insert dbawaittypes select 'SLEEP_TASK','Ocorre quando uma tarefa suspensa espera a ocorr�ncia de um evento gen�rico.'
insert dbawaittypes select 'SLEEP_TEMPDBSTARTUP','Ocorre enquanto uma tarefa espera tempdb completar a inicializa��o.'
insert dbawaittypes select 'SNI_CRITICAL_SECTION','Ocorre durante a sincroniza��o interna nos componentes de rede do SQL Server.'
insert dbawaittypes select 'SNI_HTTP_WAITFOR_0_DISCON','Ocorre durante o desligamento do SQL Server ao aguardar o encerramento de conex�es HTTP pendentes.'
insert dbawaittypes select 'SNI_LISTENER_ACCESS','Ocorre ao aguardar que os n�s NUMA (acesso n�o uniforme � mem�ria) atualizem a altera��o do estado. O acesso � altera��o de estado � serializado.'
insert dbawaittypes select 'SNI_TASK_COMPLETION','Ocorre quando h� uma espera para que todas as tarefas sejam conclu�das durante uma altera��o de estado de n� NUMA.'
insert dbawaittypes select 'SOAP_READ','Ocorre ao aguardar pela conclus�o de uma leitura de rede HTTP.'
insert dbawaittypes select 'SOAP_WRITE','Ocorre enquanto aguarda a conclus�o de uma grava��o de rede HTTP.'
insert dbawaittypes select 'SOS_CALLBACK_REMOVAL','Ocorre enquanto executa a sincroniza��o em uma lista de retorno de ch�mada para remover um retorno de ch�mada. N�o se espera que esse contador seja alterado depois que a inicializa��o do servidor �'
insert dbawaittypes select 'SOS_DISPATCHER_MUTEX','Ocorre durante a sincroniza��o interna do pool de dispatchers. Isto inclui o per�odo de ajuste do pool.'
insert dbawaittypes select 'SOS_LOCALALLOCATORLIST','Ocorre durante a sincroniza��o interna no gerenciador de mem�ria do SQL Server.'
insert dbawaittypes select 'SOS_MEMORY_USAGE_ADJUSTMENT','Ocorre quando o uso de mem�ria esta sendo ajustado entre pools.'
insert dbawaittypes select 'SOS_OBJECT_STORE_DESTROY_MUTEX','Ocorre durante sincroniza��o interna em pools de mem�ria na destrui��o de objetos do pool.'
insert dbawaittypes select 'SOS_PROCESS_AFFINITY_MUTEX','Ocorre durante a sincroniza��o de acesso para processar configura��es de afinidade.'
insert dbawaittypes select 'SOS_RESERVEDMEMBLOCKLIST','Ocorre durante a sincroniza��o interna no gerenciador de mem�ria do SQL Server.'
insert dbawaittypes select 'SOS_SCHEDULER_YIELD','Ocorre quando uma tarefa cede o agendador para a execu��o de outras tarefas. Durante essa espera, a tarefa espera que seu quantum seja renovado.'
insert dbawaittypes select 'SOS_SMALL_PAGE_ALLOC','Ocorre durante a aloca��o e a libera��o de mem�ria que � gerenciada por alguns objetos de mem�ria.'
insert dbawaittypes select 'SOS_STACKSTORE_INIT_MUTEX','Ocorre durante a sincroniza��o da inicializa��o do armazenamento interno.'
insert dbawaittypes select 'SOS_SYNC_TASK_ENQUEUE_EVENT','Ocorre quando uma tarefa � iniciada em uma maneira s�ncrona. A maioria das tarefas em SQL Server s�o iniciadas de maneira ass�ncrona, em que o controle retorna ao iniciador logo ap�s a solicita��o de t'
insert dbawaittypes select 'SOS_VIRTUALMEMORY_LOW','Ocorre quando uma aloca��o de mem�ria espera um gerenciador de recursos liberar mem�ria virtual.'
insert dbawaittypes select 'SOSHOST_EVENT','Ocorre quando um componente hospedado, como CLR, espera um objeto de sincroniza��o de evento do SQL Server.'
insert dbawaittypes select 'SOSHOST_INTERNAL','Ocorre durante a sincroniza��o de retornos de ch�mada de gerenciador de mem�ria usada por componentes hospedados, como CLR.'
insert dbawaittypes select 'SOSHOST_MUTEX','Ocorre quando um componente hospedado, como CLR, espera um objeto de sincroniza��o de mutex do SQL Server.'
insert dbawaittypes select 'SOSHOST_RWLOCK','Ocorre quando um componente hospedado, como CLR, espera um objeto de sincroniza��o de leitor-gravador de evento do SQL Server.'
insert dbawaittypes select 'SOSHOST_SEMAPHORE','Ocorre quando um componente hospedado, como CLR, espera um objeto de sincroniza��o de semaforo SQL Server.'
insert dbawaittypes select 'SOSHOST_SLEEP','Ocorre quando uma tarefa hospedada entra em suspens�o enquanto espera a ocorr�ncia de um evento gen�rico. As tarefas hospedadas s�o usadas por componentes hospedados, como CLR.'
insert dbawaittypes select 'SOSHOST_TRACELOCK','Ocorre durante a sincroniza��o de acesso para localizar fluxos.'
insert dbawaittypes select 'SOSHOST_WAITFORDONE','Ocorre quando um componente hospedado, como CLR, aguarda a conclus�o de uma tarefa.'
insert dbawaittypes select 'SQLCLR_APPDOMAIN','Ocorre enquanto CLR espera que um dom�nio de aplicativo conclua a inicializa��o.'
insert dbawaittypes select 'SQLCLR_ASSEMBLY','Ocorre enquanto aguarda o acesso � lista de assemblies carregados em appdomain.'
insert dbawaittypes select 'SQLCLR_DEADLOCK_DETECTION','Ocorre enquanto CLR aguarda a conclus�o da detec��o de deadlock.'
insert dbawaittypes select 'SQLCLR_QUANTUM_PUNISHMENT','Ocorre quando uma tarefa CLR � estrangulada porque excedeu seu quantum de execu��o. Esse estrangulamento � feito para reduzir o efeito dessa tarefa com muitos recursos em outras tarefas.'
insert dbawaittypes select 'SQLSORT_NORMMUTEX','Ocorre durante sincroniza��o interna na inicializa��o das estruturas de classifica��o internas.'
insert dbawaittypes select 'SQLSORT_SORTMUTEX','Ocorre durante sincroniza��o interna na inicializa��o das estruturas de classifica��o internas.'
insert dbawaittypes select 'SQLTRACE_BUFFER_FLUSH','Ocorre quando uma tarefa espera que, uma tarefa em segundo plano, libere buffers de rastreamento para o disco a cada quatro segundos.'
insert dbawaittypes select 'SQLTRACE_LOCK','Ocorre durante sincroniza��o em buffers de rastreamento durante um rastreamento de arquivo.'
insert dbawaittypes select 'SQLTRACE_SHUTDOWN','Ocorre enquanto o desligamento de rastreamento aguarda a conclus�o dos eventos de rastreamento pendentes.'
insert dbawaittypes select 'SQLTRACE_WAIT_ENTRIES','Ocorre enquanto uma fila de eventos SQL Trace aguarda a chegada de pacotes na fila.'
insert dbawaittypes select 'SRVPROC_SHUTDOWN','Ocorre enquanto o processo de desligamento aguarda a libera��o dos recursos internos para desligamento completo.'
insert dbawaittypes select 'TEMPOBJ','Ocorre quando os descartes de objetos temporarios s�o sincronizados. Essa espera � rara e s� acontecera se uma tarefa solicitar acesso exclusivo para descartes de tabelas temporarias.'
insert dbawaittypes select 'THREADPOOL','Ocorre quando uma tarefa estiver esperando que um trabalh�dor seja processado no sistema. Isso pode indicar que a configura��o maxima do trabalh�dor esta muito baixa ou que as execu��es em lotes'
insert dbawaittypes select 'TIMEPRIV_TIMEPERIOD','Ocorre durante a sincroniza��o interna do timer de Eventos Estendidos.'
insert dbawaittypes select 'TRACEWRITE','Ocorre quando o provedor de rastreamento do conjunto de linh�s de Rastreamento SQL aguarda que um buffer livre ou um buffer com e'
insert dbawaittypes select 'TRAN_MARKLATCH_DT','Ocorre ao esperar uma trava de modo de destrui��o em uma destrui��o de marca��o de transa��o. Essas travas s�o usadas para sincro'
insert dbawaittypes select 'TRAN_MARKLATCH_EX','Ocorre ao esperar uma trava de modo exclusiva em uma transa��o marcada. Essas travas s�o usadas para sincroniza��o de confirma��'
insert dbawaittypes select 'TRAN_MARKLATCH_KP','Ocorre ao esperar uma trava de modo de manuten��o em uma transa��o marcada. Essas travas s�o usadas para sincroniza��o de confi'
insert dbawaittypes select 'TRAN_MARKLATCH_NL','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'TRAN_MARKLATCH_SH','Ocorre ao esperar uma trava de modo compartilh�do em uma transa��o marcada. Essas travas s�o usadas para sincroniza��o de confir'
insert dbawaittypes select 'TRAN_MARKLATCH_UP','Ocorre ao esperar uma trava de modo de atualiza��o em uma transa��o marcada. Essas travas s�o usadas para sincroniza��o de confir'
insert dbawaittypes select 'TRANSACTION_MUTEX','Ocorre durante a sincroniza��o de acesso a uma transa��o por meio de varios lotes.'
insert dbawaittypes select 'UTIL_PAGE_ALLOC','Ocorre quando exames de log de transa��o aguardam que mem�ria esteja dispon�vel durante press�o da mem�ria.'
insert dbawaittypes select 'VIA_ACCEPT','Ocorre quando uma conex�o do provedor Virtual Interface Adapter (VIA) � conclu�da durante a inicializa��o.'
insert dbawaittypes select 'VIEW_DEFINITION_MUTEX','Ocorre durante a sincroniza��o no acesso �s defini��es de exibi��o em cache.'
insert dbawaittypes select 'WAIT_FOR_RESULTS','Ocorre ao esperar a ativa��o de uma notifica��o de consulta.'
insert dbawaittypes select 'WAITFOR','Ocorre como resultado de uma instru��o WAITFOR Transact-SQL. A dura��o da espera � determinada pelos par�metros da instru��o. Es'
insert dbawaittypes select 'WAITFOR_TASKSHUTDOWN','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'WAITSTAT_MUTEX','Ocorre durante a sincroniza��o de acesso � cole��o de estat�sticas usadas para popular sys.dm_os_wait_stats.'
insert dbawaittypes select 'WCC','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'WORKTBL_DROP','Ocorre ao pausar antes de tentar novamente, ap�s uma falh� no descarte de uma tabela de trabalho.'
insert dbawaittypes select 'WRITE_COMPLETION','Ocorre quando uma opera��o de grava��o esta em andamento.'
insert dbawaittypes select 'WRITELOG','Ocorre ao aguardar que uma libera��o de log seja conclu�da. As opera��es comuns que causam libera��es de log s�o pontos de verifica'
insert dbawaittypes select 'XACT_OWN_TRANSACTION','Ocorre enquanto se espera a aquisi��o da propriedade de uma transa��o.'
insert dbawaittypes select 'XACT_RECLAIM_SESSION','Ocorre enquanto se espera que o proprietario atual de uma sess�o libere a propriedade da sess�o.'
insert dbawaittypes select 'XACTLOCKINFO','Ocorre durante a sincroniza��o de acesso � lista de bloqueios para uma transa��o. Al�m da pr�pria transa��o, a lista de bloqueios � ace'
insert dbawaittypes select 'XACTWORKSPACE_MUTEX','Ocorre durante a sincroniza��o de remo��es de uma transa��o, bem como do n�mero de bloqueios de banco de dados entre os membro'
insert dbawaittypes select 'XE_BUFFERMGR_ALLPROCESSED_EVENT','Ocorre quando buffers de sess�o do Extended Events s�o liberados para destinos. Essa espera ocorre em um thread em segundo plano.'
insert dbawaittypes select 'XE_BUFFERMGR_FREEBUF_EVENT','Ocorre quando uma destas condi��es � verdadeira: Uma sess�o do Extended Events � configurada para nenhuma perda de evento. Ou As auditorias apresentam um atraso. Isso pode indicar um afunilamento de disco na unidade onde as auditorias s�o gravadas.'
insert dbawaittypes select 'XE_DISPATCHER_CONFIG_SESSION_LIST','Ocorre quando uma sess�o do Extended Events que esta usando destinos ass�ncronos � iniciada ou interrompida.'
insert dbawaittypes select 'XE_DISPATCHER_JOIN','Ocorre quando um thread em segundo plano que � usado para sess�es do Extended Events esta sendo encerrado.'
insert dbawaittypes select 'XE_DISPATCHER_WAIT','Ocorre quando um thread em segundo plano que � usado para sess�es do Extended Events esta esperando o processamento de buffers de evento.'
insert dbawaittypes select 'XE_MODULEMGR_SYNC','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'XE_OLS_LOCK','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'
insert dbawaittypes select 'XE_PACKAGE_LOCK_BACKOFF','Identificado apenas para fins informativos. N�o h� suporte. A compatibilidade futura n�o esta garantida.'

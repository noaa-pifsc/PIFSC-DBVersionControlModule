/************************************************************************************
 Filename   : deploy_dev_upgrade_v0.2.sql
 Author     :
 Purpose    : Automated upgrade script for the Database Version Control Module database, this is intended for use on the development environment
 Description: The release included: data model deployment on a blank schema
 Usage: Using Windows X open a command line window and change the directory to the SQL directory in the working copy of the repository and execute the script using the "@" syntax.  When prompted enter the server credentials in the format defined in the corresponding code comments
************************************************************************************/
SET FEEDBACK ON
SET TRIMSPOOL ON
SET VERIFY OFF
SET SQLBLANKLINES ON
SET AUTOCOMMIT OFF
SET EXITCOMMIT OFF
SET ECHO ON

WHENEVER SQLERROR EXIT 1
WHENEVER OSERROR  EXIT 1

SET DEFINE ON
-- Provide credentials in the form: USER@TNS/PASSWORD when using a TNS Name
-- Provide credentials in the form: USER/PASSWORD@HOSTNAME/SID when specifying hostname and SID values
DEFINE apps_credentials=&1
CONNECT &apps_credentials


COL spool_fname NEW_VALUE spoolname NOPRINT
SELECT 'DB_version_control_upgrade_dev_v0.2_' || TO_CHAR( SYSDATE, 'yyyymmdd' ) spool_fname FROM DUAL;
SPOOL logs/&spoolname APPEND


SET DEFINE OFF
SHOW USER;

PROMPT running DDL scripts
@upgrades/DB_version_control_DDL_DML_upgrade_v0.2.sql


DISCONNECT;

SET DEFINE ON

SPOOL OFF
EXIT

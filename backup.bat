@echo off

rem IP address for remote connection to database
set databaseIp=%1%
rem database name for remote connection to database
set databaseName=%4%
rem remote database user name
set userName=%2%
rem Remote database user pass
set userPass=%3%

set basePath=%~dp0

echo -----------------------------------------------------------------
echo                     database backup program
echo database-ip: %databaseIp% , database-name: %databaseName%    
echo user-name: %userName%  ,   user-pass: %userPass%
echo current-time: %date% %time%
echo                     info end
echo -----------------------------------------------------------------




rem file exists
if not exist %basePath%\table.config (
  echo table.config file not exist,create table.config
  mysql -h%databaseIp% -u%userName% -p%userPass% -N -e "SELECT TABLE_NAME FROM information_schema.columns WHERE TABLE_SCHEMA = '%databaseName%' GROUP BY 1 order by 1" > %basePath%\table.config
  rem  goto end
)

rem format time
for /f "tokens=2 delims==" %%a in ('wmic path win32_operatingsystem get LocalDateTime /value') do (set t=%%a)
set today=%t:~0,4%%t:~4,2%%t:~6,2%%t:~8,2%%t:~10,2%

rem basic storage path
set dirPath=E:/toDay/%today%
if not exist %dirPath%/allSQL md "%dirPath%/allSQL"


rem execute the backup command
for /f "delims=," %%i in (%basePath%\table.config) do (
  mysqldump -h%databaseIp% --user=%userName% --password=%userPass% --lock-all-tables=true --result-file=%dirPath%/allSQL/%%i.sql %databaseName% %%i
)

rem export table structures and functions
rem there is a problem with this command
rem mysqldump -d -r %databaseName% -h%databaseIp% --user=%userName% -password=%userPass% --result-file=%dirPath%/allSQL/allStructuresAndFunctions.sql

rem copy the file to the latest folder
copy E:\toDay\%today%\allSQL\*.sql E:\toDay\%today%\executable.sql


:end
echo -----------------------------------------------------------------
echo current-time: %date% %time%
echo                     backup end
echo -----------------------------------------------------------------

rem pause
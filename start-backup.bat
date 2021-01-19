@echo off
rem ------------------------- author lhy -------------------------
rem echo 年:%date:~0,4%
rem echo 月:%date:~5,2%
rem echo 日:%date:~8,2%
rem echo 星期:%date:~10,6%
rem echo 时:%time:~0,2%
rem echo 分:%time:~3,2%
rem echo 秒:%time:~6,2%
rem echo 毫秒:%time:~9,2%

set "$=%temp%\Spring"
>%$% Echo WScript.Echo((new Date()).getTime())
for /f %%a in ('cscript -nologo -e:jscript %$%') do set beginTimeStamp=%%a
del /f /q %$%

rem gets the current time as the start time of the program
set beginTime=%beginTimeStamp:~0,10%


rem param1 databaseIP,param2 userName,param3 userPass,param4 databaseName
call backup.bat 192.168.13.71 root 159753 db_dev

>%$% Echo WScript.Echo((new Date()).getTime())
for /f %%a in ('cscript -nologo -e:jscript %$%') do set endTimeStamp=%%a
del /f /q %$%
rem gets the current time as the end time of the program
set endTime=%endTimeStamp:~0,10%


rem this command is no longer available after 2038-01-19 11:14:07
set /a timeCount=%endTime%-%beginTime%


rem greater than or equal to 1 hour
if %timeCount% GEQ 3600 set /a hours=%timeCount%/3600,hoursRemaining=%timeCount%%%3600

if not defined hoursRemaining (
    set hoursRemaining=%timeCount%
)


if %hoursRemaining% GEQ 59 (
    set /a minutes=%hoursRemaining%/60,seconds=%hoursRemaining%%%60
) else (
    set minutes=0
	set seconds=%hoursRemaining%
)

if defined hours (
    echo The program is running:%hours% h %minutes% m %seconds% s
) else (
    echo The program is running:%minutes% m %seconds% s
)

pause
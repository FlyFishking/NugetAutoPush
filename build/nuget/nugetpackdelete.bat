@REM echo 当前盘符：%~d0
@REM echo 当前路径：%cd%
@REM echo 当前执行命令行：%0
@REM echo 当前bat文件路径：%~dp0
@REM echo 当前bat文件短路径：%~sdp0

@ECHO OFF 
SET ROOT=%~dp0
SET CONFIG_FILE=%ROOT%nugetpack.properties
SET NUGETEXECUTE= %ROOT%nuget.exe

IF NOT EXIST %NUGETEXECUTE% GOTO exit

FOR /F "tokens=1,2 delims==" %%i IN (%CONFIG_FILE%) DO ( SET %%i=%%j)

%NUGETEXECUTE% list -Source %NUGETSERVER%
SET /p PACKAGENAMEVERSION="Enter package name and version:":
@REM 输出命令结果
@REM FOR /F "delims=" %%i IN ('%NUGETEXECUTE% list -Source %NUGETSERVER%') DO ( echo %%i )
%NUGETEXECUTE% delete %PACKAGENAMEVERSION% %NUGETKEY% -Source %NUGETSERVER%

IF ERRORLEVEL 1 goto erroroccour
IF ERRORLEVEL 0 goto success

:nuget-delete
%NUGETEXECUTE% delete nugetpackagename 1.0.0 %NUGETKEY% -Source %NUGETSERVER%
:nuget-list
%NUGETEXECUTE% list -Source %NUGETSERVER%
:erroroccour
echo Package push error occour
@REM eixt bat
goto exit
:success
echo Package push successed!
@REM eixt bat
goto exit
:exit
echo Exist nuget
::@ECHO ON
ECHO.
PAUSE

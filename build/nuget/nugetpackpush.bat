@REM echo 当前盘符：%~d0
@REM echo 当前路径：%cd%
@REM echo 当前执行命令行：%0
@REM echo 当前bat文件路径：%~dp0
@REM echo 当前bat文件短路径：%~sdp0

@REM $(ProjectDir)$(ProjectFileName) $(TargetName)
@REM local params setting

@ECHO OFF 
SET ROOT=%~dp0
SET CONFIG_FILE=%ROOT%nugetpack.properties
SET NUGETEXECUTE= %ROOT%nuget.exe
SET LOCALOUTPUTPATH=%ROOT%Packerback

:: check params is validated

IF NOT EXIST %NUGETEXECUTE% GOTO exit
IF NOT EXIST %LOCALOUTPUTPATH% MD %LOCALOUTPUTPATH%
IF NOT EXIST %LOCALOUTPUTPATH%\Temp MD %LOCALOUTPUTPATH%\Temp

FOR /F "tokens=1,2 delims==" %%i IN (%CONFIG_FILE%) DO ( SET %%i=%%j)

%NUGETEXECUTE% pack %1  -Build -Prop Configuration=%Configuration% -OutputDirectory %LOCALOUTPUTPATH%\Temp
%NUGETEXECUTE% push %LOCALOUTPUTPATH%\Temp\*.nupkg %NUGETKEY% -Source %NUGETSERVER%
MOVE %LOCALOUTPUTPATH%\Temp\*.nupkg %LOCALOUTPUTPATH%

IF ERRORLEVEL 1 goto erroroccour
IF ERRORLEVEL 0 goto success
:nuget-pack
%NUGETEXECUTE% pack %1  -Build -Prop Configuration=Release -o %LOCALOUTPUTPATH%\Temp
:nuget-push
%NUGETEXECUTE% push %LOCALOUTPUTPATH%\Temp\*.nupkg %NUGETKEY% -Source %NUGETSERVER%
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
::PAUSE

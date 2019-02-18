@echo off

pushd "%~dp0"

IF "%1" == "" (
    
    ECHO.
    ECHO [Input Error!] - Please, input CEF standard distribution link. 
    ECHO For example,
    ECHO .\01_clone.bat http://opensource.spotify.com/cefbuilds/cef_binary_3.3626.1882.g8926126_windows32.tar.bz2
    ECHO. 

    GOTO END
)

SET FILE_URL=%1

::FILE URL을 읽고 필요한 값 설정
FOR %%i IN ("%FILE_URL%") DO (

ECHO filedrive=%%~di
ECHO filepath=%%~pi
ECHO filename=%%~ni
ECHO fileextension=%%~xi

SET FILE_NAME=%%~ni%%~xi
SET FULL_TAR_NAME=%%~ni%%~xi
SET TAR_NAME=%%~ni
SET FILE_NAME_PRE=%%~ni
)

FOR %%i IN ("%FILE_NAME_PRE%") DO (
SET FOLDER_NAME=%%~ni
)

ECHO.
ECHO ---------------------
ECHO 01_clone start!
ECHO ---------------------
ECHO.
ECHO FILE_URL=%FILE_URL%
ECHO FILE_NAME=%FILE_NAME%
ECHO FOLDER_NAME=%FOLDER_NAME%
ECHO FULL_TAR_NAME=%FULL_TAR_NAME%
ECHO TAR_NAME=%TAR_NAME%


::파일 다운로드
Powershell -Command "& {Invoke-WebRequest -Uri '%FILE_URL%' -OutFile '%FILE_NAME%'}"

::압축 해제
.\7zip\7za.exe x %FULL_TAR_NAME%
.\7zip\7za.exe x -aoa %TAR_NAME%
MOVE .\%FOLDER_NAME% cef_tar

::cef_version.txt에 버전 정보 기록하고
::cef 폴더에 복사
ECHO %FOLDER_NAME% > cef_version.txt
SET SOURCE_CEF=.
SET DEST_CEF=.\cef\
mkdir %DEST_CEF%
XCOPY /y %SOURCE_CEF%\cef_version.txt %DEST_CEF%

:END
popd
@echo on


@echo off

pushd "%~dp0"

IF "%1" == "" (
    
    ECHO.
    ECHO [Input Error!] - Please, input CEF standard distribution link. 
    ECHO For example,
    ECHO .\Start.bat http://opensource.spotify.com/cefbuilds/cef_binary_3.3626.1882.g8926126_windows32.tar.bz2
    ECHO. 

    GOTO END
)

set FILE_URL=%1

set /P AREYOUSURE=[%FILE_URL%] Are you sure (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

echo [ 01_clone.bat ]
call .\01_clone.bat %FILE_URL%

echo [ 02_build.bat ]
call .\02_build.bat

echo [ 03_copy.bat ]
call .\03_copy.bat

:END
popd
@echo on


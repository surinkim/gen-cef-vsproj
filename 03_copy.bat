@echo off
pushd "%~dp0"

ECHO.
ECHO ---------------------
ECHO 03_copy start!
ECHO ---------------------
ECHO.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::[STEP 01] copy cef include
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ECHO -- [STEP 01] copy cef include

SET SOURCE_INCLUDE=.\cef_tar\include
SET DEST_INCLUDE=.\cef\include

mkdir %DEST_INCLUDE%
XCOPY /y /s %SOURCE_INCLUDE% %DEST_INCLUDE%

ECHO -- [STEP 01] done


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::[STEP 02] copy manifest
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ECHO -- [STEP 02] copy manifest

SET SOURCE_MANIFEST=.\cef_tar\tests\cefclient\resources\win
SET DEST_MANIFEST=.\cef\manifest

mkdir %DEST_MANIFEST%
XCOPY /y %SOURCE_MANIFEST%\compatibility.manifest %DEST_MANIFEST%

ECHO -- [STEP 02] done


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::[STEP 03] copy bin
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ECHO -- [STEP 03] copy bin

SET SOURCE_BIN_DEBUG=.\cef_tar\debug
SET DEST_BIN_DEBUG=.\cef\bin\Win32\Debug
mkdir %DEST_BIN_DEBUG%
ROBOCOPY %SOURCE_BIN_DEBUG% %DEST_BIN_DEBUG% /x /njh /np /XO /tee /DCOPY:T /S /XF "cef_sandbox.lib" "libcef.lib"


SET SOURCE_BIN_RELEASE=.\cef_tar\release
SET DEST_BIN_RELEASE=.\cef\bin\Win32\Release
mkdir %DEST_BIN_RELEASE%
ROBOCOPY %SOURCE_BIN_RELEASE% %DEST_BIN_RELEASE% /x /njh /np /XO /tee /DCOPY:T /S /XF "cef_sandbox.lib" "libcef.lib"

SET SOURCE_BIN_RESOURCES=.\cef_tar\Resources
SET DEST_BIN_RESOURCES=.\cef\bin\Win32\\Resources
mkdir %DEST_BIN_RESOURCES%
XCOPY /y /s %SOURCE_BIN_RESOURCES% %DEST_BIN_RESOURCES%

ECHO -- [STEP 03] done

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::[STEP 04] copy lib
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SET SOURCE_LIB_DEBUG=.\cef_tar\debug
SET DEST_LIB_DEBUG=.\cef\lib\Win32\Debug
mkdir %DEST_LIB_DEBUG%
XCOPY /y /s %SOURCE_LIB_DEBUG%\libcef.lib %DEST_LIB_DEBUG%


SET SOURCE_LIB_RELEASE=.\cef_tar\release
SET DEST_LIB_RELEASE=.\cef\lib\Win32\Release
mkdir %DEST_LIB_RELEASE%
XCOPY /y /s %SOURCE_LIB_RELEASE%\libcef.lib %DEST_LIB_RELEASE%


::for libcef_dll_wrapper.lib
SET SOURCE_LIB_CEF_WRAPPER=.\cef_tar\build\libcef_dll_wrapper
SET DEST_LIB_CEF_WRAPPER=.\cef\lib\Win32\
mkdir %DEST_LIB_CEF_WRAPPER%
XCOPY /y /s %SOURCE_LIB_CEF_WRAPPER%\Debug %DEST_LIB_CEF_WRAPPER%\Debug
XCOPY /y /s %SOURCE_LIB_CEF_WRAPPER%\Release %DEST_LIB_CEF_WRAPPER%\Release


ECHO -- [STEP 04] done


:END
popd
@echo on


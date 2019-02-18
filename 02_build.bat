@echo off

pushd "%~dp0"

ECHO.
ECHO ---------------------
ECHO 02_build start!
ECHO ---------------------
ECHO.

CD .\cef_tar

MKDIR build & CD build
cmake -G "Visual Studio 14 2015"  ..

call "%VS140COMNTOOLS%\vsvars32.bat"
msbuild.exe .\libcef_dll_wrapper\libcef_dll_wrapper.vcxproj /t:Rebuild /p:Configuration=Debug;Platform=x86
msbuild.exe .\libcef_dll_wrapper\libcef_dll_wrapper.vcxproj /t:Rebuild /p:Configuration=Release;Platform=x86

:END
popd
@echo on


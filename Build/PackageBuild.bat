@echo off

echo ============================================
echo ==== NMKD'S FLOWFRAMES PACKAGING SCRIPT ====
echo ============================================
echo.

set "ver=%1"
set "packSlim=%2"
set "packFull=%3"
set "packWebBase=%4"

if "%ver%"=="" set /p ver="Enter the version number: "
if "%packSlim%"=="" set /p packSlim="Package Slim (no Pytorch) archive? (Y/N) "
if "%packFull%"=="" set /p packFull="Package Full (with Pytorch for Ampere and older) archive? (Y/N) "
if "%packWebBase%"=="" set /p packWebBase="Package web installer (base.7z) file? (Y/N) "

cd ..\CodeLegacy\bin\x64\Release

rmdir /s/q FlowframesApp%ver%
mkdir "FlowframesApp%ver%"
mkdir "FlowframesApp%ver%/FlowframesData"
mkdir "FlowframesApp%ver%/FlowframesData/pkgs"

rem xcopy "../../../../pkgs" "FlowframesApp%ver%/FlowframesData\pkgs\" /E
xcopy "../../../../pkgs/av" "FlowframesApp%ver%/FlowframesData\pkgs\av" /E /I
xcopy "../../../../pkgs/dain-ncnn" "FlowframesApp%ver%/FlowframesData\pkgs\dain-ncnn" /E /I
xcopy "../../../../pkgs/licenses" "FlowframesApp%ver%/FlowframesData\pkgs\licenses" /E /I
xcopy "../../../../pkgs/rife-cuda" "FlowframesApp%ver%/FlowframesData\pkgs\rife-cuda" /E /I
xcopy "../../../../pkgs/rife-ncnn" "FlowframesApp%ver%/FlowframesData\pkgs\rife-ncnn" /E /I
xcopy "../../../../pkgs/flavr-cuda" "FlowframesApp%ver%/FlowframesData\pkgs\flavr-cuda" /E /I
xcopy "../../../../pkgs/xvfi-cuda" "FlowframesApp%ver%/FlowframesData\pkgs\xvfi-cuda" /E /I
xcopy "../../../../pkgs/rife-ncnn-vs" "FlowframesApp%ver%/FlowframesData\pkgs\rife-ncnn-vs" /E /I

echo %ver% >> "FlowframesApp%ver%/FlowframesData/ver.ini"

xcopy Flowframes.exe "FlowframesApp%ver%"

cd ../../../../Build

rmdir /s/q ..\CodeLegacy\bin\x64\Release\FlowframesApp%ver%\FlowframesData\logs
del ..\CodeLegacy\bin\x64\Release\FlowframesApp%ver%\FlowframesData\config.ini


IF /I "%packSlim%"=="Y" (
	rem PACK SLIM
	7za.exe a FF-%ver%-Slim.7z -m0=flzma2 -mx5 "..\CodeLegacy\bin\x64\Release\FlowframesApp%ver%"
)

echo 1
IF /I "%packWebBase%"=="Y" (
	echo 2
	rem PACK WEB BASE
	rem mkdir "WebInstaller/%ver%/base.7z"
	7za.exe a "WebInstaller/%ver%/base.7z" -m0=flzma2 -mx7 "..\CodeLegacy\bin\x64\Release\FlowframesApp%ver%\*"
)

IF /I "%packFull%"=="Y" (
	xcopy "../pkgs/py-amp" "..\CodeLegacy\bin\x64\Release\FlowframesApp%ver%\FlowframesData\pkgs\py-amp" /E /I
	7za.exe a FF-%ver%-Full-RTX3000.7z -m0=flzma2 -mx7 "..\CodeLegacy\bin\x64\Release\FlowframesApp%ver%"
	rmdir /s/q ..\CodeLegacy\bin\x64\Release\FlowframesApp%ver%\FlowframesData\pkgs\py-amp
)

rmdir /s/q ..\CodeLegacy\bin\x64\Release\FlowframesApp%ver%


rem pause

@echo off

set "ROOT=%~dp0"

set "TOOLS=%ROOT%tools\"

set "NVIM_APPNAME=nvim"
set "XDG_CONFIG_HOME=%ROOT%"
set "XDG_DATA_HOME=%ROOT%"

set PYTHONIOENCODING=UTF-8

set "PATH=%ROOT%nvim-bin\bin;%TOOLS%git\bin;%TOOLS%git\usr\bin;%TOOLS%w64devkit\bin;%TOOLS%;%ROOT%;%PATH%"
set "MAKE=%TOOLS%w64devkit\bin\make.exe"
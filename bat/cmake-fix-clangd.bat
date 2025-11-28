@echo off

@REM vscode use lower case drive letter, but cmake use upper case drive letter to generate compile_commands.json,
@REM that will cause clangd can't handle compile_commands.json correctly and has index error.
@REM this script will change all upper case drive letter to lower case drive letter in compile_commands.json.

cmake.exe %*
set CMAKE_RET_CODE=%ERRORLEVEL%

C:\msys64\usr\bin\bash -c "if [[ -f compile_commands.json ]]; then sed -i 's/\\([A-Z]\\):/\\L\\1:/g' compile_commands.json; fi"

exit %CMAKE_RET_CODE%

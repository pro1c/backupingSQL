set BIN=c:\cygwin\bin

for %%f in ("*.bak") do (
	call :checkFile %%f
)

exit

; all erase except:
; 1. last 3 week (24)
; 2. each 1, 8, 15, 22 day of month for last 10 week (10)
; 3. each 1, 15 day of month for last 12 month (24)

:checkFile
set CURY=%DATE:~6,4%
set CURM=%DATE:~3,2%
set CURD=%DATE:~0,2%

set F=%1
set DONLY=%F:*backup_=%
set FY=%DONLY:~0,4%
set FM=%DONLY:~5,2%
set FD=%DONLY:~8,2%

for /f "Tokens=1*" %%a in ('cscript /nologo _sss.vbs') DO set OUT=%%a 
set PY=%OUT:~0,4%
set PM=%OUT:~5,2%
set PD=%OUT:~8,2%

@rem file_20160101.bak
echo %PY%-%PM%-%PD%

exit /b

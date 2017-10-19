
for /l %%y in (2016,1,2017) do (
	for /l %%m in (1,1,12) do (
		for /l %%d in (1,1,30) do (
			call :createFile %%y %%m %%d
		)
	)
)

exit

:createFile
set M=0%2
set D=0%3
@rem GM_UT11_backup_2017_09_22_025936_9730154.bak
set fileName=GM_UT11_backup_%1_%M:~-2%_%D:~-2%_021644_5634566.bak
set cDate=%M:~-2%/%D:~-2%/%1 02:10
echo "%1%M:~-2%%D:~-2%0216" > %fileName%
set c="Get-ChildItem %fileName%| %% { $_.CreationTime = '%cDate%'}"
powershell %c%
exit /b
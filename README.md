backupingSQL
-------------------------------------------------------

Cool scripts for operate of backups files in some dir.

Requiments
---
OS Windows 10	- host system
PowerShell		- need to set creation date on tested files
CScript			- script on VBS who check file date and delete no needed file


How to do
---
1. Create files for checking.
Run "_createFiles.cmd" it create files with name like "GM_UT11_backup_2017_11_18_021644_5634566.bak" and set creation date of them.

2. Run cleaner
Run "_cleanFiles.vbs" that is clean files by rules:
'; all erase except:
'; 1. last 3 week (24)
'; 2. each 1, 8, 15, 22 day of month for last 20 week (10)
'; 3. each 1, 15 day of month for last 12 month (24)
'; 4. each first day 1, 4, 7, 10 month of year 

3. You can add "_start.cmd" to job sheduler
Create new sheduler task, set execution script to run into folder where plased backup files, set time.
You can change ">" on ">>" if you need append log.

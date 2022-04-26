set curtime=%date% %time%
git add -A
git commit -m "%curtime%"
git push master
@rem pause

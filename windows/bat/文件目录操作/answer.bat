@echo off 
xcopy /iqys test test2
cd test
copy 1.txt 1.bak
cd ..
rd /s /q test2
pause
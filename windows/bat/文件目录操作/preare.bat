@echo off
md test
cd test 
echo 1.txt > 1.txt
echo 2.txt > 2.txt
echo 3.txt > 3.txt
echo 1.txt > 1.bak
md subfolder
cd subfolder
echo sub.txt > sub.txt

#!/bin/bash
a=5
if [ $a -eq 4 ]; then
	echo "true"
elif [ $a -eq 5 ]; then
	echo "elif true"
else
	echo "false"	
fi

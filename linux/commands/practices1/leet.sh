#!/bin/bash

nums=(2 1 2 3 1 3 4)
delete_num=2
count=${#nums[*]}
point=0
for (( i = 0; i < $count; i = i+1 ));
do
	val=${nums[i]}
	if [ $val -eq $delete_num ]; then
		continue	
	else
		nums[$point]=$val
		(( point = point + 1 ))
	fi
done

for ((i=0; i < $point; i=i+1));
do
	echo ${nums[i]}
done

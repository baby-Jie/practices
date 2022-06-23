#!/bin/bash
input=replace.txt
while IFS= read -r line
do
	echo $line
done < "$input"

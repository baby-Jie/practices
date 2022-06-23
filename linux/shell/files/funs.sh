#!/bin/bash

function fileContainStr() {
	# 第一个参数为文件，第二个为字符串
	text=`cat $1`
	if [[ "$text" == *"$2"* ]]; then
		return 0
	else
		return 1
	fi
}

# 判断文件是否包含字符串数组
function fileContainStrArray() {
	# 第一个参数为文件，第二个参数为字符串数组 
	# 遍历字符串数组
	cnt=1
	for item in $@;
	do
		((cnt = cnt + 1))
		if ((cnt!=1)); then
			fileContainStr $1 $item
			if [ $? -eq 0 ]; then
				return 0
			else
				continue
			fi
		fi
	done
	return 1
}

# test fileContainStrArray
a=("smx1" "namex" "xyj")
fileContainStrArray demo.txt ${a[*]}
# fileContainStr demo.txt "smx"
if [ $? -eq 0 ]; then
	echo "contain"
else
	echo "not contain"
fi


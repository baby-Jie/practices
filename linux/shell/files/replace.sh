#!/bin/bash

# 判断文本文件是否包含某个字符串
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
read -p "please input key file:" input
read -p "please input file to replace:" demo
# input=replace.txt
# demo=demo2.txt
to_add_namespace=xmlns:localizedStrings=\"clr-namespace:Encoo.Studio.Properties\"

if [ -f $input ]; then
	true
else
	echo "$input key文件不存在"
	exit 1
fi

if [ -f $demo ]; then
	true
else
	echo "$demo 文件不存在"
	exit 1
fi

# 先把要替换的文本摘出来
keys=(`awk '{print $1}' $input`)

# 判断当前文本文件中是否包含 keys 如果没有包含则不需要处理  直接返回
fileContainStrArray $demo ${keys[*]}
if [ $? -eq 0 ]; then
	echo "$demo 包含了需要替换的文本，接下来要做替换操作..."
else
	echo "$demo 没有包含要替换的文本..."
	exit 0
fi

# 应该先判定当前文件中有没有需要转换的字符串，如果有再添加命名空间，如果没有则不需要添加
fileContainStr $demo $to_add_namespace
if [ $? -eq 0 ] ; then 
	echo "$demo 已经添加了 namespace，无需再次添加..."
else
	echo "$demo 没有添加 namespace，需要添加..."
	# 没有则添加 先简单的写：添加到第二行
	# sed "2 i $to_add_namespace" $demo
	# 在第一行行尾插入？
	sed -i "1 s/$/ ${to_add_namespace}/" $demo
fi

# 实施替换
while IFS= read -r line
do
	a=($line)
	echo ${a[0]}
	echo ${a[1]}
	sed -i "s/\"${a[0]}\"/\"{x:Static localizedStrings:Resource.${a[1]}}\"/g" $demo
done < "$input"

echo "done..."



#!/bin/bash

function fun() {
	for item in $*;
	do
		echo $item
	done
}


a=(1 2 3)
fun 1 2 3 

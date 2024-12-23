#!/bin/bash

#variable
readonly x=$hostname
echo "hi $x"

#array
arr=($x $(pwd) "prayas" "kumar")
echo "${arr[0]} ${arr[1]}"
echo "${arr[*]}"
echo "${#arr[*]}"
echo "${arr[*]:1}"
echo "${arr[*]:1:2}"
arr+=(5 6 8)
echo "${arr[*]}"

# arithmetic
i=9
let mul=5*10+$i
echo "$mul $((i++))"
echo "$i"

#for loop 
FILE="./loop.sh"
for x1 in $(cat $FILE)
do
	echo "$x1"
	let i++
	echo $i
done




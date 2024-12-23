#!/bin/bash
read -p "give url to ping: " url
ping -c 1 $url &> /dev/null
if [ $? -eq 0 ]
then
	echo "$url is working"
else
	echo "$url is not working"
fi


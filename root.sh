#!/bin/bash

userid=$UID
username=$(whoami)
if [[ $userid -eq 0 ]]
then
    echo "$username is root user"
else
    echo "$username is not a root user"
fi


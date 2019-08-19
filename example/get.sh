#!/bin/bash

key_file="key.txt"

cat $key_file | while read line
do
    key=$line
    val=`etcdctl get $line`
    if [ "$val" == "" ];then
        echo "key $key not exist!"
    else
        echo "$val"
    fi
done
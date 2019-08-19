#!/bin/bash

key_file="key.txt"

cat $key_file | while read line
do
    key=$line
    val=`etcdctl del $line`
    if [ "$val" == "0" ];then
        echo "key $key not exist!"
    else
        echo "key $key del succ!"
    fi
done
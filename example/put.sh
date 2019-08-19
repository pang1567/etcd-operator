#! /bin/bash

key_file="key.txt"
>$key_file
for((i=1;i<=10;i++));  
do   
    key=$i
    value="val_"$i
    result=`etcdctl put $key $value`
    if [ "$result" == "OK" ];then
        echo $i >> $key_file
    fi
done  
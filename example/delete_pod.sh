#!/bin/bash
log_file="log.txt"
while [ 1 ]
do
    runing_num=`kubectl get pods | grep example-etcd-cluster | grep Running | wc -l`
    if [ $runing_num -lt 5 ];then
        echo "run num $runing_num lt 5, need time rebuild!"
        sleep 1
        continue
    fi
    pod=`kubectl get pods | grep example-etcd-cluster | awk '{print $1}' | sort --random-sort | head -n 1`
    kubectl delete pods/${pod}
    echo "pod will be delete $pod" 

done
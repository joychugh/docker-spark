#!/usr/bin/env bash
export SPARK_MASTER_IP=`awk 'NR==1 {print $1}' /etc/hosts`
export SPARK_LOCAL_IP=`awk 'NR==1 {print $1}' /etc/hosts`
/opt/spark/sbin/start-master.sh -h $SPARK_LOCAL_IP "$@"
tail -f /dev/null